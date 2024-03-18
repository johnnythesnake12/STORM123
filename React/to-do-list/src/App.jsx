import React, { useState,useEffect } from 'react'
import Task from './Task.jsx'
import './App.css'

function App() {
  const [taskList, setTaskList] = useState([]);
  const [newTask, setNewTask] = useState("");
  useEffect(() => {
    const savedTasks = localStorage.getItem('tasks');
    console.log(savedTasks);
    if (savedTasks) {
      setTaskList(JSON.parse(savedTasks));
    }
  }, []);

  useEffect(() => {
    localStorage.setItem('tasks', JSON.stringify(taskList));
  }, [taskList]);

  function addTask() {
    if (!newTask){
      return
    }
    setTaskList(taskList=>[...taskList,newTask]);
    setNewTask("");

  }

  function deleteTask(taskToDelete) {
    setTaskList(taskList => taskList.filter(task => task !== taskToDelete))
  }
  return (
    <>
      <h1>Welcome to Johnnythesnake to do list</h1>
      <div className="task-bar">
        <input 
        type="text" 
        placeholder="Input task..." 
        style={{textAlign: 'center'}}
        value={newTask}
        onChange={(e)=>setNewTask(e.target.value)}
        />
        <button type="submit" onClick={addTask}>Add</button>
      </div>
      <div className="card">
        <h2>
          Your task list
        </h2>
        <ul>
          {taskList.map((task, index) => (
            <Task key={index} task={task} deleteTask={deleteTask} />
          ))}
        </ul>

      </div>

    </>
  )
}

export default App
