import 'dart:io';

import 'package:chat_app/src/configs/configs.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImage extends StatefulWidget {
  const PickImage({
    super.key,
    this.onPickImage,
    this.onChanged,
  });

  final void Function(File pickedImage)? onPickImage;
  final Function(String value)? onChanged;

  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  File? pickedImageFile;

  void pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
      maxWidth: 150,
    );
    
    if (pickedImage == null) {
      return;
    }

    setState(() {
      pickedImageFile = File(pickedImage.path);
    });

    widget.onPickImage!(pickedImageFile!);
    widget.onChanged;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(99),
            border: Border.all(color: AppColors.PRIMARY_PURPLE)
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.BLACK_200,
              foregroundImage:
                  pickedImageFile != null ? FileImage(pickedImageFile!) : null,
            ),
          ),
        ),
        TextButton.icon(
          onPressed: pickImage,
          icon: const Icon(Icons.camera_alt_rounded),
          label: const Paragraph(
            content: 'Add Image',
            style: STYLE_MEDIUM,
          ),
        )
      ],
    );
  }
}
