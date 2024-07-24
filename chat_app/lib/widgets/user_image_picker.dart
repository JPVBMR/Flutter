import 'dart:io';
import 'dart:typed_data'; // For web
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_web/image_picker_web.dart'; // For web

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({
    super.key,
    required this.selectImageFN,
  });

  final Function(File? pickedImageFile, Uint8List? pickedImageBytes)
      selectImageFN;

  @override
  State<UserImagePicker> createState() {
    return _UserImagePickerState();
  }
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImageFile; // For mobile
  Uint8List? _pickedImageBytes; // For web

  Future<void> _selectImage() async {
    if (kIsWeb) {
      // Web
      final pickedImageBytes = await ImagePickerWeb.getImageAsBytes();
      if (pickedImageBytes != null) {
        setState(() {
          _pickedImageBytes = pickedImageBytes;
        });

        widget.selectImageFN(null, pickedImageBytes);
      }
    } else {
      // Mobile
      final pickedImage = await ImagePicker().pickImage(
        source: ImageSource.camera, // You can also use ImageSource.gallery
        imageQuality: 50,
        maxWidth: 150,
      );

      if (pickedImage != null) {
        setState(() {
          _pickedImageFile = File(pickedImage.path);
        });

        widget.selectImageFN(_pickedImageFile, null);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageProvider = kIsWeb
        ? _pickedImageBytes != null
            ? MemoryImage(_pickedImageBytes!)
            : null
        : _pickedImageFile != null
            ? FileImage(_pickedImageFile!)
            : null;

    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          foregroundImage: imageProvider as ImageProvider?,
        ),
        TextButton.icon(
          onPressed: _selectImage,
          icon: const Icon(Icons.image),
          label: const Text('Add image'),
        ),
      ],
    );
  }
}
