import 'dart:io';

import 'package:chat_app/src/presentation/base/base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class HomeScreenViewModel extends BaseViewModel {
  File? selectedImage;
  final firebase = FirebaseAuth.instance;

  dynamic init() {}

  
}
