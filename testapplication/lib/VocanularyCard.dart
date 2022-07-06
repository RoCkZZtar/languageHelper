import 'package:flutter/material.dart';

class VocabularyCard extends StatelessWidget {
  late String text;

  VocabularyCard({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(3.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 80),
      ),
    );
  }
}
