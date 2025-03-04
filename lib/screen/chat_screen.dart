
import 'package:chatapp/widget/chat_widget.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {

  final String? apikey;
   const ChatScreen({super.key,required this.apikey,});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    

      appBar: AppBar(
       
        title:const Text("Chat Bot ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),),

        
      ),
      body: ChatWidget(apikey: widget.apikey),
      
    );
  }
}


