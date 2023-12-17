import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:ortfarmer/pages/adminhomepage.dart';
import 'package:ortfarmer/pages/camerapage.dart';
import 'package:ortfarmer/pages/dashboardpage.dart';
import 'package:ortfarmer/pages/detailspage.dart';
import 'package:ortfarmer/pages/homepage.dart';
import 'package:ortfarmer/pages/mltpage.dart';
import 'package:ortfarmer/routeconstants.dart';
import 'components/commonscaffold.dart';
import 'styles/colors.dart';

RouteFactory returnRouteFactory() {
  Widget? titleWidget;
  return (settings) {
    Widget routePage;
    var nameOfRoute = settings.name;
    bool centerdScaffold = true;
    bool backButtonEnabled = false;
    bool isTabbedPage = false;
    switch (nameOfRoute) {
      case homePage:
        routePage = const HomePage();
        break;
      case adminHomePage:
        routePage = const AdminHomePage();
        break;
      case dashboardPage:
        isTabbedPage = true;
        Map<String, dynamic> args = settings.arguments != null
            ? settings.arguments as Map<String, dynamic>
            : {};
        routePage = DashboardPage(
          isEdit: args.isNotEmpty ? args["isEdit"] as bool : false,
        );
        backButtonEnabled = true;
        break;
      case mltPage:
        routePage = const MLTPage();
        backButtonEnabled = true;
        break;
      case cameraPage:
        Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
        routePage = CameraPage(
          cameras: args["camera"] as List<CameraDescription>,
          pictureNumber: args["picNo"] as int,
        );
        backButtonEnabled = true;
        break;
      case detailsPage:
        Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
        routePage = Expanded(
          child: DetailsPage(
            isART: args["isArt"] as bool,
            isOFT: args["isOft"] as bool,
            isEdit: true,
          ),
        );
        backButtonEnabled = true;
        break;
      default:
        routePage = Column(children: const []);
        break;
    }
    return MaterialPageRoute(
      builder: (BuildContext context) => WillPopScope(
        onWillPop: () async => backButtonEnabled,
        child: isTabbedPage
            ? routePage
            : CommonScaffold(
                routePage,
                bgColor: whiteColor,
                centeredScaffold: centerdScaffold,
                titleWidget: titleWidget,
              ),
      ),
    );
  };
}
