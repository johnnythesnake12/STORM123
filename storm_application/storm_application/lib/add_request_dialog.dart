import 'package:flutter/material.dart';
import 'package:storm_application/request.dart';
import 'package:storm_application/repository/data_repository.dart';

class AddRequestDialog extends StatefulWidget {
  const AddRequestDialog({Key? key}) : super(key: key);

  @override
  _AddRequestDialogState createState() => _AddRequestDialogState();
}

class _AddRequestDialogState extends State<AddRequestDialog> {
  String? requestTitle;
  String character = '';

  final DataRepository repository = DataRepository();

  @override
  Widget build(BuildContext context) {
    return
  }
}