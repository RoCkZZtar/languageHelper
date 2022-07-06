import 'package:flutter/material.dart';
import 'package:testapplication/VocanularyCard.dart';

class VocabularyList extends StatefulWidget {
  const VocabularyList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VocabularyList();
}

class _VocabularyList extends State {
  TextEditingController wordController = TextEditingController();
  List<String> items = [];

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();

    return Column(
      children: [
        Expanded(
            child: ListView.builder(
          itemCount: items.length,
          padding: const EdgeInsets.all(1.0),
          itemBuilder: (context, i) {
            return VocabularyCard(text: items[i]);
          },
        )),
        Container(
          margin: const EdgeInsets.all(10),
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(
                labelText: "Word", border: OutlineInputBorder()),
            onSubmitted: (String value) {
              items.add(value);
              _controller.clear();
              setState(() {});
            },
          ),
        ),
      ],
    );
  }
}
