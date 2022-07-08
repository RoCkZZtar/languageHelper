import 'package:flutter/material.dart';
import 'package:testapplication/favoritesList/FavoritesList.dart';
import 'package:testapplication/learningList/LearningList.dart';
import 'package:testapplication/vocabulary/Word.dart';

class Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.orangeAccent),
            child: Text("Menu", style: TextStyle(fontSize: 25)),
          ),
          ListTile(
            leading: const Icon(Icons.lightbulb),
            title: const Text("Learning"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LearningList()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text("Favorites"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => FavoriteList()));
            },
          )
        ],
      ),
    );
  }
}
