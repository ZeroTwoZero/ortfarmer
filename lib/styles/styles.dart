import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utilities/constants.dart';
import '../styles/colors.dart';

InputDecoration textFieldDecoration(String text,
    {double widthSize = 1.0,
    Widget? prefixWidget,
    Widget? postfixWidget,
    Widget? prefixIcons}) {
  return InputDecoration(
    prefixIcon: prefixIcons,
    prefix: prefixWidget,
    suffix: postfixWidget,
    labelText: text,
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 3, color: greenColor),
      borderRadius: BorderRadius.circular(50.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 3, color: greenColor),
      borderRadius: BorderRadius.circular(50.0),
    ),
  );
}

InputDecoration getDecorationWithSuffix(String text,
    {double widthSize = 1.0, Widget? postfixWidget}) {
  return textFieldDecoration(text,
      widthSize: widthSize, postfixWidget: postfixWidget);
}

InputDecoration redTextFieldDecoration(String text, {double widthSize = 1.0}) {
  return InputDecoration(
    labelText: text,
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        width: widthSize,
        color: redColor,
      ),
    ),
  );
}

//Text Size
final openSansWhiteSmallSize = GoogleFonts.openSans(
  color: whiteColor,
  fontSize: smallTextSize,
);

final openSansWhiteMediumSize = GoogleFonts.openSans(
  color: whiteColor,
  fontSize: mediumTextSize,
);

final boldOpenSansWhiteSmallSize = GoogleFonts.openSans(
  color: whiteColor,
  fontWeight: FontWeight.bold,
  fontSize: smallTextSize,
);

final boldOpenSansWhiteMediumSize = GoogleFonts.openSans(
  color: whiteColor,
  fontWeight: FontWeight.bold,
  fontSize: mediumTextSize,
);

final boldOpenSansWhiteLargeSize = GoogleFonts.openSans(
  color: whiteColor,
  fontWeight: FontWeight.bold,
  fontSize: largeTextSize,
);

final boldOpenSansBlackSmallSize = GoogleFonts.openSans(
  color: blackColor,
  fontWeight: FontWeight.bold,
  fontSize: smallTextSize,
);

final boldOpenSansBlackMediumSize = GoogleFonts.openSans(
  color: blackColor,
  fontWeight: FontWeight.bold,
  fontSize: mediumTextSize,
);

final boldOpenSansBlackLargeSize = GoogleFonts.openSans(
  color: blackColor,
  fontWeight: FontWeight.bold,
  fontSize: largeTextSize,
);

final openSansBlackXSmallSize = GoogleFonts.openSans(
  color: blackColor,
  fontSize: 14.0,
);

final openSansBlackSmallSize = GoogleFonts.openSans(
  color: blackColor,
  fontSize: smallTextSize,
);

final openSansBlackMediumSize = GoogleFonts.openSans(
  color: blackColor,
  fontSize: mediumTextSize,
);

final openSansBlackLargeSize = GoogleFonts.openSans(
  color: blackColor,
  fontSize: largeTextSize,
);

final boldOpenSansGreenSmallSize = GoogleFonts.openSans(
  color: greenColor,
  fontWeight: FontWeight.bold,
  fontSize: smallTextSize,
);

final boldOpenSansGreenMediumSize = GoogleFonts.openSans(
  color: greenColor,
  fontWeight: FontWeight.bold,
  fontSize: mediumTextSize,
);

final openSansBlueSmallSize = GoogleFonts.openSans(
  color: blueColor,
  fontSize: smallTextSize,
);

final openSansBlueMediumSize = GoogleFonts.openSans(
  color: blueColor,
  fontSize: mediumTextSize,
);

final boldOpenSansBlueSmallSize = GoogleFonts.openSans(
  color: blueColor,
  fontWeight: FontWeight.bold,
  fontSize: smallTextSize,
);

final boldOpenSansBlueMediumSize = GoogleFonts.openSans(
  color: blueColor,
  fontWeight: FontWeight.bold,
  fontSize: mediumTextSize,
);

