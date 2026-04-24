import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:pickers/profile_provider.dart';

class ImagePickerPage extends StatefulWidget {
  @override
  State<ImagePickerPage> createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _pickedImage;

  Future<void> _pickImage() async {
    _pickedImage = await _imagePicker.pickImage(source: ImageSource.gallery);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Foto Seçimi')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Center(
                  child: _pickedImage == null
                      ? const Icon(Icons.image_outlined, size: 84)
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(
                            File(_pickedImage!.path),
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () async {
                  await _pickImage();
                  setState(() {});
                },
                icon: const Icon(Icons.photo_library_rounded),
                label: const Text('Galeriden Seç'),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _pickedImage == null
                    ? null
                    : () {
                        Provider.of<ProfileProvider>(
                          context,
                          listen: false,
                        ).updateProfilePicture(_pickedImage!.path);
                        Navigator.pop(context);
                      },
                child: const Text('Fotoğrafı Kaydet'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
