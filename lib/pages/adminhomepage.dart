import 'package:flutter/material.dart';
import 'package:ortfarmer/components/blurrydialogwithwidgets.dart';
import 'package:ortfarmer/routeconstants.dart';
import 'package:ortfarmer/styles/colors.dart';
import 'package:ortfarmer/styles/styles.dart';
import 'package:ortfarmer/utilities/constants.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  ButtonStyle button1 = getXSmallButtonWithDifferentColor(greenColor),
      button2 = getXSmallButtonWithDifferentColor(whiteColor),
      button3 = getXSmallButtonWithDifferentColor(whiteColor);
  TextStyle text1 = boldOpenSansWhiteSmallSize,
      text2 = boldOpenSansGreenSmallSize,
      text3 = boldOpenSansGreenSmallSize;
  bool isArt = true, isOft = false;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text("Agri Field Trial Application",
                style: boldOpenSansBlackMediumSize),
            defaultHeightSpace,
            Row(
              children: [
                Text(
                  "Hello Admin!",
                  style: boldOpenSansBlackMediumSize,
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.logout,
                    size: iconDefaultSize,
                    color: greenColor,
                  ),
                )
              ],
            ),
            defaultHeightSpace,
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      button1 = getXSmallButtonWithDifferentColor(greenColor);
                      button2 = getXSmallButtonWithDifferentColor(whiteColor);
                      button3 = getXSmallButtonWithDifferentColor(whiteColor);
                      text1 = boldOpenSansWhiteSmallSize;
                      text2 = boldOpenSansGreenSmallSize;
                      text3 = boldOpenSansGreenSmallSize;
                      isArt = true;
                      isOft = false;
                    });
                  },
                  style: button1,
                  child: Text(
                    "ART",
                    style: text1,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    setState(() {
                      button2 = getXSmallButtonWithDifferentColor(greenColor);
                      button1 = getXSmallButtonWithDifferentColor(whiteColor);
                      button3 = getXSmallButtonWithDifferentColor(whiteColor);
                      text2 = boldOpenSansWhiteSmallSize;
                      text1 = boldOpenSansGreenSmallSize;
                      text3 = boldOpenSansGreenSmallSize;
                      isOft = true;
                      isArt = false;
                    });
                  },
                  style: button2,
                  child: Text(
                    "OFT",
                    style: text2,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    setState(() {
                      button3 = getXSmallButtonWithDifferentColor(greenColor);
                      button2 = getXSmallButtonWithDifferentColor(whiteColor);
                      button1 = getXSmallButtonWithDifferentColor(whiteColor);
                      text3 = boldOpenSansWhiteSmallSize;
                      text2 = boldOpenSansGreenSmallSize;
                      text1 = boldOpenSansGreenSmallSize;
                      isArt = false;
                      isOft = false;
                    });
                  },
                  style: button3,
                  child: Text("FLD", style: text3),
                ),
              ],
            ),
            Expanded(
                child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, detailsPage, arguments: {
                          "isArt": isArt,
                          "isOft": isOft,
                        });
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 1.2,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: greenColor,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        child: Center(
                            child: Text(
                          "Test Data",
                          style: openSansGreenSmallSize,
                        )),
                      ),
                    ),
                    smallHeightSpace,
                  ],
                );
              },
            )),
          ],
        ),
      ),
    );
  }

  void showCreateDocumentDialog(BuildContext context) {
    BlurryDialogWithWidgets alert = BlurryDialogWithWidgets(
      "Choose an option",
      SizedBox(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed(dashboardPage);
              },
              style: defaultButtonStyle,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.document_scanner,
                    color: whiteColor,
                  ),
                  smallWidthSpace,
                  Text(
                    "ART/OFT/FLD",
                    style: openSansWhiteSmallSize,
                  ),
                ],
              ),
            ),
            defaultHeightSpace,
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed(mltPage);
              },
              style: defaultButtonStyle,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.document_scanner,
                    color: whiteColor,
                  ),
                  smallWidthSpace,
                  Text(
                    "MLT",
                    style: openSansWhiteSmallSize,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
