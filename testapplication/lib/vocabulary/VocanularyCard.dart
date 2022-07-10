import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:testapplication/Navigation.dart';
import 'package:testapplication/util/FileUtil.dart';
import 'package:testapplication/vocabulary/Word.dart';

class VocabularyCard extends StatefulWidget {
  Word text;
  List<Word> words;
  Function callback;

  VocabularyCard(
      {Key? key,
      required this.text,
      required this.words,
      required this.callback})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _VocabularyCard(text, words, callback);
}

class _VocabularyCard extends State {
  late String text;
  late String translation;
  FileUtil util = FileUtil();
  bool favoriteItemClicked = false;
  bool learnItemClicked = false;
  bool showTranslation = false;
  List<Word> words = [];
  late Function callback;

  _VocabularyCard(Word word, List<Word> words, Function callback) {
    this.favoriteItemClicked = word.favorite;
    this.learnItemClicked = word.learning;
    this.text = word.value;
    this.translation = word.translation;
    this.words = words;
    this.callback = callback;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showDialog(
            context: context,
            builder: (builder) {
              return Dialog(
                  child: TextButton(
                child: const Text("Delete"),
                onPressed: () async {
                  await remove();
                  callback();
                  Navigator.pop(context);
                },
              ));
            });
      },
      onTap: () {
        showTranslation = !showTranslation;
        callback();
      },
      child: Card(
          margin: const EdgeInsets.all(3.0),
          color: (!showTranslation) ? Colors.orangeAccent : Colors.green,
          child: Column(
            children: [
              ListTile(
                  title: (!showTranslation) ? Text(text) : Text(translation),
                  trailing: FittedBox(
                    fit: BoxFit.fill,
                    child: Column(
                      children: [clickableFavoriteIcon(), clickableLearnItem()],
                    ),
                  )),
            ],
          )),
    );
  }

  removeAsync() async {
    Future<void>.delayed(const Duration(milliseconds: 200), (() async {
      List<Word> words = await util.readFile();
      words.removeWhere((element) => element.value == text);
      util.saveFile(words);
    }));
  }

  Future<void> remove() async {
    List<Word> words = await util.readFile();
    words.removeWhere((element) => element.value == text);
    util.saveFile(words);
  }

  Widget clickableFavoriteIcon() {
    return IconButton(
        onPressed: () async {
          await updateFavoriteButton();
          setState(() {});
        },
        icon: (!favoriteItemClicked)
            ? const Icon(
                Icons.favorite_border_outlined,
                color: Colors.red,
              )
            : const Icon(
                Icons.favorite,
                color: Colors.red,
              ));
  }

  Widget clickableLearnItem() {
    return IconButton(
        onPressed: () async {
          await updateLearningField();
          setState(() {});
        },
        icon: (!learnItemClicked)
            ? const Icon(Icons.lightbulb_outlined, color: Colors.yellow)
            : const Icon(Icons.lightbulb, color: Colors.yellow));
  }

  Future<void> updateFavoriteButton() async {
    List<Word> list = await util.readFile().then((value) => value);
    Word result = list.firstWhere((element) => element.value == text);
    favoriteItemClicked = !favoriteItemClicked;
    result.favorite = favoriteItemClicked;
    int index = list.indexWhere((element) => element.value == text);

    list[index] = result;
    util.saveFile(list);
  }

  Future<void> updateLearningField() async {
    List<Word> list = await util.readFile().then((value) => value);
    Word result = list.firstWhere((element) => element.value == text);
    learnItemClicked = !learnItemClicked;
    result.learning = learnItemClicked;
    int index = list.indexWhere((element) => element.value == text);

    list[index] = result;
    util.saveFile(list);
  }
}
