import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter/material.dart';

class ChatDetailsPage extends StatefulWidget{
  final types.Room room;

  const ChatDetailsPage({Key? key, required this.room}) : super(key: key);

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailsPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      title: const Text('Chat'),
    ),
    body: StreamBuilder<types.Room>(
      initialData: widget.room,
      stream: FirebaseChatCore.instance.room(widget.room.id),
      builder: (context, snapshot) => StreamBuilder<List<types.Message>>(
        initialData: const [],
        stream: FirebaseChatCore.instance.messages(snapshot.data!),
        builder: (context, snapshot) => Chat(
          //isAttachmentUploading: _isAttachmentUploading,
          messages: snapshot.data ?? [],
          //onAttachmentPressed: _handleAtachmentPressed,
          //onMessageTap: _handleMessageTap,
          //onPreviewDataFetched: _handlePreviewDataFetched,
          onSendPressed: _handleSendPressed,
          user: types.User(
            id: FirebaseChatCore.instance.firebaseUser?.uid ?? '',
          ),
        ),
      ),
    ),
  );

  void _handleSendPressed(types.PartialText message) {
    FirebaseChatCore.instance.sendMessage(
      message,
      widget.room.id,
    );
  }
}