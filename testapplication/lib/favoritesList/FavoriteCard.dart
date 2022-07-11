import 'package:flutter/material.dart';
import 'package:testapplication/util/FileUtil.dart';
import 'package:testapplication/vocabulary/Word.dart';

class FavoriteCard extends StatefulWidget {
  Word text;
  List<Word> words;
  Function callback;

  FavoriteCard(
      {Key? key,
      required this.text,
      required this.words,
      required this.callback})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _FavoriteCard(text, words, callback);
}

class _FavoriteCard extends State {
  FileUtil util = FileUtil();
  late Word word;
  List<Word> words = [];
  bool showTranslation = false;
  late Function callback;

  _FavoriteCard(Word word, List<Word> words, Function callback) {
    this.words = words;
    this.word = word;
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
      Icons.favorite,
      color: Colors.red,
    );
  }
}
