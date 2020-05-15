import 'package:path_provider/path_provider.dart';
import 'dart:io';

// Get correct file Path
Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

//Create Reference to file location
Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/pacakgelist.txt');
}

//Write Data
Future<File> writeList(List<String> list) async {
  final file = await _localFile;

  // Convert to json
  String json = '';
  // Write the file.
  return file.writeAsString(json);
}

//Read Data
Future<int> readList() async {
  try {
    final file = await _localFile;

    // Read the file.
    String contents = await file.readAsString();

    //Convert back to list
    return int.parse(contents);
  } catch (e) {
    // If encountering an error, return 0.
    return 0;
  }
}
