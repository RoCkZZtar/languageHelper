import 'package:flutter/material.dart';
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
        Container(
          margin: const EdgeInsets.all(10),
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(
                labelText: "Word", border: OutlineInputBorder()),
            onSubmitted: (String value) async {
              updateList(value);
              _controller.clear();
              setState(() {});
            },
          ),
        ),
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

  void updateList(String word) async {
    List<Word> temp = await util.readFile().then((value) => value);

    temp.add(Word(word, false, false));
    util.saveFile(temp);
  }
}
