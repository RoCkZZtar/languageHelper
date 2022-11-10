import 'package:flutter/material.dart';
import 'package:testapplication/favoritesList/FavoritesList.dart';
import 'package:testapplication/learningList/LearningList.dart';
import 'package:testapplication/vocabulary/Word.dart';
import 'package:url_launcher/url_launcher.dart';

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
          ),
          AboutListTile(
            icon: Icon(Icons.info),
            child: const Text("About"),
            applicationIcon: Icon(Icons.local_play),
            applicationName: "Language Helper",
            applicationVersion: "0.1.0",
            applicationLegalese: "© Maximilian Geiger",
            aboutBoxChildren: [
              InkWell(
                onTap: _launchURL,
                child: const Text("Icon: designed by Iconixar from Flaticon"),
              )
            ],
          )
        ],
      ),
    );
  }

  _launchURL() async {
    const url = "https://www.flaticon.com/de/autoren/iconixar";
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
