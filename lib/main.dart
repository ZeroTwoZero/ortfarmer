import 'package:flutter/material.dart';
import 'package:ortfarmer/components/commontabpage.dart';
import 'package:ortfarmer/corelogic/gsheetsinit.dart';
import 'package:ortfarmer/pages/loginpage.dart';
import 'package:ortfarmer/pages/registrationpage.dart';
import 'package:ortfarmer/styles/colors.dart';
import 'package:ortfarmer/utilities/constants.dart';
import "routefactory.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeGSheets();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Farmer\'s ORT',
      theme: ThemeData(
        primarySwatch: greenMaterialColor,
      ),
      onGenerateRoute: returnRouteFactory(),
      home: CommonTabPage(
        2,
        const [
          Tab(
              icon: Icon(
            Icons.person_add,
            size: iconDefaultSize,
          )),
          Tab(
              icon: Icon(
            Icons.person,
            size: iconDefaultSize,
          )),
        ],
        [
          RegistrationPage(tabController),
          const LoginPage(),
        ],
        controller: tabController,
      ),
    );
  }
}
