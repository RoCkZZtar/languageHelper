import 'package:flutter/material.dart';

class Word {
  final String value;
  String translation;
  bool favorite;
  bool learning;

  Word(this.value, this.translation, this.favorite, this.learning);

  Word.fromJson(Map<String, dynamic> json)
      : value = json["value"],
        favorite = json["favorite"],
        learning = json["learning"],
        translation = json['translation'] == null ? "" : json['translation'];

  Map<String, dynamic> toJson() => {
        'value': value,
        'favorite': favorite,
        'learning': learning,
        'translation': translation
      };
}
