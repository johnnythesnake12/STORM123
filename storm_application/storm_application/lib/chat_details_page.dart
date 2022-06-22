import 'package:flutter/material.dart';

class ChatDetailPage extends StatefulWidget{
  const ChatDetailPage({Key? key}) : super(key: key);

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Row(
            children: const [
              Icon(Icons.account_circle, size: 35),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text("John Smith"),
              )
            ],
          ),
        ),

        body: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                height: 60,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                      },
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Icon(Icons.add),
                        style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            primary: Colors.green)
                      ),
                    ),
                    //const SizedBox(width: 15,),
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Write message...",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Icon(Icons.send,color: Colors.white,size: 18,),
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        primary: Colors.green
                      ),
                    ),
                  ],

                ),
              ),
            ),
          ],
        )
    );
  }
}