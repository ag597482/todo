import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DisplaySavedPictureScreen extends StatefulWidget {
  String? imagePath;

  DisplaySavedPictureScreen({required this.imagePath});

  @override
  State<DisplaySavedPictureScreen> createState() =>
      _DisplaySavedPictureScreenState();
}

class _DisplaySavedPictureScreenState extends State<DisplaySavedPictureScreen> {
  
  void LoadImage() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    
    setState(() {
      widget.imagePath = sharedPreference.getString("imagePath");
    });
  }

  @override
  void initState() {
    super.initState();
    LoadImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Saved Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(widget.imagePath!)),
    );
  }
}
