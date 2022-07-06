import 'package:flutter/material.dart';

class VocabularyCard extends StatefulWidget {
  late String text;

  VocabularyCard({Key? key, required this.text}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VocabularyCard(text: text);
}

class _VocabularyCard extends State {
  late String text;
  bool favoriteItemClicked = false;
  bool learnItemClicked = false;

  _VocabularyCard({required this.text});

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
          setState(() {
            favoriteItemClicked = !favoriteItemClicked;
          });
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
          setState(() {
            learnItemClicked = !learnItemClicked;
          });
        },
        icon: (!learnItemClicked)
            ? const Icon(Icons.lightbulb_outlined, color: Colors.yellow)
            : const Icon(Icons.lightbulb, color: Colors.yellow));
  }
}
