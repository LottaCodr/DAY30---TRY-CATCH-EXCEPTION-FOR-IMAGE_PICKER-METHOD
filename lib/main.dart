import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Image Picker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _image;

  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) {
      return;

      final imageTemporary = File(image.path);

      setState(() {
        this._image = imageTemporary;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload an Image'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Image.network('http://picsum.photos/250?images'),
            SizedBox(height: 40),

            //First custom button for gallery
            CustomButton(
              title: 'Upload From Gallery',
              icon: Icons.image_outlined,
              onClick: getImage,
            ),

            //Upload from camera
            CustomButton(
              title: 'Camera',
              icon: Icons.camera,
              onClick: () => {},
            )
          ],
        ),
      ),
    );
  }
}

Widget CustomButton({
  required String title,
  required IconData icon,
  required VoidCallback onClick,
}) {
  return Container(
    width: 250,
    child: ElevatedButton(
        onPressed: onClick,
        child: Row(
          children: [const Icon(Icons.image_outlined), Text(title)],
        )),
  );
}
