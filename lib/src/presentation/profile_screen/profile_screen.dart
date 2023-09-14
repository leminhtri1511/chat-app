import 'dart:async';

import 'package:chat_app/src/configs/configs.dart';
import 'package:chat_app/src/configs/widget/loading/loading_diaglog.dart';
import 'package:chat_app/src/presentation/app_routers.dart';
import 'package:chat_app/src/presentation/profile_screen/components/function_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

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
  String? userEmail;
  String imgError =
      'https://media.istockphoto.com/id/1409329028/vector/no-picture-available-placeholder-thumbnail-icon-illustration-design.jpg?s=612x612&w=0&k=20&c=_zOuJu755g2eEUioiOUdz_mHKJQJn-tDgIAhQzyeKUQ=';

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
          userEmail = userData['email'];
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
        title: const Paragraph(
          content: 'Log out !',
          style: STYLE_MEDIUM_BOLD,
        ),
        content: Paragraph(
          content: 'Are you sure you want to log out?',
          style: STYLE_MEDIUM.copyWith(fontWeight: FontWeight.w500),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Paragraph(content: 'No', style: STYLE_SMALL_BOLD),
          ),
          TextButton(
            onPressed: () {
              // LoadingDialog.showLoadingDialog(context);
              Navigator.pop(context);
              FirebaseAuth.instance.signOut();

              // Timer(
              //   const Duration(seconds: 1),
              //   () {
              //     LoadingDialog.hideLoadingDialog(context);
              //     // AppRouter.goToSignInScreen(context);
              //   },
              // );
            },
            child: const Paragraph(content: 'Yes', style: STYLE_SMALL_BOLD),
          ),
        ],
      ),
    );
  }

  IconData lightMode = Icons.light_mode_rounded;
  IconData darkMode = Icons.dark_mode_rounded;
  bool iconBool = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // const Paragraph(
          //   content: 'PROFILE',
          //   style: STYLE_LARGE_BOLD,
          // ),

          buildAvatarRow(),
          const Divider(),
          buildSettingList(),

          // const Spacer(),
          buildLogOutButton(),
        ],
      ),
    );
  }

  Widget buildAvatarRow() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.SECONDARY_PURPLE),
                borderRadius: BorderRadius.circular(99),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: CircleAvatar(
                  radius: 38,
                  backgroundImage: NetworkImage(imageUrl ?? imgError),
                ),
              ),
            ),
            const SizedBox(width: 25),
            if (userName == null)
              const CircularProgressIndicator()
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Paragraph(
                    content: userName ?? 'User not found',
                    style: STYLE_LARGE_BOLD,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Paragraph(
                    content: userEmail ?? '',
                    style: STYLE_MEDIUM,
                  ),
                ],
              ),
            const Spacer(),
            // Lottie.asset(AppImages.qrCode, height: 40),
            IconButton(
              onPressed: () {
                setState(() {
                  iconBool = !iconBool;
                });
              },
              icon: iconBool
                  ? Icon(lightMode, size: 30)
                  : Icon(darkMode, size: 30),
            ),
            const SizedBox(width: 10)
          ],
        ),
      );

  Widget buildSettingList() => Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              FunctionBarWidget(
                svgIcon: AppImages.key,
                title: 'Account',
                content: 'Privacy, security',
                onTap: () {},
              ),
              FunctionBarWidget(
                svgIcon: AppImages.chat,
                title: 'Chat',
                content: 'Theme, wallpapers',
                onTap: () {},
              ),
              FunctionBarWidget(
                svgIcon: AppImages.notification,
                title: 'Notification',
                content: 'Message, group and others',
                onTap: () {},
              ),
              FunctionBarWidget(
                svgIcon: AppImages.help,
                title: 'Help',
                content: 'Help center, privacy policy',
                onTap: () {},
              ),
            ],
          ),
        ),
      );

  Widget buildLogOutButton() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
        child: AppButton(
          enableButton: true,
          content: 'Log out',
          onTap: () => logOutButton(),
        ),
      );
}
