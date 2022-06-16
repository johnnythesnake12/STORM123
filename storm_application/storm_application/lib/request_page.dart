import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:storm_application/repository/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:storm_application/request_card.dart';
import 'request.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({Key? key}) : super(key: key);

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  final DataRepository repository = DataRepository();
  final boldStyle = const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return _buildRequestList(context);
  }

  Widget _buildRequestList(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Request List"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: repository.getStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const LinearProgressIndicator();
          return _buildList(context, snapshot.data?.docs ?? []);
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addRequest();
        },
        tooltip: "Add Request",
      ),
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot snapshot) {
    final request = Request.fromSnapshot(snapshot);

    return RequestCard(request: request, boldStyle: boldStyle);
  }

  void _addRequest() {
    showDialog<Widget>(
      context: context,
      builder: (BuildContext context) {
        return const AddRequestDialog();
      }
    );
  }
}