import 'package:flutter/material.dart';
import 'package:testapplication/vocabulary.dart';

void main() {
  runApp(const LanguageHelper());
}

class LanguageHelper extends StatelessWidget {
  const LanguageHelper({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Language Helper',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Language Helper'),
        ),
        body: const VocabularyList(),
      ),
    );
  }
}
