import 'package:flutter/material.dart';
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

class _VocabularyCard extends State<VocabularyCard> {
  late Word word;
  late String translation;
  FileUtil util = FileUtil();
  bool favoriteItemClicked = false;
  bool learnItemClicked = false;
  bool showTranslation = false;
  List<Word> words = [];
  late Function callback;

  @override
  void initState() {
    super.initState();
    word = widget.text;
    words = widget.words;
    callback = widget.callback;
  }

  _VocabularyCard(Word word1, List<Word> list, Function callback) {
    word = word1;
    words = list;
    learnItemClicked = word1.learning;
    favoriteItemClicked = word1.favorite;
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
      child: Container(
          height: 90,
          child: Card(
              margin: const EdgeInsets.all(3.0),
              child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  color:
                      (!showTranslation) ? Colors.orangeAccent : Colors.green,
                  height: 200,
                  width: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                          title: (!showTranslation)
                              ? Text(widget.text.value)
                              : Text(widget.text.translation),
                          trailing: FittedBox(
                            fit: BoxFit.fill,
                            child: Column(
                              children: [
                                clickableFavoriteIcon(),
                                clickableLearnItem()
                              ],
                            ),
                          )),
                    ],
                  )))),
    );
  }

  removeAsync() async {
    Future<void>.delayed(const Duration(milliseconds: 300), (() async {
      List<Word> words = await util.readFile();
      words.removeWhere((element) => element.value == word.value);
      util.saveFile(words);
    }));
  }

  Future<void> remove() async {
    List<Word> words = await util.readFile();
    words.removeWhere((element) => element.value == word.value);
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
    Word result = list.firstWhere((element) => element.value == word.value);
    favoriteItemClicked = !favoriteItemClicked;
    result.favorite = favoriteItemClicked;
    int index = list.indexWhere((element) => element.value == word.value);

    list[index] = result;
    util.saveFile(list);
  }

  Future<void> updateLearningField() async {
    List<Word> list = await util.readFile().then((value) => value);
    Word result = list.firstWhere((element) => element.value == word.value);
    learnItemClicked = !learnItemClicked;
    result.learning = learnItemClicked;
    int index = list.indexWhere((element) => element.value == word.value);

    list[index] = result;
    util.saveFile(list);
  }
}
