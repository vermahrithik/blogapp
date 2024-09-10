import 'package:blogapp/controller/blogcontroller.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:blogapp/controller/blogcontroller.dart';
import 'package:blogapp/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:blogapp/firebase_options.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  setPathUrlStrategy();
  debugPrint('setpathurlstrategy : ok');
  Get.put(MovieController());
  debugPrint('movieController : ok');
  WidgetsFlutterBinding.ensureInitialized();
  debugPrint('WidgetsFlutterBinding : ok');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  debugPrint('Firebase.initializeApp : ok');
  GoRouter router= MyAppRouter.router;
  debugPrint('GoRouter router= MyAppRouter.router; : ok');
  runApp(MyApp(routerr:router));
  debugPrint('GoRouter router= MyAppRouter.router; : ok');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key,required this.routerr});
  final GoRouter routerr;
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: routerr.routeInformationParser,
      routerDelegate: routerr.routerDelegate,
      routeInformationProvider: routerr.routeInformationProvider,
    );
  }
}