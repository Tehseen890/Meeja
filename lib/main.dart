import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:meeja/core/constants/colors.dart';
import 'package:meeja/core/extensions/color.dart';
import 'package:meeja/screens/connection/connection_provider.dart';
import 'package:meeja/screens/home/home_provider.dart';

import 'package:meeja/screens/splash_screen.dart';
import 'package:provider/provider.dart';

import 'core/locator.dart';
import 'firebase_options.dart';
import 'screens/groups/group_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
//Replaced with script based initialization using firebase_cli
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await setupLocator();

  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GroupProvider>(
          create: (context) => GroupProvider(),
        ),
        // ChangeNotifierProvider<ItemDetailScreenProvider>(
        //     create: (context) => ItemDetailScreenProvider()),
        ChangeNotifierProvider<HomeScreenProvider>(
          create: (context) => HomeScreenProvider(),
        ),
        ChangeNotifierProvider<ConnectionProvider>(
          create: (context) => ConnectionProvider(),
        )
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Meeja',
        theme: ThemeData(
          primaryColor: orangeColor,
          // primarySwatch: Colors.orange,
          primarySwatch: orangeColor.toMaterialColor(),
          textTheme: TextTheme(
            button: TextStyle(
              color: orangeColor,
            ),
          ),
          // But
        ),
        home: ScreenUtilInit(
          //TODO: Screen sizes to be changed according to the design provided
          //NOTE -- ISSUE:: Since we have wrapped two material widgets on top of each other
          //This could result in unresponsive alert dialogs sometimes, or Navigatior.pop, not
          // working properly, in such case it is advised to set root navigator to
          //true in navaigation etc..

          designSize: Size(width, height),
          //  builder: (_, child) => SplashScreen(),
          builder: (_, child) => SplashScreen(),
          // builder: (_, child) => SignUp(),
          //builder: (_, child) => PriceRangeScreen(),
        ),
      ),
    );
  }
}
