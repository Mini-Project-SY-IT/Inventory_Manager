import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePickerPage extends StatefulWidget {
  @override
  _ImagePickerPageState createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  File? _image;

  final picker = ImagePicker();

  void _getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Profile Photo"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image == null
                ? CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey.shade300,
              child: Icon(
                Icons.add_a_photo,
                size: 40,
                color: Colors.black,
              ),
            )
                : CircleAvatar(
              radius: 60,
              backgroundImage: FileImage(_image!),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: Icon(Icons.camera),
                          title: Text('Camera'),
                          onTap: () {
                            _getImage(ImageSource.camera);
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.photo_library),
                          title: Text('Gallery'),
                          onTap: () {
                            _getImage(ImageSource.gallery);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text("Choose Photo"),
            ),
          ],
        ),
      ),
    );
  }
}
