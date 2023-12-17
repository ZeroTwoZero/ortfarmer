import 'package:flutter/material.dart';
import 'package:ortfarmer/components/commontextfieldpair.dart';
import 'package:ortfarmer/styles/colors.dart';
import 'package:ortfarmer/styles/styles.dart';
import 'package:ortfarmer/utilities/constants.dart';

class CropHealthStatusPage extends StatefulWidget {
  final bool isART, isOFT;
  const CropHealthStatusPage(
      {super.key, this.isART = false, this.isOFT = false});

  @override
  State<CropHealthStatusPage> createState() => _CropHealthStatusPageState();
}

class _CropHealthStatusPageState extends State<CropHealthStatusPage> {
  List<String> incidentStrings = ["Resistant", "Susceptible"];
  String pestIncident = "Resistant", diseaseIncident = "Resistant";

  late CommonTextFieldPair culture,
      populationstudy,
      yield,
      nameOfPest,
      disease,
      duration,
      gyieldplot,
      costofcultivation,
      grossprofit;
  ScrollController scrollController = ScrollController();
  String? pic1, pic2;
  @override
  void initState() {
    super.initState();
    culture = CommonTextFieldPair(
        widget.isART
            ? "Name of culture"
            : widget.isOFT
                ? "Name of Culture / Variety"
                : "Name of Variety / Technology",
        iconData: Icons.text_format);

    populationstudy = CommonTextFieldPair(
      "Overall Stand (%)",
      iconData: Icons.onetwothree,
      keyBoardType: TextInputType.number,
    );
    yield = CommonTextFieldPair("Yield (kg/acre)", iconData: Icons.text_format);
    nameOfPest =
        CommonTextFieldPair("Name of pest", iconData: Icons.bug_report);
    disease = CommonTextFieldPair("Disease", iconData: Icons.bug_report);
    duration = CommonTextFieldPair(
      "Duration (days)",
      iconData: Icons.onetwothree,
      keyBoardType: TextInputType.number,
    );
    gyieldplot = CommonTextFieldPair("Grain Yield / Plot (g/ sq.m)",
        iconData: Icons.text_format);
    costofcultivation = CommonTextFieldPair(
      "Cost Of Cultivation (Rs / ha)",
      iconData: Icons.money,
      keyBoardType: TextInputType.number,
    );
    grossprofit = CommonTextFieldPair(
      "Gross Profit (Rs / ha)",
      iconData: Icons.money,
      keyBoardType: TextInputType.number,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          culture,
          smallHeightSpace,
          populationstudy,
          // duration,
          // gyieldplot,
          // yield,
          // nameOfPest,
          // smallHeightSpace,
          // Row(
          //   children: [
          //     Text(
          //       "Pest Incidence",
          //       style: boldOpenSansBlackSmallSize,
          //     ),
          //     defaultWidthSpace,
          //     Expanded(
          //       child: DropdownButton<String>(
          //         value: pestIncident,
          //         style: openSansBlackSmallSize,
          //         isExpanded: true,
          //         items: incidentStrings.map((String value) {
          //           return DropdownMenuItem<String>(
          //             value: value,
          //             child: Text(
          //               value,
          //               overflow: TextOverflow.ellipsis,
          //             ),
          //           );
          //         }).toList(),
          //         onChanged: (value) {
          //           setState(() {
          //             pestIncident = value as String;
          //           });
          //         },
          //         underline: Container(
          //           height: 2,
          //           color: greenColor,
          //         ),
          //       ),
          //     )
          //   ],
          // ),
          // disease,
          // smallHeightSpace,
          // Row(
          //   children: [
          //     Text(
          //       "Disease Incidence",
          //       style: boldOpenSansBlackSmallSize,
          //     ),
          //     defaultWidthSpace,
          //     Expanded(
          //       child: DropdownButton<String>(
          //         value: diseaseIncident,
          //         style: openSansBlackSmallSize,
          //         isExpanded: true,
          //         items: incidentStrings.map((String value) {
          //           return DropdownMenuItem<String>(
          //             value: value,
          //             child: Text(
          //               value,
          //               overflow: TextOverflow.ellipsis,
          //             ),
          //           );
          //         }).toList(),
          //         onChanged: (value) {
          //           setState(() {
          //             diseaseIncident = value as String;
          //           });
          //         },
          //         underline: Container(
          //           height: 2,
          //           color: greenColor,
          //         ),
          //       ),
          //     )
          //   ],
          // ),
          // Visibility(
          //   visible: !widget.isART,
          //   child: Column(
          //     children: [
          //       costofcultivation,
          //       grossprofit,
          //     ],
          //   ),
          // ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: smallButtonStyle,
            child: Text(
              "Save",
              style: boldOpenSansWhiteSmallSize,
            ),
          ),
        ],
      ),
    );
  }
}
