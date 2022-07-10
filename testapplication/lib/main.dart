import 'package:flutter/material.dart';
import 'package:testapplication/Navigation.dart';
import 'package:testapplication/vocabulary/Word.dart';
import 'package:testapplication/vocabulary/vocabulary.dart';

void main() {
  runApp(LanguageHelper());
}

class LanguageHelper extends StatefulWidget {
  LanguageHelper({super.key});
  late bool search = false;

  @override
  State<StatefulWidget> createState() => _LanguageHelper();
}

class _LanguageHelper extends State {
  bool search = false;
  TextEditingController searchController = TextEditingController();
  VocabularyList vocabularyList = VocabularyList([]);
  List<Word> words = <Word>[];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Language Helper',
      home: Scaffold(
        backgroundColor: Colors.white,
        drawer: Navigation(),
        appBar: createAppBar(),
        body: VocabularyList(words),
      ),
    );
  }

  AppBar createAppBar() {
    return AppBar(
      title:
          (search == false) ? const Text('Language Helper') : createSearchBar(),
      toolbarHeight: 70,
      actions: [
        (!search)
            ? Row(
                children: [
                  Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(boxShadow: [
                        BoxShadow(
                            blurRadius: 7,
                            spreadRadius: 3,
                            color: Colors.orange)
                      ], shape: BoxShape.circle, color: Colors.orangeAccent),
                      child: GestureDetector(
                        child: const Icon(Icons.search),
                        onTap: () {
                          search = !search;
                          setState(() {});
                        },
                      ))
                ],
              )
            : Row()
      ],
      shadowColor: Colors.black,
      backgroundColor: Colors.orange,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20))),
    );
  }

  Widget createSearchBar() {
    return TextField(
      controller: searchController,
      autofocus: true,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          hintText: "search term",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.orange))),
      onSubmitted: (value) {
        search = !search;
        searchController.clear();
        setState(() {});
      },
      onChanged: (input) async {
        List<Word> filtered = await vocabularyList.getList();
        words.clear();
        if (input != "") {
          words.addAll(
              filtered.where((element) => element.value.startsWith(input)));
        }
        setState(() {});
      },
    );
  }
}
