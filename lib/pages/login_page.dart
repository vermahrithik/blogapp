import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:blogapp/routing/app_route_constants.dart';
import 'package:blogapp/pages/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim()).then((value) {
        if(value.user?.uid!=null){
          SharedPreferences.getInstance().then((value) => value.setBool('isLoggedIn', true),);
          context.goNamed(MyAppRouteConstants.homeRouteName);
        }
      },);
  }

  Future<UserCredential?> signInWithGoogle() async{
    try{
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);

    }on FirebaseAuthException catch (e){
      // final ex = TExceptions.fromCode(e.code);
      final ex = TlsException(e.code);
      throw ex.message;
    }catch (_){
      const ex = TlsException();
      throw ex.message;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
        child: Scaffold(
          backgroundColor: const Color(0xff353434),
          appBar: AppBar(
            title: const Text(
              'FILMFLIX',
              style: TextStyle(
                  letterSpacing: 8,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Color(0xffE50914)
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 28,
                      ),
                      Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: 8,
                              width: 8,
                              decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 64,
                                        blurStyle: BlurStyle.normal,
                                        color: Color(0xfff2f2f3),
                                        offset: Offset(0, 0),
                                        spreadRadius: 16
                                    ),
                                  ]
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                'assets/images/logo.png',
                                // height: 500,
                                fit: BoxFit.fitHeight,
                                height: deviceHeight * 0.2,
                              ),
                            ),
                          ]
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 30,
                            ),
                            Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xfff2f2f3)),
                            ),
                          ]),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // SizedBox(
                          //   width: 20,
                          // ),
                          const Text(
                            '@',
                            style: TextStyle(color: Color(0xfff2f2f3), fontSize: 25),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: TextFormField(
                              controller: emailController,
                              cursorColor: const Color(0xfff2f2f3),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'Email ID',
                                hintStyle: const TextStyle(
                                    color: Color(0xfff2f2f3),
                                    fontWeight: FontWeight.w300),
                                labelStyle:
                                const TextStyle(color: Color(0xfff2f2f3)),
                                enabled: true,
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Color(0xfff2f2f3), width: 1),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade700, width: 1),
                                ),
                                border: const UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Color(0xfff2f2f3), width: 1),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.lock_outline_rounded,
                            color: Color(0xfff2f2f3),
                            size: 24.0,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: TextFormField(
                              controller: passwordController,
                              keyboardType: TextInputType.text,
                              cursorColor: const Color(0xfff2f2f3),
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: const TextStyle(
                                    color: Color(0xfff2f2f3),
                                    fontWeight: FontWeight.w300),
                                labelStyle:
                                const TextStyle(color: Color(0xfff2f2f3)),
                                errorStyle: const TextStyle(color: Colors.red),
                                errorBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                enabled: true,
                                // prefixIcon: Icon(Icons.text_fields),
                                suffixIcon: togglePassword(),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Color(0xfff2f2f3), width: 1),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade700, width: 1),
                                ),
                                border: const UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Color(0xfff2f2f3), width: 1),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Forgot Password?',
                            style: TextStyle(
                                color: Color(0xfff2f2f3),
                                fontWeight: FontWeight.w500,
                                fontSize: 14),
                          ),
                          SizedBox(
                            width: 30,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: ElevatedButton(
                          onPressed: () {
                            signIn();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xfff2f2f3),
                            fixedSize: Size(deviceWidth * 0.75, 30.0),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff353434),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // SizedBox(width: ,),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            height: MediaQuery.of(context).size.height * 0.002,
                            color: const Color(0xfff2f2f3),
                          ),
                          const SizedBox(
                            width: 8,
                            height: 0,
                          ),
                          const Text(
                            'OR',
                            style: TextStyle(color: Color(0xfff2f2f3), fontSize: 15),
                          ),
                          const SizedBox(
                            width: 8,
                            height: 0,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            height: MediaQuery.of(context).size.height * 0.002,
                            color: const Color(0xfff2f2f3),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: ElevatedButton(
                          onPressed: () {
                            signInWithGoogle();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xfff2f2f3),
                            fixedSize: Size(deviceWidth * 0.75, 30.0),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/google.png',
                                height: 20,
                                width: 20,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              const Text(
                                'Login with Google',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xff353434),
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const SignUpPage()));
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'New to Logistics ?',
                                style: TextStyle(
                                    color: Color(0xfff2f2f3),
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Text(
                                'Sign Up',
                                style: TextStyle(
                                    color: Color(0xfff2f2f3),
                                    fontWeight: FontWeight.w800),
                              ),
                            ],
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      // InkWell(
                      //   onTap: (){
                      //     context.goNamed(MyAppRouteConstants.phoneRouteName);
                      //   },
                      //   child: Container(
                      //     height: 40,
                      //     width: 140,
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(50),
                      //       border: Border.all(
                      //         color: Colors.white
                      //       ),
                      //     ),
                      //     child: const Center(
                      //       child: Text(
                      //         'login with phone',
                      //         style: TextStyle(
                      //           color: Colors.white
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          SystemNavigator.pop();
          return true;
        });
  }

  Widget togglePassword() {
    return IconButton(
      onPressed: () {
        setState(() {
          _obscureText = !_obscureText;
        });
      },
      icon: _obscureText
          ? const Icon(Icons.visibility_outlined)
          : const Icon(Icons.visibility_off_outlined),
      color: const Color(0xfff2f2f3),
    );
  }
}