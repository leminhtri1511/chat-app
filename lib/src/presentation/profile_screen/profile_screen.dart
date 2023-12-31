import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/src/configs/configs.dart';
import 'package:chat_app/src/presentation/app_routers.dart';
import 'package:chat_app/src/presentation/profile_screen/components/function_bar_widget.dart';
import 'package:chat_app/src/presentation/profile_screen/profile.dart';
import 'package:flutter/material.dart';
import '../base/base.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileViewModel? _viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<ProfileViewModel>(
      viewModel: ProfileViewModel(),
      onViewModelReady: (viewModel) => _viewModel = viewModel!..init(),
      builder: (context, viewModel, child) => buildProfile(),
    );
  }

  Widget buildProfile() {
    return SafeArea(
      child: Column(
        children: [
          buildAvatarRow(),
          const Divider(),
          buildSettingList(),
        ],
      ),
    );
  }

  Widget buildAvatarRow() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: _viewModel!.imageUrl ?? _viewModel!.imgError,
              placeholder: (context, url) => buildAvatarImage(
                NetworkImage(_viewModel!.imgError),
              ),
              imageBuilder: (context, imageProvider) =>
                  buildAvatarImage(imageProvider),
            ),
            const SizedBox(width: 25),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Paragraph(
                  content: _viewModel!.userName,
                  style: STYLE_LARGE_BOLD,
                ),
                const SizedBox(
                  height: 10,
                ),
                Paragraph(
                  content: _viewModel!.userEmail,
                  style: STYLE_MEDIUM,
                ),
              ],
            ),
            const Spacer(),
            // Lottie.asset(AppImages.qrCode, height: 40),
            // IconButton(
            //   onPressed: () {
            //     setState(() {
            //       iconBool = !iconBool;
            //     });
            //   },
            //   icon: iconBool
            //       ? Icon(lightMode, size: 30)
            //       : Icon(darkMode, size: 30),
            // ),
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
              FunctionBarWidget(
                svgIcon: AppImages.logOut,
                title: 'Log out',
                titleColor: AppColors.FIRST_RED,
                onTap: () => _viewModel!.logOutButton(),
              ),
            ],
          ),
        ),
      );

  Widget buildAvatarImage(ImageProvider<Object>? backgroundImage) => Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.SECONDARY_PURPLE,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(99),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: CircleAvatar(
            radius: 38,
            backgroundColor: Colors.transparent,
            backgroundImage: backgroundImage,
          ),
        ),
      );
}
