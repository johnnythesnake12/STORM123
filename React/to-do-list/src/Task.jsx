import React, { useState }  from 'react';
import './App.css';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faTrashAlt } from '@fortawesome/free-solid-svg-icons';
function Task({ task,deleteTask }) {
  return (
    <li className="task flex-task">
      <span className="task-text">{task}</span>
      <button onClick={() => deleteTask(task)}><FontAwesomeIcon icon={faTrashAlt} /></button> 
    </li>
  );
}

export default Task;