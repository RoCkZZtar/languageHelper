import 'package:flutter/material.dart';
import 'package:testapplication/util/FileUtil.dart';
import 'package:testapplication/vocabulary/VocanularyCard.dart';
import 'package:testapplication/vocabulary/Word.dart';

class VocabularyList extends StatefulWidget {
  List<Word> list = <Word>[];
  VocabularyList(List<Word> words, {Key? key}) : super(key: key) {
    list = words;
  }

  @override
  State<StatefulWidget> createState() => _VocabularyList(list);

  Future<List<Word>> getList() => _VocabularyList([]).getList();
  void updateList(List<Word> items) => _VocabularyList([]).searchList(items);
}

class _VocabularyList extends State {
  TextEditingController wordController = TextEditingController();
  final TextEditingController _wordController = TextEditingController();
  final TextEditingController _translationController = TextEditingController();
  List<Word> words = [];
  final FileUtil util = FileUtil();

  _VocabularyList(List<Word> list) {
    words = list;
  }

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
              if (words.isEmpty) {
                return createView(snapshot.data!);
              } else {
                return createView(words);
              }
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
                builder: (context) => SimpleDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      elevation: 16,
                      children: [
                        Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(children: [
                              const Center(
                                  child: Text(
                                "Insert",
                                style: TextStyle(
                                    color: Colors.orange, fontSize: 20),
                              )),
                              const Padding(padding: EdgeInsets.only(top: 20)),
                              TranslationTextField(
                                wordController: _wordController,
                                text: "Word",
                              ),
                              const Padding(padding: EdgeInsets.only(top: 20)),
                              TranslationTextField(
                                  wordController: _translationController,
                                  text: "Translation"),
                              TextButton(
                                  onPressed: () async {
                                    await updateList(Word(
                                        _wordController.text,
                                        _translationController.text,
                                        false,
                                        false));
                                    _wordController.clear();
                                    _translationController.clear();
                                    callback();
                                    setState(() {});
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Submit")),
                            ]))
                      ],
                    ));
          },
        )
      ],
    );
  }

  Future<List<Word>> getList() async => await util.readFile();

  void searchList(List<Word> items) {
    words.addAll(items);
    setState(() {});
  }

  Widget createView(List<Word> list) => ListView.builder(
        itemCount: list.length,
        padding: const EdgeInsets.all(1.0),
        itemBuilder: (context, i) {
          return VocabularyCard(
            text: list[i],
            words: list,
            callback: callback,
          );
        },
      );

  Future<void> updateList(Word word) async {
    List<Word> temp = await util.readFile().then((value) => value);

    temp.add(word);
    util.saveFile(temp);
  }

  void callback() => setState(() {});
}

class TranslationTextField extends StatelessWidget {
  const TranslationTextField(
      {Key? key,
      required TextEditingController wordController,
      required String text})
      : _wordController = wordController,
        disaplyText = text,
        super(key: key);

  final TextEditingController _wordController;
  final String disaplyText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _wordController,
      decoration: InputDecoration(
          labelText: disaplyText, border: const OutlineInputBorder()),
    );
  }
}
