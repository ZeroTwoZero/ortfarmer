import 'package:flutter/material.dart';
import 'package:ortfarmer/styles/colors.dart';
import 'package:ortfarmer/styles/styles.dart';
import 'package:ortfarmer/utilities/constants.dart';

class CommonTextFieldPair extends StatelessWidget {
  final String _text;
  final IconData? iconData;
  final TextInputType? keyBoardType;
  final int? maxLength;
  CommonTextFieldPair(this._text,
      {this.iconData, this.maxLength, this.keyBoardType, super.key});

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _text,
          style: boldOpenSansBlackMediumSize,
        ),
        defaultHeightSpace,
        TextFormField(
          controller: textEditingController,
          cursorColor: greenColor,
          maxLength: maxLength,
          maxLines: keyBoardType == TextInputType.multiline ? null : 1,
          keyboardType: keyBoardType,
          decoration: textFieldDecoration(
            "",
            prefixIcons: Icon(
              iconData,
              color: greenColor,
            ),
          ),
        ),
        smallHeightSpace,
      ],
    );
  }
}
