import 'package:flutter/material.dart';
import 'package:testapplication/favoritesList/FavoritesList.dart';
import 'package:testapplication/vocabulary/Word.dart';

class Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.orangeAccent),
            child: Text("Menu", style: TextStyle(fontSize: 25)),
          ),
          ListTile(
            leading: Icon(Icons.lightbulb),
            title: Text("Learning"),
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text("Favorites"),
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
