import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:galleria/togit.dart';
import 'package:image_picker/image_picker.dart';

class uploader extends StatefulWidget {
  const uploader({super.key});

  @override
  State<uploader> createState() => _uploaderState();
}

class _uploaderState extends State<uploader> {
  File? _selectedImage;

  Future galleryimage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }
    setState(() {
      _selectedImage = File(image.path);
    });
  }

  void _takePicture() async {
    final imagePicker = ImagePicker();

    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);

    if (pickedImage == null) {
      return;
    }
    setState(() {
      _selectedImage = File(pickedImage.path);
    });
  }

  //Image Picker function to get image from camera

  @override
  Widget build(BuildContext context) {
    Widget content = Text("Image here");
    if (_selectedImage != null) {
      content = Image.file(
        _selectedImage!,
        fit: BoxFit.cover,
      );
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text("Image Picker Example"),
        ),
        body: Center(
          child: Column(
            children: [
              MaterialButton(
                  color: Colors.blue,
                  child: const Text("Pick Image from Gallery",
                      style: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.bold)),
                  onPressed: galleryimage),
              MaterialButton(
                  color: Colors.blue,
                  child: const Text("Pick Image from Camera",
                      style: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.bold)),
                  onPressed: _takePicture),
              content,
              if (_selectedImage != null)
                TextButton(
                    onPressed: () {
                      updateGit(_selectedImage!);
                    },
                    child: const Text("Upload"))
            ],
          ),
        ));
  }
}
