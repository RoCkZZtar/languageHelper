import 'package:flutter/material.dart';
import 'package:testapplication/addition/AddButton.dart';
import 'package:testapplication/util/FileUtil.dart';
import 'package:testapplication/vocabulary/VocanularyCard.dart';
import 'package:testapplication/vocabulary/Word.dart';

class VocabularyList extends StatefulWidget {
  const VocabularyList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VocabularyList();
}

class _VocabularyList extends State {
  TextEditingController wordController = TextEditingController();
  final TextEditingController _wordController = TextEditingController();
  final TextEditingController _translationController = TextEditingController();
  List<Word> words = [];
  final FileUtil util = FileUtil();

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();

    return Column(
      children: [
        Expanded(
            child: FutureBuilder<List<Word>>(
          future: util.readFile(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return createView(snapshot.data!);
            }
            return const Text("No data");
          },
        )),
        FloatingActionButton(
          backgroundColor: Colors.blue,
          child: const Icon(Icons.add),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) => Dialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      elevation: 16,
                      child: Container(
                          padding: const EdgeInsets.all(20),
                          child: Column(children: [
                            const Center(
                                child: Text(
                              "Insert",
                              style:
                                  TextStyle(color: Colors.orange, fontSize: 20),
                            )),
                            const Padding(padding: EdgeInsets.only(top: 20)),
                            TextField(
                              controller: _wordController,
                              decoration: const InputDecoration(
                                  labelText: "Word",
                                  border: OutlineInputBorder()),
                            ),
                            const Padding(padding: EdgeInsets.only(top: 20)),
                            TextField(
                              controller: _translationController,
                              decoration: const InputDecoration(
                                  labelText: "Translation",
                                  border: OutlineInputBorder()),
                            ),
                            TextButton(
                                onPressed: () async {
                                  updateList(Word(
                                      _wordController.text,
                                      _translationController.text,
                                      false,
                                      false));
                                  _wordController.clear();
                                  _translationController.clear();
                                  setState(() {});
                                  Navigator.pop(context);
                                },
                                child: const Text("Submit")),
                          ])),
                    ));
          },
        )
      ],
    );
  }

  Widget createView(List<Word> list) => ListView.builder(
        itemCount: list.length,
        padding: const EdgeInsets.all(1.0),
        itemBuilder: (context, i) {
          return VocabularyCard(
            text: list[i],
            words: list,
          );
        },
      );

  void updateList(Word word) async {
    List<Word> temp = await util.readFile().then((value) => value);

    temp.add(word);
    util.saveFile(temp);
  }
}
