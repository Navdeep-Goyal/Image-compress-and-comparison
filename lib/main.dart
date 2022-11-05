import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_compress/service.dart';

enum Package { cropper, nativeImage, imageCompressor }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Compress Comparision',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late TabController controller;
  File? cropperFile;
  File? nativeFile;
  File? compressorFile;
  @override
  void initState() {
    controller = TabController(length: 4, vsync: this);

    super.initState();
  }

  compressImage(Package package) async {
    CompressImageService compressImageService = CompressImageService();
    File file = await GetImageService().getFile();
    File? compressedFile;
    switch (package) {
      case Package.cropper:
        {
          compressedFile = await compressImageService.imageCropper(file);
          setState(() {
            cropperFile = compressedFile;
          });
        }

        break;
      case Package.imageCompressor:
        {
          compressedFile =
              await compressImageService.flutterImageCompress(file);
          setState(() {
            compressorFile = compressedFile;
          });
        }
        break;
      case Package.nativeImage:
        {
          compressedFile = await compressImageService.flutterNativeImage(file);
          setState(() {
            nativeFile = compressedFile;
          });
        }
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: TabBar(
          controller: controller,
          tabs: const [
            TabButton(
              text: "image_Cropper",
            ),
            TabButton(
              text: "Flutter_native_image",
            ),
            TabButton(
              text: "Flutter image compress",
            ),
            TabButton(
              text: "Video Compress",
            ),
          ],
        ),
        body: TabBarView(
          controller: controller,
          physics: BouncingScrollPhysics(),
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    "Flutter Image Cropper package - 3.0.0",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  if (cropperFile != null) Image.file(cropperFile!),
                  MaterialButton(
                    onPressed: () async {
                      await compressImage(Package.cropper);
                    },
                    color: Colors.lightGreen,
                    child: const Text(
                      "get image",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    "Flutter Native Image Package - 0.0.6+1",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  if (nativeFile != null) Image.file(nativeFile!),
                  MaterialButton(
                    onPressed: () async {
                      await compressImage(Package.nativeImage);
                    },
                    color: Colors.amber,
                    child: const Text(
                      "get image",
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    "Flutter Image Compress package - 1.1.3",
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  if (compressorFile != null) Image.file(compressorFile!),
                  MaterialButton(
                    onPressed: () async {
                      await compressImage(Package.imageCompressor);
                    },
                    color: Colors.pink,
                    child: const Text(
                      "get image",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    "Flutter Image Compress package - 1.1.3",
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  if (compressorFile != null) Image.file(compressorFile!),
                  MaterialButton(
                    onPressed: () async {
                      await compressImage(Package.imageCompressor);
                    },
                    color: Colors.pink,
                    child: const Text(
                      "get image",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TabButton extends StatelessWidget {
  const TabButton({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
