import 'package:flutter/material.dart';
import 'package:testapplication/util/FileUtil.dart';
import 'package:testapplication/vocabulary/Word.dart';

class AddPopUp extends StatelessWidget {
  final TextEditingController _wordController = TextEditingController();
  final TextEditingController _translationController = TextEditingController();
  final FileUtil util = FileUtil();

  late Function callback;

  AddPopUp(this.callback, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      elevation: 16,
      child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            const Center(
                child: Text(
              "Insert",
              style: TextStyle(color: Colors.orange, fontSize: 20),
            )),
            const Padding(padding: EdgeInsets.only(top: 20)),
            TextField(
              controller: _wordController,
              decoration: const InputDecoration(
                  labelText: "Word", border: OutlineInputBorder()),
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            TextField(
              controller: _translationController,
              decoration: const InputDecoration(
                  labelText: "Translation", border: OutlineInputBorder()),
            ),
            TextButton(
                onPressed: () async {
                  await updateList(Word(_wordController.text,
                      _translationController.text, false, false));
                  callback();
                  Navigator.pop(context);
                },
                child: const Text("Submit")),
          ])),
    );
  }

  Future<void> updateList(Word word) async {
    List<Word> temp = await util.readFile().then((value) => value);
    temp.add(word);
    util.saveFile(temp);
  }
}
