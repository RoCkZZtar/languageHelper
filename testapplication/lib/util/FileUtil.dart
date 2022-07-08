import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../vocabulary/Word.dart';

class FileUtil {
  bool test = false;

  Future<String> getFilePath() async {
    Directory directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/words.json';
  }

  void saveFile(List<Word> words) async {
    File file = File(await getFilePath());
    file.writeAsString(jsonEncode(words));
  }

  Future<List<Word>> readFile() async {
    File file = File(await getFilePath());
    Iterable iterable = jsonDecode(await file.readAsString());

    return List<Word>.from(iterable.map((e) => Word.fromJson(e)));
  }
}
