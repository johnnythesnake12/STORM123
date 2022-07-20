import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter/material.dart';
import 'package:storm_application/chat_details_page.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Contacts"),
          backgroundColor: Colors.green,
        ),
        body: StreamBuilder<List<types.Room>>(
            stream: FirebaseChatCore.instance.rooms(),
            initialData: const [],
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(
                    bottom: 200,
                  ),
                  child: const Text('No users'),
                );
              }

              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final room = snapshot.data![index];
                  return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder:(context) => ChatDetailsPage(room: room)
                            )
                        );
                      },
                      child: Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0
                          ),
                          child : Row(
                              children: [
                                _buildAvatar(room),
                                Text(room.name ?? "",
                                  style: const TextStyle(fontSize: 16),)
                              ]
                          )
                      )
                  );
                },
              );

            }
        )
    );
  }
}

Widget _buildAvatar(types.Room room) {
  return Container(
      margin: const EdgeInsets.only(right: 16),
      child: const Icon(Icons.account_circle, size: 50)
  );
}

/*
const colors = [
  Color(0xffff6767),
  Color(0xff66e0da),
  Color(0xfff5a2d9),
  Color(0xfff0c722),
  Color(0xff6a85e5),
  Color(0xfffd9a6f),
  Color(0xff92db6e),
  Color(0xff73b8e5),
  Color(0xfffd7590),
  Color(0xffc78ae5),
];
Color getUserAvatarNameColor(types.User user) {
  final index = user.id.hashCode % colors.length;
  return colors[index];
}
String getUserName(types.User user) =>
    '${user.firstName ?? ''} ${user.lastName ?? ''}'.trim();
*/