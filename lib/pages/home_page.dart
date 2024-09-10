import 'package:blogapp/routing/app_route_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future signOut() async {
    await FirebaseAuth.instance.signOut();
    SharedPreferences.getInstance().then((value) => value.remove('isLoggedIn'),);
    context.goNamed(MyAppRouteConstants.loginRouteName);
    // SharedPreferences.getInstance().then((value) => value.setBool('isLoggedIn', true),);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            signOut();
          },
          child: Text('SignOut'),
        ),
      ),
    );
  }
}
