import 'package:flutter/material.dart';
import 'package:testapplication/favoritesList/FavoriteCard.dart';
import 'package:testapplication/util/FileUtil.dart';

import '../vocabulary/Word.dart';

class LearningList extends StatefulWidget {
  LearningList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LearningList();
}

class _LearningList extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language Helper'),
        backgroundColor: Colors.orange,
      ),
      body: createView(),
    );
  }

  Widget createView() {
    return Column(
      children: [
        Expanded(
            child: FutureBuilder<List<Word>>(
          future: FileUtil().readFile(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Word> favoriteList = snapshot.data!
                  .where((element) => element.learning == true)
                  .toList();
              return createListView(favoriteList);
            }
            return const Text("No data");
          },
        ))
      ],
    );
  }

  Widget createListView(List<Word> list) => ListView.builder(
        itemCount: list.length,
        padding: const EdgeInsets.all(1.0),
        itemBuilder: (context, i) {
          return FavoriteCard(
            text: list[i],
            words: list,
          );
        },
      );
}
