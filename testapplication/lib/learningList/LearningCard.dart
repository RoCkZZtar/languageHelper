import 'package:flutter/material.dart';
import 'package:testapplication/util/FileUtil.dart';
import 'package:testapplication/vocabulary/Word.dart';

class LearningCard extends StatefulWidget {
  Word text;
  List<Word> words;
  Function callback;

  LearningCard(
      {Key? key,
      required this.text,
      required this.words,
      required this.callback})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _LearningCard(text, words, callback);
}

class _LearningCard extends State {
  FileUtil util = FileUtil();
  bool showTranslation = false;
  late Word word;
  List<Word> words = [];
  late Function callback;

  _LearningCard(Word word, List<Word> words, Function callback) {
    this.word = word;
    this.words = words;
    this.callback = callback;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(3.0),
        color: (!showTranslation) ? Colors.orangeAccent : Colors.greenAccent,
        child: Column(
          children: [
            ListTile(
              title: (!showTranslation)
                  ? Text(word.value)
                  : Text(word.translation),
              trailing: FittedBox(
                fit: BoxFit.fill,
                child: Column(
                  children: [getIcon()],
                ),
              ),
              onTap: () {
                showTranslation = !showTranslation;
                callback();
              },
            ),
          ],
        ));
  }

  Icon getIcon() {
    return const Icon(
      Icons.lightbulb,
      color: Colors.yellow,
    );
  }
}
