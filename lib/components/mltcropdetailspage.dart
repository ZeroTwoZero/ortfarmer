import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ortfarmer/components/commontextfieldpair.dart';
import 'package:ortfarmer/styles/styles.dart';
import 'package:ortfarmer/utilities/constants.dart';

import '../styles/colors.dart';

class MLTCropDetailsPage extends StatefulWidget {
  const MLTCropDetailsPage({super.key});

  @override
  State<MLTCropDetailsPage> createState() => _MLTCropDetailsPageState();
}

class _MLTCropDetailsPageState extends State<MLTCropDetailsPage> {
  List<String> incidentStrings = ["Resistant", "Susceptible"];
  String pestIncident = "Resistant", diseaseIncident = "Resistant";

  late CommonTextFieldPair culture,
      populationstudy,
      yield,
      daystoflowering,
      daystomaturity,
      nameOfPest,
      disease,
      duration,
      gyieldplot,
      grainyield,
      plantheight;
  DateTime selectedHarvestDate = DateTime.now();
  DateTime selectedSowingDate = DateTime.now();
  String? pic1, pic2;
  @override
  void initState() {
    super.initState();
    culture = CommonTextFieldPair("Variety / Culture name",
        iconData: Icons.text_format);

    populationstudy = CommonTextFieldPair("Germination percentage",
        iconData: Icons.text_format);
    yield = CommonTextFieldPair("Yield (kg/acre)", iconData: Icons.text_format);
    nameOfPest =
        CommonTextFieldPair("Name of pest", iconData: Icons.bug_report);
    disease = CommonTextFieldPair("Disease", iconData: Icons.bug_report);
    daystoflowering = CommonTextFieldPair(
      "Days to 50% flowering",
      iconData: Icons.onetwothree,
      keyBoardType: TextInputType.number,
    );
    daystomaturity = CommonTextFieldPair(
      "Days to maturity",
      iconData: Icons.onetwothree,
      keyBoardType: TextInputType.number,
    );
    duration = CommonTextFieldPair(
      "Duration (days)",
      iconData: Icons.onetwothree,
      keyBoardType: TextInputType.number,
    );
    gyieldplot = CommonTextFieldPair("Grain Yield / Plot (g/ sq.m)",
        iconData: Icons.text_format);
    grainyield = CommonTextFieldPair(
      "Grain Yield (kg / ac)",
      iconData: Icons.onetwothree,
      keyBoardType: TextInputType.number,
    );
    plantheight = CommonTextFieldPair(
      "Plant Height (cm)",
      iconData: Icons.onetwothree,
      keyBoardType: TextInputType.number,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          culture,
          Row(children: [
            Text(
              "Date of sowing:",
              style: boldOpenSansBlackSmallSize,
            ),
            smallWidthSpace,
            Text(
              DateFormat.yMMMMd('en_US').format(selectedSowingDate),
              style: openSansBlackXSmallSize,
            ),
            GestureDetector(
              onTap: () async {
                DateTime date = await selectDate(context, selectedSowingDate);

                if (date != selectedSowingDate) {
                  setState(() {
                    selectedSowingDate = date;
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
              style: boldOpenSansBlackSmallSize,
            ),
            smallWidthSpace,
            Text(
              DateFormat.yMMMMd('en_US').format(selectedHarvestDate),
              style: openSansBlackXSmallSize,
            ),
            GestureDetector(
              onTap: () async {
                DateTime date = await selectDate(context, selectedHarvestDate);

                if (date != selectedHarvestDate) {
                  setState(() {
                    selectedHarvestDate = date;
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
          daystoflowering,
          daystomaturity,
          smallHeightSpace,
          populationstudy,
          duration,
          gyieldplot,
          yield,
          nameOfPest,
          smallHeightSpace,
          Row(
            children: [
              Text(
                "Pest Incidence",
                style: boldOpenSansBlackSmallSize,
              ),
              defaultWidthSpace,
              Expanded(
                child: DropdownButton<String>(
                  value: pestIncident,
                  style: openSansBlackSmallSize,
                  isExpanded: true,
                  items: incidentStrings.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      pestIncident = value as String;
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
          disease,
          smallHeightSpace,
          Row(
            children: [
              Text(
                "Disease Incidence",
                style: boldOpenSansBlackSmallSize,
              ),
              defaultWidthSpace,
              Expanded(
                child: DropdownButton<String>(
                  value: diseaseIncident,
                  style: openSansBlackSmallSize,
                  isExpanded: true,
                  items: incidentStrings.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      diseaseIncident = value as String;
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
          plantheight,
          grainyield,
          TextButton(
            onPressed: () {
              Navigator.pop(context, widget);
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

  Future<DateTime> selectDate(BuildContext context, DateTime date) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2000, 8),
        lastDate: DateTime(2101));
    return picked ?? DateTime.now();
  }
}
