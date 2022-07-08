import 'package:flutter/material.dart';
import 'package:testapplication/util/FileUtil.dart';
import 'package:testapplication/vocabulary/Word.dart';

class VocabularyCard extends StatefulWidget {
  Word text;
  List<Word> words;

  VocabularyCard({Key? key, required this.text, required this.words})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _VocabularyCard(text, words);
}

class _VocabularyCard extends State {
  late String text;
  FileUtil util = FileUtil();
  bool favoriteItemClicked = false;
  bool learnItemClicked = false;
  List<Word> words = [];

  _VocabularyCard(Word word, List<Word> words) {
    this.favoriteItemClicked = word.favorite;
    this.learnItemClicked = word.learning;
    this.text = word.value;
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
                    children: [clickableFavoriteIcon(), clickableLearnItem()],
                  ),
                )),
          ],
        ));
  }

  Widget clickableFavoriteIcon() {
    return IconButton(
        onPressed: () {
          updateFavoriteButton();
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
        onPressed: () {
          updateLearningField();
          setState(() {});
        },
        icon: (!learnItemClicked)
            ? const Icon(Icons.lightbulb_outlined, color: Colors.yellow)
            : const Icon(Icons.lightbulb, color: Colors.yellow));
  }

  void updateFavoriteButton() {
    Word result = words.firstWhere((element) => element.value == text);
    favoriteItemClicked = !favoriteItemClicked;
    result.favorite = favoriteItemClicked;
    int index = words.indexWhere((element) => element.value == text);

    words[index] = result;
    util.saveFile(words);
  }

  void updateLearningField() {
    Word result = words.firstWhere((element) => element.value == text);
    learnItemClicked = !learnItemClicked;
    result.learning = learnItemClicked;
    int index = words.indexWhere((element) => element.value == text);

    words[index] = result;
    util.saveFile(words);
  }
}
