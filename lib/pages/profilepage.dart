import 'package:flutter/material.dart';
import 'package:ortfarmer/styles/colors.dart';
import 'package:ortfarmer/utilities/constants.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: const Icon(
        Icons.logout,
        size: iconDefaultSize,
        color: greenColor,
      ),
    );
  }
}
