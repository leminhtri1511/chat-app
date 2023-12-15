import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authentication {
  Future<void> signIn(String userEmail, String userPassword) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: userEmail,
      password: userPassword,
    )
        .then(
      (user) async {
        user.user!.getIdToken().then((idToken) async {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('jwt', idToken!);
          print('idToken: --- $idToken');
        });
        print('login success');
      },
    );
  }

  Future<void> signUp(
    String userEmail,
    String userName,
    String userPassword,
    File selectedImage,
  ) async {
    try {
      var methods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(userEmail);
      if (methods.isNotEmpty) {
        throw FirebaseAuthException(
          code: 'email-already-in-use',
          message: 'This email is already in use.',
        );
      }

      final createUser =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );

      final storageRef = FirebaseStorage.instance
          .ref()
          .child('user_images')
          .child('${createUser.user!.uid}.jpg');
      await storageRef.putFile(selectedImage);
      final imageUrl = await storageRef.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(createUser.user!.uid)
          .set(
        {
          'username': userName,
          'email': userEmail,
          'password': userPassword,
          'image_url': imageUrl,
        },
      );
    } catch (e) {
      rethrow;
    }
  }
}
