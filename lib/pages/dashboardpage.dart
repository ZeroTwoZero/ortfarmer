import 'package:flutter/material.dart';
import 'package:ortfarmer/components/commontabpage.dart';
import 'package:ortfarmer/pages/detailspage.dart';
import 'package:ortfarmer/styles/styles.dart';

class DashboardPage extends StatelessWidget {
  final bool isEdit;
  const DashboardPage({
    this.isEdit = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CommonTabPage(
      3,
      [
        Text(
          "ART",
          style: boldOpenSansBlackLargeSize,
        ),
        Text(
          "OFT",
          style: boldOpenSansBlackLargeSize,
        ),
        Text(
          "FLD",
          style: boldOpenSansBlackLargeSize,
        ),
      ],
      [
        DetailsPage(
          isART: true,
          isEdit: isEdit,
        ),
        DetailsPage(
          isOFT: true,
          isEdit: isEdit,
        ),
        DetailsPage(
          isEdit: isEdit,
        )
      ],
    );
  }
}
