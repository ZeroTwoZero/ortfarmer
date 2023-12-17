import 'package:flutter/material.dart';
import 'package:ortfarmer/styles/styles.dart';
import '../components/space.dart';

const twodoto = 2.0;
const thickUnderlineSize = 5.0;
const defaultPadding = 10.0;
const mediumPadding = 15.0;
const padding2X = 20.0;
const padding4X = 40.0;
const defaultSmallSize = 15.0;
const defaultSize = 25.0;
const iconDefaultSize = 40.0;
const iconMediumSize = 65.0;
const size2X = 50.0;
const size4X = 100.0;
const xSmallTextSize = 12.0;
const smallTextSize = 17.0;
const mediumTextSize = 20.0;
const largeTextSize = 25.0;
const smallBorderRadius = 10.0;
const largeBorderRadius = 35.0;
const xxSmallWidth = 210.0;
const xSmallWidth = 250.0;
const smallWidth = 500.0;
const smallButtonWidth = 150.0;
const xSmallButtonWidth = 100.0;
const defaultButtonWidth = 250.0;
const defaultButtonHeight = 70.0;
const smallButtonHeight = 35.0;
const smallButtonSize = Size(smallButtonWidth, smallButtonHeight);
const xSmallButtonSize = Size(xSmallButtonWidth, smallButtonHeight);
const defaultButtonSize = Size(defaultButtonWidth, defaultButtonHeight);

const defaultHeightSpace = Space(height: defaultSize);
const defaultWidthSpace = Space(width: defaultSize);

const smallHeightSpace = Space(height: thickUnderlineSize);
const smallWidthSpace = Space(width: thickUnderlineSize);

bool isMobileScreen = MediaQueryData.fromWindow(WidgetsBinding.instance.window)
        .size
        .shortestSide <
    600;

getButtonsInRow(String text1, String text2, Function() function1,
        Function() function2, ButtonStyle style1, ButtonStyle style2) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: function1,
          style: style1,
          child: Text(
            text1,
            style: boldOpenSansWhiteSmallSize,
          ),
        ),
        defaultWidthSpace,
        TextButton(
          onPressed: function2,
          style: style2,
          child: Text(
            text2,
            style: boldOpenSansWhiteSmallSize,
          ),
        ),
      ],
    );

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Row(
      children: [
        const CircularProgressIndicator(),
        Container(
            margin: const EdgeInsets.only(left: 7),
            child: const Text("Loading...")),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
