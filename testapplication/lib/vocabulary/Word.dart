import 'package:flutter/material.dart';

class Word {
  final String value;
  bool favorite;
  bool learning;

  Word(this.value, this.favorite, this.learning);

  Word.fromJson(Map<String, dynamic> json)
      : value = json["value"],
        favorite = json["favorite"],
        learning = json["learning"];

  Map<String, dynamic> toJson() => {
        'value': value,
        'favorite': favorite,
        'learning': learning,
      };
}
