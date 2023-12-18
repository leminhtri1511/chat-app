import 'dart:io';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:chat_app/src/configs/app_result/app_result.dart';
import 'package:chat_app/src/configs/configs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewMsgWidget extends StatefulWidget {
  const NewMsgWidget({
    super.key,
  });

  @override
  State<NewMsgWidget> createState() => _NewMsgWidgetState();
}

class _NewMsgWidgetState extends State<NewMsgWidget> {
  final msgController = TextEditingController();
  final audioSent = AudioPlayer();
  File? pickedImageFile;

  @override
  void dispose() {
    msgController.dispose();
    super.dispose();
  }

  Future<String?> uploadImage(File imageFile) async {
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = storageRef.putFile(imageFile);
      final TaskSnapshot snapshot = await uploadTask;
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  void submitMsg() async {
    // Xác định nếu có ảnh được chọn
    if (pickedImageFile == null && msgController.text.isEmpty) {
      return;
    }
    
    if (pickedImageFile != null) {
      // Tải ảnh lên Firebase Storage
      final imageUrl = await uploadImage(pickedImageFile!);

      // Sau khi tải ảnh lên thành công, có thể thêm thông tin và tin nhắn vào Firestore
      if (imageUrl != null) {
        // Thêm thông tin vào Firestore với URL của ảnh
        FirebaseFirestore.instance.collection('chat').add({
          'text': msgController.text,
          'createdAt': Timestamp.now(),
          'userId': FirebaseAuth.instance.currentUser!.uid,
          'chatImage': imageUrl,
          // ... (các thông tin khác)
        });
        // Xoá ảnh sau khi đã tải lên thành công (nếu muốn)
        setState(() {
          pickedImageFile = null;
        });
      }
    } else {
      // Nếu không có ảnh, chỉ thêm thông tin văn bản vào Firestore
      FirebaseFirestore.instance.collection('chat').add({
        'text': msgController.text,
        'createdAt': Timestamp.now(),
        'userId': FirebaseAuth.instance.currentUser!.uid,
        // ... (các thông tin khác)
      });
    }

    // Xóa nội dung trong ô nhập tin nhắn
    msgController.clear();
  }

  Future<void> getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        pickedImageFile = File(pickedFile.path);
      });
    }
  }

  void deleteImage() {
    setState(() {
      pickedImageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 10),
      child: Column(
        children: [
          if (pickedImageFile != null)
            Row(
              children: [
                Container(
                  width: 100,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(pickedImageFile!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: deleteImage,
                  icon: const Icon(
                    CupertinoIcons.delete_left,
                    size: 30,
                  ),
                ),
              ],
            ),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    AppFormField(
                      textEditingController: msgController,
                      hintText: 'Send a message',
                      // pickedImageFile: pickedImageFile,
                    ),
                    // TextField(
                    //   autocorrect: true,
                    //   enableSuggestions: true,
                    //   controller: msgController,
                    //   textCapitalization: TextCapitalization.sentences,
                    //   decoration: const InputDecoration(hintText: 'Send a msg...'),
                    // ),
                  ],
                ),
              ),
              IconButton(
                color: Theme.of(context).colorScheme.primary,
                onPressed: () {
                  getImage();
                },
                icon: const Icon(Icons.photo),
              ),
              IconButton(
                color: Theme.of(context).colorScheme.primary,
                onPressed: () {
                  submitMsg();
                },
                icon: const Icon(Icons.send),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
