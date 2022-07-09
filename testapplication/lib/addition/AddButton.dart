import 'package:flutter/material.dart';
import 'package:testapplication/addition/AddPopUp.dart';
import 'package:testapplication/vocabulary/Word.dart';

class AddButton extends StatefulWidget {
  late Function callback;
  AddButton(this.callback, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddButton(callback);
}

class _AddButton extends State {
  late Function callback;

  _AddButton(this.callback);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.blue,
      child: const Icon(Icons.add),
      onPressed: () {
        showDialog(context: context, builder: (context) => AddPopUp(callback));
      },
    );
  }
}
