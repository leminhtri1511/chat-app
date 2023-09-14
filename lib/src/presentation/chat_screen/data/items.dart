import 'package:chat_app/src/configs/configs.dart';
import 'package:chat_app/src/presentation/chat_screen/models/menu_item.dart';
import 'package:flutter/material.dart';

class Items {
  static const List<MenuItem> items = [
    deleteIcon,
  ];

  static const deleteIcon = MenuItem(
    icon: Icons.delete,
    text: 'Delete chat',
  );
}
