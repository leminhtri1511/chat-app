import 'dart:io';

import 'package:animations/animations.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:chat_app/src/configs/configs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<String?> uploadImage(File? imageFile) async {
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = storageRef.putFile(imageFile!);
      final TaskSnapshot snapshot = await uploadTask;
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  void submitMsg() async {
    final enteredMsg = msgController.text;
    final user = FirebaseAuth.instance.currentUser!;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (enteredMsg.isEmpty && pickedImageFile == null) {
      print('Select an image or enter a text to send msg.');
      return;
    }

    // final imageUrl = await uploadImage(pickedImageFile);

    if (pickedImageFile != null && enteredMsg.isNotEmpty) {
      final imageUrl = await uploadImage(pickedImageFile);
      if (imageUrl != null) {
        // Add data to Firestore with imageUrl
        FirebaseFirestore.instance.collection('chat').add({
          'text': enteredMsg,
          'createdAt': Timestamp.now(),
          'userId': user.uid,
          'userName': userData.data()!['username'],
          'userImage': userData.data()!['image_url'],
          'userEmail': userData.data()!['email'],
          'chatImage': imageUrl,
        });
      }
    } else if (pickedImageFile == null) {
      // Add data to Firestore with imageUrl
      FirebaseFirestore.instance.collection('chat').add({
        'text': enteredMsg,
        'createdAt': Timestamp.now(),
        'userId': user.uid,
        'userName': userData.data()!['username'],
        'userImage': userData.data()!['image_url'],
        'userEmail': userData.data()!['email'],
        // 'chatImage': imageUrl,
      });
    } else {
      // Add data to Firestore without imageUrl
      final imageUrl = await uploadImage(pickedImageFile);
      if (imageUrl != null) {
        FirebaseFirestore.instance.collection('chat').add({
          'createdAt': Timestamp.now(),
          'userId': user.uid,
          'userName': userData.data()!['username'],
          'userImage': userData.data()!['image_url'],
          'userEmail': userData.data()!['email'],
          'chatImage': imageUrl,
        });
      }
    }

    deleteImage();
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
            OpenContainer(
              closedBuilder: (context, action) => Row(
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
              openBuilder: (context, action) => Column(
                children: [
                  AppBar(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.PRIMARY_PURPLE),
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(
                            image: FileImage(pickedImageFile!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    AppFormField(
                      textEditingController: msgController,
                      hintText: 'Send a message',
                      // iconButton:
                      //     IconButton(onPressed: () {}, icon: const Icon(Icons.close)),
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
