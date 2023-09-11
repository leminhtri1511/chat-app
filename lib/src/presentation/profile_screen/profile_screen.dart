import 'package:chat_app/src/configs/configs.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? imageUrl;
  String? userName;
  @override
  void initState() {
    super.initState();
    _loadUserProfileImage();
  }

  Future<void> _loadUserProfileImage() async {
    final user = _auth.currentUser;
    if (user != null) {
      final userId = user.uid;
      final userData = await _firestore.collection('users').doc(userId).get();
      if (userData.exists) {
        setState(() {
          imageUrl = userData['image_url'];
          userName = userData['username'];
        });
      }
    }
  }

  void logOutButton() {
    logOutDialog(context);
  }

  dynamic logOutDialog(_) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Paragraph(content: 'Log out'),
        content: const Paragraph(content: 'Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: [
            const Paragraph(
              content: 'PROFILE',
              style: STYLE_LARGE_BOLD,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 38,
                  backgroundImage: NetworkImage(imageUrl ?? ''),
                ),
                const SizedBox(
                  width: 30,
                ),
                Paragraph(
                  content: userName ?? 'User has no name!',
                  style: STYLE_LARGE_BOLD,
                ),
              ],
            ),
            const Spacer(),
            AppButton(
              enableButton: true,
              content: 'Log out',
              onTap: () => logOutButton(),
            ),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
