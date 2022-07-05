import 'package:flutter/material.dart';

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
            return Card(
              margin: EdgeInsets.all(3.0),
              child: Text(
                items[i],
                style: TextStyle(fontSize: 80),
              ),
            );
          },
        )),
        Container(
          margin: EdgeInsets.all(10),
          child: TextField(
            controller: _controller,
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
