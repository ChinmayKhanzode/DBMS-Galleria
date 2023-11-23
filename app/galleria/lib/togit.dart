import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void updateGit(File _imageFile) async {
  print("in update git");
  Uint8List _bytes = await _imageFile.readAsBytes();
  String _base64String = base64.encode(_bytes);
  print(_base64String);
  print("------");

  final response = await http.put(
    Uri.parse(
        'https://api.github.com/repos/ChinmayKhanzode/PhotosGalleria/contents/${basename(_imageFile.path.trim())}'),
    headers: <String, String>{
      "Accept": "application/vnd.github+json",
      "Authorization": "Bearer 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"
    },
    body: jsonEncode(<String, String>{
      "message": "upload image from api",
      "content": _base64String
    }),
  );
  var downurl = json.decode(response.body)['content']['download_url'];
  print(downurl);
  todatabase(downurl);
}

Future<void> todatabase(String downurl) async {
  final resp = await http.post(
    Uri.parse('https://lemon-cocoon-sari.cyclic.app'),
    body: jsonEncode(<String, String>{"imgurl": downurl}),
  );
  print(json.decode(resp.body));
  print("uploded to database");
}
