import 'package:flutter/material.dart';
import 'package:testapplication/util/FileUtil.dart';
import 'package:testapplication/vocabulary/Word.dart';

class FavoriteCard extends StatefulWidget {
  Word text;
  List<Word> words;

  FavoriteCard({Key? key, required this.text, required this.words})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _FavoriteCard(text, words);
}

class _FavoriteCard extends State {
  late String text;
  FileUtil util = FileUtil();
  bool favoriteItemClicked = false;
  bool learnItemClicked = false;
  List<Word> words = [];

  _FavoriteCard(Word word, List<Word> words) {
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
