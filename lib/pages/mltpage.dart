import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ortfarmer/components/blurrydialog.dart';
import 'package:ortfarmer/components/commontextfieldpair.dart';
import 'package:ortfarmer/components/mltcropdetailspage.dart';
import 'package:ortfarmer/corelogic/gsheetsinit.dart';
import 'package:ortfarmer/models/soiltype.dart';
import 'package:ortfarmer/models/typeenum.dart';
import 'package:ortfarmer/styles/colors.dart';
import 'package:ortfarmer/styles/styles.dart';
import 'package:ortfarmer/utilities/constants.dart';

class MLTPage extends StatefulWidget {
  const MLTPage({super.key});

  @override
  State<MLTPage> createState() => _MLTPageState();
}

class _MLTPageState extends State<MLTPage> {
  List<String> mltString = [];
  String selectedMLTString = "";
  List<String> namesOfSelectedMLT = ["None"];
  String selectedName = "None";
  late CommonTextFieldPair nameOfCrop;
  SoilType soilType = SoilType.redsoil;
  TypeEnum type = TypeEnum.irrigated;
  Widget nameOfMLTWidget = Container(), mltWidget = Container();
  List<MLTCropDetailsPage> mltCropDetailPage = [];
  @override
  void initState() {
    super.initState();
    nameOfCrop = CommonTextFieldPair("Name of crop", iconData: Icons.abc);
    SchedulerBinding.instance.addPostFrameCallback((_) {
      showLoaderDialog(context);
      getNamesOfMLTTypes().then((value) => getMLTTypes(value));
    });
  }

  void getMLTTypes(List<String> mltNames) {
    setState(() {
      mltString = mltNames;
      selectedMLTString = mltString[0];
    });
    getNamesOfMLT(selectedMLTString)
        .then((value) => getNamesOfSelectedMLT(value, mltNames));
  }

  void getNamesOfSelectedMLT(
      List<String> listOfMLTNames, List<String> mltNames) {
    setState(() {
      mltWidget = DropdownButton<String>(
        value: selectedMLTString,
        style: openSansBlackMediumSize,
        isExpanded: true,
        items: mltString.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value, overflow: TextOverflow.ellipsis),
          );
        }).toList(),
        onChanged: (value) {
          if (value != selectedMLTString) {
            showLoaderDialog(context);
            setState(() {
              selectedMLTString = value as String;
            });
            getNamesOfMLT(selectedMLTString)
                .then((value) => getNamesOfSelectedMLT(value, mltString));
          }
        },
        underline: Container(
          height: 2,
          color: greenColor,
        ),
      );
      namesOfSelectedMLT = listOfMLTNames;
      selectedName = namesOfSelectedMLT[0];
      buildNameMLT();
    });
    Navigator.pop(context);
  }

  void buildNameMLT() {
    setState(() {
      nameOfMLTWidget = DropdownButton<String>(
        value: selectedName,
        style: openSansBlackMediumSize,
        isExpanded: true,
        items: namesOfSelectedMLT.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value, overflow: TextOverflow.ellipsis),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedName = value as String;
            buildNameMLT();
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
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "MLT",
                style: boldOpenSansBlackMediumSize,
              ),
              defaultHeightSpace,
              Row(
                children: [
                  Expanded(
                    child: mltWidget,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select",
                    style: boldOpenSansBlackMediumSize,
                  ),
                  defaultHeightSpace,
                  nameOfMLTWidget,
                ],
              ),
              nameOfCrop,
              Center(
                child: Column(
                    children: mltCropDetailPage.asMap().entries.map((item) {
                  return Column(
                    children: [
                      TextButton.icon(
                        onPressed: () => openMLT(item.key, item.value),
                        style: defaultButtonStyle,
                        icon: const Icon(
                          Icons.document_scanner,
                          size: iconDefaultSize,
                          color: whiteColor,
                        ),
                        label: Text(
                          "MLT",
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
                  () => addNewMLT(),
                  () => deleteMLT(),
                  smallButtonStyle,
                  getSmallButtonWithDifferentColor(redColor)),
              smallHeightSpace,
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.8,
                    child: Text(
                      "Soil Type",
                      style: boldOpenSansBlackMediumSize,
                    ),
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.7,
                        child: ListTile(
                          title: Text(
                            'Red Soil',
                            style: openSansBlackMediumSize,
                          ),
                          leading: Radio<SoilType>(
                            value: SoilType.redsoil,
                            groupValue: soilType,
                            onChanged: (value) =>
                                changeSoilType(value as SoilType),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: ListTile(
                          title: Text(
                            'Clay Soil',
                            style: openSansBlackMediumSize,
                          ),
                          leading: Radio<SoilType>(
                            value: SoilType.claysoil,
                            groupValue: soilType,
                            onChanged: (value) =>
                                changeSoilType(value as SoilType),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: ListTile(
                          title: Text(
                            'Sandy',
                            style: openSansBlackMediumSize,
                          ),
                          leading: Radio<SoilType>(
                            value: SoilType.sandy,
                            groupValue: soilType,
                            onChanged: (value) =>
                                changeSoilType(value as SoilType),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: ListTile(
                          title: Text(
                            'Sandy loam',
                            style: openSansBlackMediumSize,
                          ),
                          leading: Radio<SoilType>(
                            value: SoilType.sandyloam,
                            groupValue: soilType,
                            onChanged: (value) =>
                                changeSoilType(value as SoilType),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: ListTile(
                          title: Text(
                            'Sandy Clay',
                            style: openSansBlackMediumSize,
                          ),
                          leading: Radio<SoilType>(
                            value: SoilType.sandyclay,
                            groupValue: soilType,
                            onChanged: (value) =>
                                changeSoilType(value as SoilType),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: ListTile(
                          title: Text(
                            'Problematic Soil',
                            style: openSansBlackMediumSize,
                          ),
                          leading: Radio<SoilType>(
                            value: SoilType.problematicsoil,
                            groupValue: soilType,
                            onChanged: (value) =>
                                changeSoilType(value as SoilType),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(
                height: 2,
                color: greenColor,
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.8,
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
                            style: openSansBlackMediumSize,
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
                            style: openSansBlackMediumSize,
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
              getButtonsInRow(
                  "Save",
                  "Cancel",
                  () => {},
                  () => Navigator.pop(context),
                  smallButtonStyle,
                  smallButtonStyle),
            ],
          ),
        ),
      ),
    );
  }

  void changeTypeEnum(TypeEnum value) {
    setState(() {
      type = value;
    });
  }

  void changeSoilType(SoilType value) {
    setState(() {
      soilType = value;
    });
  }

  void openMLT(int i, MLTCropDetailsPage widget) {
    {
      AlertDialog alert = AlertDialog(
        content: widget,
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      ).then((value) => changeListValue(i, value));
    }
  }

  void changeListValue(int i, dynamic value) {
    if (value != null) {
      mltCropDetailPage[i] = value as MLTCropDetailsPage;
    }
  }

  void addNewMLT() {
    if (mltCropDetailPage.length < 4) {
      mltCropDetailPage.add(const MLTCropDetailsPage());
      setState(() {});
    } else {
      BlurryDialog alert = const BlurryDialog(
          "Limit Reached", "Max Limit of adding MLT Reached");

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }

  void deleteMLT() {
    if (mltCropDetailPage.isNotEmpty) {
      mltCropDetailPage.removeAt(mltCropDetailPage.length - 1);
      setState(() {});
    } else {
      BlurryDialog alert = const BlurryDialog(
          "Delete error", "No MLT data is available to delete");

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }
}
