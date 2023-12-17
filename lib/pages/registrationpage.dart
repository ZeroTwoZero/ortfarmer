import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ortfarmer/components/blurrydialog.dart';
import 'package:ortfarmer/components/commontextfieldpair.dart';
import 'package:ortfarmer/corelogic/createusercorelogic.dart';
import 'package:ortfarmer/corelogic/gsheetsinit.dart';
import 'package:ortfarmer/models/registration.dart';
import 'package:ortfarmer/styles/colors.dart';
import 'package:ortfarmer/styles/styles.dart';
import 'package:ortfarmer/utilities/constants.dart';

class RegistrationPage extends StatefulWidget {
  final TabController tabController;
  const RegistrationPage(this.tabController, {super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  late CommonTextFieldPair name, designation, number;
  Widget districtWidget = Container(), blockWidget = Container();
  List<String> districtList = [];
  String selectedDistrict = "";
  List<String> blockList = ["None"];
  String selectedBlock = "None";
  @override
  void initState() {
    super.initState();
    name = CommonTextFieldPair("Officer's Name", iconData: Icons.person);
    designation =
        CommonTextFieldPair("Designation", iconData: Icons.assignment_ind);
    number = CommonTextFieldPair(
      "Mobile Number",
      iconData: Icons.phone,
      keyBoardType: TextInputType.number,
      maxLength: 10,
    );
    SchedulerBinding.instance.addPostFrameCallback((_) {
      showLoaderDialog(context);
      getDistrict().then((value) => getBlocks(value));
    });
  }

  void getBlocks(List<String> district) {
    setState(() {
      districtList = district;
      selectedDistrict = districtList[0];
    });
    getBlock(selectedDistrict)
        .then((value) => loadDistrictAndBlock(value, district));
  }

  void loadDistrictAndBlock(
      List<String> listOfBlock, List<String> listOfDistrict) {
    setState(() {
      districtWidget = DropdownButton<String>(
        value: selectedDistrict,
        style: openSansBlackSmallSize,
        isExpanded: true,
        items: districtList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value, overflow: TextOverflow.ellipsis),
          );
        }).toList(),
        onChanged: (value) {
          if (value != selectedDistrict) {
            showLoaderDialog(context);
            setState(() {
              selectedDistrict = value as String;
            });
            getBlock(selectedDistrict)
                .then((value) => loadDistrictAndBlock(value, districtList));
          }
        },
        underline: Container(
          height: 2,
          color: greenColor,
        ),
      );
      blockList = listOfBlock;
      selectedBlock = blockList[0];
      buildBlocks();
    });
    Navigator.pop(context);
  }

  void buildBlocks() {
    setState(() {
      blockWidget = DropdownButton<String>(
        value: selectedBlock,
        style: openSansBlackSmallSize,
        isExpanded: true,
        items: blockList.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value, overflow: TextOverflow.ellipsis),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedBlock = value as String;
            buildBlocks();
          });
        },
        underline: Container(
          height: 2,
          color: greenColor,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  "assets/images/tngovt.png",
                  height: 60,
                  width: 60,
                ),
                const Spacer(),
                Text(
                  "User Registration",
                  style: boldOpenSansBlackLargeSize,
                ),
                const Spacer(),
                Image.asset(
                  "assets/images/logo2.jpg",
                  height: 75,
                  width: 75,
                ),
              ],
            ),
            name,
            designation,
            number,
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "District",
                style: boldOpenSansBlackMediumSize,
              ),
            ),
            districtWidget,
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Block",
                style: boldOpenSansBlackMediumSize,
              ),
            ),
            blockWidget,
            defaultHeightSpace,
            TextButton(
              onPressed: registerUser,
              style: defaultButtonStyle,
              child: Text(
                "Register",
                style: boldOpenSansWhiteLargeSize,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void registerUser() {
    String errorText = "";
    int bullets = 1;
    if (name.textEditingController.text.isEmpty) {
      errorText = "$bullets. Please enter your name \n";
      bullets++;
    }
    if (designation.textEditingController.text.isEmpty) {
      errorText += "$bullets. Please enter your designation \n";
      bullets++;
    }
    if (number.textEditingController.text.isEmpty) {
      errorText += "$bullets. Please enter your mobile number \n";
      bullets++;
    } else if (number.textEditingController.text.length < 10) {
      errorText += "$bullets. Please enter your 10 digit mobile number \n";
      bullets++;
    }
    if (errorText.isNotEmpty) {
      BlurryDialog alert = BlurryDialog(
        "Registration Error",
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
      Registration registrationDetails = Registration(
          name.textEditingController.text,
          designation.textEditingController.text,
          number.textEditingController.text,
          selectedDistrict,
          selectedBlock);
      createNewUser(registrationDetails);
      BlurryDialog alert = BlurryDialog(
        "Registration Successfuly",
        "User ${name.textEditingController.text} created successfully",
      );
      widget.tabController.animateTo(1);
      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
      name.textEditingController.text = "";
      designation.textEditingController.text = "";
      number.textEditingController.text = "";
    }
  }
}
