import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BusinessImagesPage extends StatefulWidget {
  @override
  _BusinessImagesPageState createState() => _BusinessImagesPageState();
}

class _BusinessImagesPageState extends State<BusinessImagesPage> {
  List<File> _imageFiles = [];

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: source,
        imageQuality: 80, // Adjust image quality as needed
      );
      if (pickedFile != null) {
        setState(() {
          if (_imageFiles.length < 4) {
            _imageFiles.add(File(pickedFile.path));
          } else {
            _showSnackBar('You can only select up to 4 images.');
          }
        });
      }
    } catch (e) {
      print('Image picking failed: $e');
      _showSnackBar('Image picking failed: $e');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _buildImagePreview(File imageFile) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Image.file(
          imageFile,
          width: 120,
          height: 120,
          fit: BoxFit.cover,
        ),
        IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () {
            setState(() {
              _imageFiles.remove(imageFile);
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Business Images'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select up to 4 images:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.photo_camera),
                  onPressed: () => _pickImage(ImageSource.camera),
                  tooltip: 'Take a picture',
                ),
                IconButton(
                  icon: Icon(Icons.photo_library),
                  onPressed: () => _pickImage(ImageSource.gallery),
                  tooltip: 'Choose from gallery',
                ),
              ],
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children:
                  _imageFiles.map((file) => _buildImagePreview(file)).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _imageFiles.isNotEmpty ? _submitImages : null,
              child: Text('Submit Images'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitImages() {
    // Handle image submission logic here
    // For demonstration, just print the paths of selected images
    _imageFiles.forEach((file) {
      print('Image path: ${file.path}');
    });
    _showSnackBar('Images submitted successfully!');
  }
}

void main() {
  runApp(MaterialApp(
    home: BusinessImagesPage(),
  ));
}