final boldOpenSansBlueLargeSize = GoogleFonts.openSans(
  color: blueColor,
  fontWeight: FontWeight.bold,
  fontSize: largeTextSize,
);

final boldOpenSansGraySmallSize = GoogleFonts.openSans(
  color: grayColor,
  fontWeight: FontWeight.bold,
  fontSize: smallTextSize,
);

final boldOpenSansGrayMediumSize = GoogleFonts.openSans(
  color: grayColor,
  fontWeight: FontWeight.bold,
  fontSize: mediumTextSize,
);

final boldOpenSansDarkBlueSmallSize = GoogleFonts.openSans(
  color: darkBlueColor,
  fontWeight: FontWeight.bold,
  fontSize: smallTextSize,
);

final boldOpenSansDarkBlueMediumSize = GoogleFonts.openSans(
  color: darkBlueColor,
  fontWeight: FontWeight.bold,
  fontSize: mediumTextSize,
);

final boldOpenSansDarkBlueLargeSize = GoogleFonts.openSans(
  color: darkBlueColor,
  fontWeight: FontWeight.bold,
  fontSize: largeTextSize,
);

final openSansGreenSmallSize = GoogleFonts.openSans(
  color: greenColor,
  fontSize: smallTextSize,
);

final openSansRedSmallSize = GoogleFonts.openSans(
  color: redColor,
  fontSize: smallTextSize,
);

final openSansRedMediumSize = GoogleFonts.openSans(
  color: redColor,
  fontSize: mediumTextSize,
);

final openSansGrayXSmallSize = GoogleFonts.openSans(
  color: grayColor,
  fontSize: xSmallTextSize,
);

final openSansGraySmallSize = GoogleFonts.openSans(
  color: grayColor,
  fontSize: smallTextSize,
);

final openSansGrayMediumSize = GoogleFonts.openSans(
  color: grayColor,
  fontSize: mediumTextSize,
);

//Button Styles
final smallButtonStyle = ButtonStyle(
  elevation: MaterialStateProperty.all(defaultSize),
  fixedSize: MaterialStateProperty.all(smallButtonSize),
  backgroundColor: MaterialStateProperty.all(greenColor),
  shape: MaterialStateProperty.all(
    RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(largeBorderRadius)),
  ),
);

//Button Styles
getXSmallButtonWithDifferentColor(Color color,
        {Color borderColor = greenColor}) =>
    ButtonStyle(
      elevation: MaterialStateProperty.all(thickUnderlineSize),
      fixedSize: MaterialStateProperty.all(xSmallButtonSize),
      backgroundColor: MaterialStateProperty.all(color),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
            side: BorderSide(color: borderColor, width: 1.0),
            borderRadius: BorderRadius.circular(largeBorderRadius)),
      ),
    );

//Button Styles
getSmallButtonWithDifferentColor(Color color) => ButtonStyle(
      elevation: MaterialStateProperty.all(defaultSize),
      fixedSize: MaterialStateProperty.all(smallButtonSize),
      backgroundColor: MaterialStateProperty.all(color),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(largeBorderRadius)),
      ),
    );

final defaultButtonStyle = ButtonStyle(
  elevation: MaterialStateProperty.all(defaultSize),
  fixedSize: MaterialStateProperty.all(defaultButtonSize),
  backgroundColor: MaterialStateProperty.all(greenColor),
  shape: MaterialStateProperty.all(
    RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(largeBorderRadius)),
  ),
);

ButtonStyle getOutlinedButtonStyle(
    {Size buttonSize = defaultButtonSize,
    Color borderColor = blackColor,
    double borderWidth = twodoto,
    Color backgroundColor = blackColor,
    double borderRadius = largeBorderRadius}) {
  return ButtonStyle(
    fixedSize: MaterialStateProperty.all(buttonSize),
    backgroundColor: MaterialStateProperty.all(backgroundColor),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
          side: BorderSide(
            color: borderColor,
            width: borderWidth,
          ),
          borderRadius: BorderRadius.circular(borderRadius)),
    ),
  );
}
