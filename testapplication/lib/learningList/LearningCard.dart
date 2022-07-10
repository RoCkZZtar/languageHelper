import 'package:flutter/material.dart';
import 'package:testapplication/util/FileUtil.dart';
import 'package:testapplication/vocabulary/Word.dart';

class LearningCard extends StatefulWidget {
  Word text;
  List<Word> words;

  LearningCard({Key? key, required this.text, required this.words})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _LearningCard(text, words);
}

class _LearningCard extends State {
  late String text;
  FileUtil util = FileUtil();
  bool favoriteItemClicked = false;
  bool learnItemClicked = false;
  List<Word> words = [];

  _LearningCard(Word word, List<Word> words) {
    favoriteItemClicked = word.favorite;
    learnItemClicked = word.learning;
    text = word.value;
    this.words = words;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(3.0),
        color: Colors.orangeAccent,
        child: Column(
          children: [
            ListTile(
                title: Text(text),
                trailing: FittedBox(
                  fit: BoxFit.fill,
                  child: Column(
                    children: [getIcon()],
                  ),
                )),
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
