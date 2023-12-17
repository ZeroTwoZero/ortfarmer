import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ortfarmer/components/blurrydialog.dart';
import 'package:ortfarmer/components/commontextfieldpair.dart';
import 'package:ortfarmer/components/crophealthstatuspage.dart';
import 'package:ortfarmer/corelogic/createusercorelogic.dart';
import 'package:ortfarmer/models/crophealthstatus.dart';
import 'package:ortfarmer/models/cropstatus.dart';
import 'package:ortfarmer/models/evaluation.dart';
import 'package:ortfarmer/models/farmerdetails.dart';
import 'package:ortfarmer/models/gender.dart';
import 'package:ortfarmer/models/soiltype.dart';
import 'package:ortfarmer/models/typeenum.dart';
import 'package:ortfarmer/models/yieldacceptability.dart';
import 'package:ortfarmer/routeconstants.dart';
import 'package:ortfarmer/styles/colors.dart';
import 'package:ortfarmer/styles/styles.dart';
import 'package:ortfarmer/utilities/constants.dart';
import 'package:ortfarmer/corelogic/gsheetsinit.dart';
import 'package:flutter/scheduler.dart';

class DetailsPage extends StatefulWidget {
  final bool isART, isOFT, isEdit;
  const DetailsPage(
      {super.key, this.isART = false, this.isOFT = false, this.isEdit = false});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool shouldShowLocationPage = false;
  DateTime selectedDateOfSowing = DateTime.now();
  DateTime selectedYieldDate = DateTime.now();
  DateTime selectedFloweringDate = DateTime.now();
  CropStatus cropStatus = CropStatus.good;
  SoilType soilType = SoilType.redsoil;
  TypeEnum type = TypeEnum.irrigated;
  List<String> evaluationString = [
    "Variety",
  ];
  String selectionEvaluation = "Variety";
  YieldAcceptability yieldAcceptability = YieldAcceptability.acceptable;
  List<String> genderString = ["Male", "Female"];
  String selectedGender = "Male";
  late FarmerDetails farmerDetails;
  late CommonTextFieldPair name,
      address,
      age,
      mobile,
      surveynumber,
      village,
      crop,
      farmSize,
      pincode;
  Widget districtWidget = Container(), blockWidget = Container();
  ScrollController scrollController = ScrollController();
  List<CropHealthStatusPage> cropHealthStatus = [];
  String? pic1, pic2;
  List<String> districtList = [];
  String selectedDistrict = "";
  List<String> blockList = ["None"];
  String selectedBlock = "None";
  List<String> soilTypes = [
    "Red Soil",
    "Clay Soil",
    "Sandy",
    "Sandy Loam",
    "Sandy Clay",
    "Problematic Soil"
  ];
  String selectedSoilType = "Red Soil";
  @override
  void initState() {
    super.initState();
    if (widget.isART || widget.isOFT) {
      evaluationString.insert(0, "Culture");
    }
    if (!widget.isART) {
      evaluationString.add("Technology");
    }
    selectionEvaluation = evaluationString[0];
    name = CommonTextFieldPair("Name", iconData: Icons.person);
    address = CommonTextFieldPair(
      "Address",
      iconData: Icons.location_city,
      keyBoardType: TextInputType.multiline,
    );
    age = CommonTextFieldPair(
      "Age",
      iconData: Icons.onetwothree,
      keyBoardType: TextInputType.number,
    );
    mobile = CommonTextFieldPair(
      "Mobile Number",
      iconData: Icons.phone_android,
      maxLength: 10,
      keyBoardType: TextInputType.number,
    );
    surveynumber = CommonTextFieldPair(
      "Survey Field Number",
      iconData: Icons.abc,
    );
    village = CommonTextFieldPair("Village", iconData: Icons.location_city);

    crop = CommonTextFieldPair("Crop", iconData: Icons.text_format);

    farmSize = CommonTextFieldPair(
      "Farm Size (in ac)",
      iconData: Icons.onetwothree,
      keyBoardType: TextInputType.number,
    );
    pincode = CommonTextFieldPair(
      "Pincode",
      iconData: Icons.onetwothree,
      maxLength: 6,
      keyBoardType: TextInputType.number,
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
      controller: scrollController,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: shouldShowLocationPage
            ? Column(
                children: [
                  Text(
                    "Crop Details",
                    style: boldOpenSansBlackMediumSize,
                  ),
                  Row(
                    children: [
                      smallWidthSpace,
                      const Icon(
                        Icons.gps_fixed,
                        size: iconDefaultSize,
                        color: greenColor,
                      ),
                      smallWidthSpace,
                      Text(
                        "Location",
                        style: boldOpenSansGreenMediumSize,
                      ),
                    ],
                  ),
                  defaultHeightSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await availableCameras()
                              .then((value) => {gotoCameraPage(value, 1)});
                        },
                        child: pic1 == null
                            ? const Icon(
                                Icons.photo,
                                size: 175,
                                color: greenColor,
                              )
                            : Image.memory(
                                base64Decode(pic1 as String),
                                width: 175,
                                height: 175,
                              ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await availableCameras()
                              .then((value) => {gotoCameraPage(value, 2)});
                        },
                        child: pic2 == null
                            ? const Icon(
                                Icons.photo,
                                size: 175,
                                color: greenColor,
                              )
                            : Image.memory(
                                base64Decode(pic2 as String),
                                width: 175,
                                height: 175,
                              ),
                      ),
                    ],
                  ),
                  defaultHeightSpace,
                  crop,
                  Row(children: [
                    Text(
                      "Date of sowing:",
                      style: boldOpenSansBlackMediumSize,
                    ),
                    defaultWidthSpace,
                    Text(
                      DateFormat.yMMMMd('en_US').format(selectedDateOfSowing),
                      style: openSansBlackMediumSize,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () async {
                        DateTime date =
                            await selectDate(context, selectedDateOfSowing);

                        if (date != selectedDateOfSowing) {
                          setState(() {
                            selectedDateOfSowing = date;
                          });
                        }
                      },
                      child: const Icon(
                        Icons.calendar_month,
                        size: iconDefaultSize,
                        color: greenColor,
                      ),
                    )
                  ]),
                  smallHeightSpace,
                  Row(children: [
                    Text(
                      "Date of flowering:",
                      style: boldOpenSansBlackMediumSize,
                    ),
                    defaultWidthSpace,
                    Text(
                      DateFormat.yMMMMd('en_US').format(selectedFloweringDate),
                      style: openSansBlackMediumSize,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () async {
                        DateTime date =
                            await selectDate(context, selectedFloweringDate);

                        if (date != selectedFloweringDate) {
                          setState(() {
                            selectedFloweringDate = date;
                          });
                        }
                      },
                      child: const Icon(
                        Icons.calendar_month,
                        size: iconDefaultSize,
                        color: greenColor,
                      ),
                    )
                  ]),
                  smallHeightSpace,
                  Row(children: [
                    Text(
                      "Date of harvest:",
                      style: boldOpenSansBlackMediumSize,
                    ),
                    defaultWidthSpace,
                    Text(
                      DateFormat.yMMMMd('en_US').format(selectedYieldDate),
                      style: openSansBlackMediumSize,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () async {
                        DateTime date =
                            await selectDate(context, selectedYieldDate);

                        if (date != selectedYieldDate) {
                          setState(() {
                            selectedYieldDate = date;
                          });
                        }
                      },
                      child: const Icon(
                        Icons.calendar_month,
                        size: iconDefaultSize,
                        color: greenColor,
                      ),
                    )
                  ]),
                  smallHeightSpace,
                  Row(
                    children: [
                      Text(
                        "Evaluation",
                        style: boldOpenSansBlackMediumSize,
                      ),
                      defaultWidthSpace,
                      Expanded(
                        child: DropdownButton<String>(
                          value: selectionEvaluation,
                          style: openSansBlackMediumSize,
                          isExpanded: true,
                          items: evaluationString.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectionEvaluation = value as String;
                            });
                          },
                          underline: Container(
                            height: 2,
                            color: greenColor,
                          ),
                        ),
                      )
                    ],
                  ),
                  Center(
                    child: Column(
                        children: cropHealthStatus.map((item) {
                      return Column(
                        children: [
                          TextButton.icon(
                            onPressed: () => openCropData(item),
                            style: defaultButtonStyle,
                            icon: const Icon(
                              Icons.agriculture,
                              size: iconDefaultSize,
                              color: whiteColor,
                            ),
                            label: Text(
                              "Crop Data",
                              style: boldOpenSansWhiteSmallSize,
                            ),
                          ),
                          defaultHeightSpace
                        ],
                      );
                    }).toList()),
                  ),
                  getButtonsInRow(
                      "Add",
                      "Delete",
                      () => addNewCropHealthStatus(),
                      () => deleteCropHealthStatus(),
                      smallButtonStyle,
                      getSmallButtonWithDifferentColor(redColor)),
                  smallHeightSpace,
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.7,
                        child: Text(
                          "Overall crop stand",
                          style: boldOpenSansBlackMediumSize,
                        ),
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: ListTile(
                              title: Text(
                                'Good',
                                style: openSansBlackMediumSize,
                              ),
                              leading: Radio<CropStatus>(
                                value: CropStatus.good,
                                groupValue: cropStatus,
                                onChanged: (value) =>
                                    changeCropStatus(value as CropStatus),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.7,
                            child: ListTile(
                              title: Text(
                                'Satisfactory',
                                style: openSansBlackMediumSize,
                              ),
                              leading: Radio<CropStatus>(
                                value: CropStatus.satisfactory,
                                groupValue: cropStatus,
                                onChanged: (value) =>
                                    changeCropStatus(value as CropStatus),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.7,
                            child: ListTile(
                              title: Text(
                                'Poor',
                                style: openSansBlackMediumSize,
                              ),
                              leading: Radio<CropStatus>(
                                value: CropStatus.poor,
                                groupValue: cropStatus,
                                onChanged: (value) =>
                                    changeCropStatus(value as CropStatus),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.7,
                            child: ListTile(
                              title: Text(
                                'Failure',
                                style: openSansBlackMediumSize,
                              ),
                              leading: Radio<CropStatus>(
                                value: CropStatus.failure,
                                groupValue: cropStatus,
                                onChanged: (value) =>
                                    changeCropStatus(value as CropStatus),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  smallHeightSpace,
                  const Divider(
                    height: 2,
                    color: greenColor,
                  ),
                  Visibility(
                    visible: widget.isEdit,
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: Text(
                            "Overall Performance of ART / OFT / FLD",
                            style: boldOpenSansBlackSmallSize,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.8,
                              child: ListTile(
                                title: Text(
                                  'Highly Acceptable',
                                  style: openSansBlackSmallSize,
                                ),
                                leading: Radio<YieldAcceptability>(
                                  value: YieldAcceptability.highlyacceptable,
                                  groupValue: yieldAcceptability,
                                  onChanged: (value) =>
                                      changeYieldAcceptability(
                                          value as YieldAcceptability),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: ListTile(
                                title: Text(
                                  'Acceptable',
                                  style: openSansBlackSmallSize,
                                ),
                                leading: Radio<YieldAcceptability>(
                                  value: YieldAcceptability.acceptable,
                                  groupValue: yieldAcceptability,
                                  onChanged: (value) =>
                                      changeYieldAcceptability(
                                          value as YieldAcceptability),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: ListTile(
                                title: Text(
                                  'Need revision',
                                  style: openSansBlackSmallSize,
                                ),
                                leading: Radio<YieldAcceptability>(
                                  value: YieldAcceptability.needrevision,
                                  groupValue: yieldAcceptability,
                                  onChanged: (value) =>
                                      changeYieldAcceptability(
                                          value as YieldAcceptability),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: ListTile(
                                title: Text(
                                  'Not Acceptable',
                                  style: openSansBlackSmallSize,
                                ),
                                leading: Radio<YieldAcceptability>(
                                  value: YieldAcceptability.notacceptable,
                                  groupValue: yieldAcceptability,
                                  onChanged: (value) =>
                                      changeYieldAcceptability(
                                          value as YieldAcceptability),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  defaultHeightSpace,
                  getButtonsInRow("Save", "Cancel", () => initiateSubmission(),
                      () => cancelSaving(), smallButtonStyle, smallButtonStyle),
                ],
              )
            : Column(
                children: [
                  Text(
                    "Farmer's Details",
                    style: boldOpenSansBlackMediumSize,
                  ),
                  name,
                  Row(
                    children: [
                      Text(
                        "Gender",
                        style: boldOpenSansBlackMediumSize,
                      ),
                      defaultWidthSpace,
                      Expanded(
                        child: DropdownButton<String>(
                          value: selectedGender,
                          style: openSansBlackMediumSize,
                          isExpanded: true,
                          items: genderString.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedGender = value as String;
                            });
                          },
                          underline: Container(
                            height: 2,
                            color: greenColor,
                          ),
                        ),
                      )
                    ],
                  ),
                  address,
                  age,
                  mobile,
                  surveynumber,
                  farmSize,
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.7,
                        child: Text(
                          "Type",
                          style: boldOpenSansBlackMediumSize,
                        ),
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: ListTile(
                              title: Text(
                                'Irrigated',
                                style: openSansBlackSmallSize,
                              ),
                              leading: Radio<TypeEnum>(
                                value: TypeEnum.irrigated,
                                groupValue: type,
                                onChanged: (value) =>
                                    changeTypeEnum(value as TypeEnum),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.7,
                            child: ListTile(
                              title: Text(
                                'Rainfed',
                                style: openSansBlackSmallSize,
                              ),
                              leading: Radio<TypeEnum>(
                                value: TypeEnum.rainfed,
                                groupValue: type,
                                onChanged: (value) =>
                                    changeTypeEnum(value as TypeEnum),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(height: 2, color: greenColor),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.7,
                        child: Text(
                          "Soil Type",
                          style: boldOpenSansBlackMediumSize,
                        ),
                      ),
                      defaultWidthSpace,
                      Expanded(
                        child: DropdownButton<String>(
                          value: selectedSoilType,
                          style: openSansBlackMediumSize,
                          isExpanded: true,
                          items: soilTypes.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedSoilType = value as String;
                              soilType = changeSoilType(selectedSoilType);
                            });
                          },
                          underline: Container(
                            height: 2,
                            color: greenColor,
                          ),
                        ),
                      )
                    ],
                  ),
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
                  village,
                  pincode,
                  defaultHeightSpace,
                  TextButton(
                    onPressed: () {
                      initiateSubmission();
                      scrollController.animateTo(
                          //go to top of scroll
                          0, //scroll offset to go
                          duration: const Duration(
                              milliseconds: 500), //duration of scroll
                          curve: Curves.fastOutSlowIn //scroll type
                          );
                    },
                    style: defaultButtonStyle,
                    child: Text(
                      "Next",
                      style: boldOpenSansWhiteLargeSize,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Future<DateTime> selectDate(BuildContext context, DateTime date) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2000, 8),
        lastDate: DateTime(2101));
    return picked ?? DateTime.now();
  }

  void changeCropStatus(CropStatus value) {
    setState(() {
      cropStatus = value;
    });
  }

  void changeTypeEnum(TypeEnum value) {
    setState(() {
      type = value;
    });
  }

  SoilType changeSoilType(String value) {
    switch (value) {
      case "Red Soil":
        return SoilType.redsoil;
      case "Clay Soil":
        return SoilType.claysoil;
      case "Sandy":
        return SoilType.sandy;
      case "Sandy Loam":
        return SoilType.sandyloam;
      case "Sandy Clay":
        return SoilType.sandyclay;
      case "Problematic Soil":
        return SoilType.problematicsoil;
      default:
        return SoilType.redsoil;
    }
  }

  void changeYieldAcceptability(YieldAcceptability value) {
    setState(() {
      yieldAcceptability = value;
    });
  }

  void initiateSubmission() {
    String errorText = "";
    int bullets = 1;
    if (shouldShowLocationPage) {
      if (crop.textEditingController.text.isEmpty) {
        errorText = "$bullets. Please enter crop \n";
        bullets++;
      }
      if (errorText.isNotEmpty) {
        BlurryDialog alert = BlurryDialog(
          "Missing data",
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
        Evaluation evaluation = Evaluation.culture;
        switch (selectionEvaluation) {
          case "Variety":
            evaluation = Evaluation.variety;
            break;
          case "Technology":
            evaluation = Evaluation.technology;
            break;
        }
        Gender gender = Gender.male;
        switch (selectedGender) {
          case "Male":
            gender = Gender.male;
            break;
          case "Female":
            gender = Gender.female;
            break;
        }
        FarmerDetails farmerDetails = FarmerDetails(
            name.textEditingController.text,
            address.textEditingController.text,
            int.parse(age.textEditingController.text),
            mobile.textEditingController.text,
            surveynumber.textEditingController.text,
            selectedDistrict,
            selectedBlock,
            village.textEditingController.text,
            crop.textEditingController.text,
            "culture",
            selectedDateOfSowing,
            evaluation,
            "populationstudy",
            selectedFloweringDate,
            cropStatus,
            selectedYieldDate,
            "yield",
            yieldAcceptability,
            gender,
            CropHealthStatus("nameOfPest", "disease"),
            int.parse(farmSize.textEditingController.text),
            type,
            soilType,
            pincode.textEditingController.text,
            photo1: pic1,
            photo2: pic2);
        saveFarmerData(farmerDetails);
      }
    } else {
      if (name.textEditingController.text.isEmpty) {
        errorText = "$bullets. Please enter name \n";
        bullets++;
      }
      if (address.textEditingController.text.isEmpty) {
        errorText += "$bullets. Please enter address \n";
        bullets++;
      }
      if (age.textEditingController.text.isEmpty) {
        errorText += "$bullets. Please enter age \n";
        bullets++;
      }
      if (mobile.textEditingController.text.isEmpty) {
        errorText += "$bullets. Please enter mobile \n";
        bullets++;
      } else if (mobile.textEditingController.text.length < 10) {
        errorText += "$bullets. Please enter a 10 digit mobile number \n";
        bullets++;
      }
      if (surveynumber.textEditingController.text.isEmpty) {
        errorText += "$bullets. Please enter survey number \n";
        bullets++;
      }
      if (village.textEditingController.text.isEmpty) {
        errorText += "$bullets. Please enter village \n";
        bullets++;
      }
      if (pincode.textEditingController.text.isEmpty) {
        errorText += "$bullets. Please enter pincode \n";
        bullets++;
      }
      if (farmSize.textEditingController.text.isEmpty) {
        errorText += "$bullets. Please enter farm size \n";
        bullets++;
      }
      if (errorText.isNotEmpty) {
        BlurryDialog alert = BlurryDialog(
          "Missing data",
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
        setState(() {
          shouldShowLocationPage = true;
        });
      }
    }
  }

  void gotoCameraPage(List<CameraDescription> camera, int picNo) {
    Map<String, dynamic> args = {};
    args["picNo"] = picNo;
    args["camera"] = camera;
    Navigator.pushNamed(context, cameraPage, arguments: args)
        .then((value) => showDialogPop(value, picNo));
  }

  void showDialogPop(Object? value, int picNo) {
    if (value != null) {
      setState(() {
        switch (picNo) {
          case 1:
            pic1 = value as String;
            break;
          case 2:
            pic2 = value as String;
            break;
        }
      });
    }
  }

  void openCropData(CropHealthStatusPage widget) {
    {
      AlertDialog alert = AlertDialog(
        content: widget,
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }

  void addNewCropHealthStatus() {
    if (cropHealthStatus.length < 10) {
      cropHealthStatus.add(CropHealthStatusPage(
        isART: widget.isART,
        isOFT: widget.isOFT,
      ));
      setState(() {});
    } else {
      BlurryDialog alert = const BlurryDialog(
          "Limit Reached", "Max Limit of adding Crop data Reached");

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }

  void deleteCropHealthStatus() {
    if (cropHealthStatus.isNotEmpty) {
      cropHealthStatus.removeAt(cropHealthStatus.length - 1);
      setState(() {});
    } else {
      BlurryDialog alert = const BlurryDialog(
          "Delete error", "No Crop data is available to delete");

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }

  void cancelSaving() {
    setState(() {
      shouldShowLocationPage = false;
    });
    scrollController.animateTo(
        //go to top of scroll
        0, //scroll offset to go
        duration: const Duration(milliseconds: 500), //duration of scroll
        curve: Curves.fastOutSlowIn //scroll type
        );
  }
}
