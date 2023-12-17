import 'package:flutter/material.dart';
import 'package:ortfarmer/components/blurrydialogwithwidgets.dart';
import 'package:ortfarmer/routeconstants.dart';
import 'package:ortfarmer/styles/colors.dart';
import 'package:ortfarmer/styles/styles.dart';
import 'package:ortfarmer/utilities/constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                  "Hello user!",
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
            const Spacer(),
            Expanded(
              child: Column(
                children: [
                  TextButton(
                    onPressed: () {
                      //showCreateDocumentDialog(context);
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
                          "Create Document",
                          style: openSansWhiteSmallSize,
                        ),
                      ],
                    ),
                  ),
                  defaultHeightSpace,
                  TextButton(
                    onPressed: () {
                      //showCreateDocumentDialog(context);
                      Navigator.of(context).pushNamed(dashboardPage,
                          arguments: {"isEdit": true});
                    },
                    style: defaultButtonStyle,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.edit_document,
                          color: whiteColor,
                        ),
                        smallWidthSpace,
                        Text(
                          "Edit Document",
                          style: openSansWhiteSmallSize,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
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
