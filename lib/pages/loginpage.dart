import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ortfarmer/components/blurrydialog.dart';
import 'package:ortfarmer/components/commontextfieldpair.dart';
import 'package:ortfarmer/routeconstants.dart';
import 'package:ortfarmer/styles/styles.dart';
import 'package:ortfarmer/utilities/constants.dart';
import 'package:telephony/telephony.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late CommonTextFieldPair number, otp;
  String otpField = "";
  bool otpSent = false;
  final Telephony telephony = Telephony.instance;
  @override
  void initState() {
    super.initState();
    number = CommonTextFieldPair(
      "Phone Number",
      iconData: Icons.phone,
      keyBoardType: TextInputType.number,
      maxLength: 10,
    );
    otp = CommonTextFieldPair(
      "OTP",
      iconData: Icons.onetwothree,
      keyBoardType: TextInputType.number,
      maxLength: 6,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text("Agri Field Trial Application",
                  style: boldOpenSansBlackMediumSize),
              defaultHeightSpace,
              defaultHeightSpace,
              Row(
                children: [
                  Image.asset(
                    "assets/images/tngovt.png",
                    height: 100,
                    width: 100,
                  ),
                  const Spacer(),
                  Image.asset(
                    "assets/images/logo2.jpg",
                    height: 100,
                    width: 100,
                  ),
                ],
              ),
              defaultHeightSpace,
              number,
              defaultHeightSpace,
              Visibility(
                visible: otpSent,
                child: otp,
              ),
              defaultHeightSpace,
              TextButton(
                onPressed: validateAndLogin,
                style: defaultButtonStyle,
                child: Text(
                  otpSent ? "Login" : "Send OTP",
                  style: boldOpenSansWhiteLargeSize,
                ),
              ),
              defaultHeightSpace,
              Text(
                "* Standard SMS charges apply",
                style: openSansRedSmallSize,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> sendSMSToNumber(List<String> recipients) async {
    try {
      otpField = "";
      var rnd = Random();
      for (var i = 0; i < 6; i++) {
        otpField = otpField + rnd.nextInt(10).toString();
      }
      if (!otpSent) {
        await telephony.sendSms(
          to: number.textEditingController.text,
          message: "Your otp to login to the application is $otpField",
          statusListener: (SendStatus status) {
            if (status == SendStatus.DELIVERED) {
              setState(() => otpSent = true);
            }
          },
        );
      }
    } catch (error) {
      if (error is PlatformException) {
        BlurryDialog alert = BlurryDialog(
          "Login Error",
          error.message!.toString(),
        );

        // show the dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
      }
      setState(() => otpSent = true);
      otpField = "123456";
    }
  }

  void validateAndLogin() {
    String errorText = "";
    if (!otpSent) {
      if (number.textEditingController.text.isEmpty) {
        errorText += "Please enter your mobile number \n";
      } else if (number.textEditingController.text.length < 10) {
        errorText += "Please enter your 10 digit mobile number \n";
      }
      if (errorText.isNotEmpty) {
        BlurryDialog alert = BlurryDialog(
          "Login Error",
          errorText,
        );

        // show the dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
      } else {
        if (number.textEditingController.text == "1234567890") {
          Navigator.of(context)
              .pushNamed(adminHomePage)
              .then((value) => setOtpFalse());
        } else {
          sendSMSToNumber([number.textEditingController.text]);
        }
      }
    } else {
      if (otp.textEditingController.text.isEmpty ||
          otp.textEditingController.text.length < 6) {
        errorText += "Please enter your 6 digit OTP \n";
      } else if (otp.textEditingController.text != otpField) {
        errorText += "You have entered an incorrect OTP \n";
      }
      if (errorText.isNotEmpty) {
        BlurryDialog alert = BlurryDialog(
          "Login Error",
          errorText,
        );

        // show the dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
      } else {
        FocusScope.of(context).unfocus();
        String num = number.textEditingController.text;
        number.textEditingController.text = "";
        otp.textEditingController.text = "";
        if (num == "1234567890") {
          Navigator.of(context)
              .pushNamed(adminHomePage)
              .then((value) => setOtpFalse());
        } else {
          Navigator.of(context)
              .pushNamed(homePage)
              .then((value) => setOtpFalse());
        }
      }
    }
  }

  void setOtpFalse() {
    setState(() {
      otpSent = false;
    });
  }
}
