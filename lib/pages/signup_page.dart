import 'package:blogapp/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;

  void handleVerification() {
    setState(() {
      //otpSent = true;
    });
  }

  void _showDialog() {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('title'),
          content: const Text('dialogBody'),
          actions: <Widget>[
            TextButton(
              child: const Text('buttonText'),
              onPressed: () {
                // Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.indigo,
          appBar: AppBar(
            title: const Text(
              'Sign Up Page',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: Colors.indigo,
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
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/images/logo.jpg',
                          // height: 500,
                          fit: BoxFit.fitHeight,
                          height: deviceHeight * 0.2,
                        ),
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
                              'Sign Up',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
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
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: TextFormField(
                              controller: emailController,
                              cursorColor: const Color(0xff6e8aef),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'Email ID',
                                hintStyle: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300),
                                labelStyle:
                                const TextStyle(color: Colors.white),
                                enabled: true,
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.white, width: 1),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade700, width: 1),
                                ),
                                border: const UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.white, width: 1),
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
                            color: Colors.white,
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
                              cursorColor: const Color(0xff6e8aef),
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300),
                                labelStyle:
                                const TextStyle(color: Colors.white),
                                errorStyle: const TextStyle(color: Colors.red),
                                errorBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                enabled: true,
                                // prefixIcon: Icon(Icons.text_fields),
                                suffixIcon: togglePassword(),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.white, width: 1),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade700, width: 1),
                                ),
                                border: const UnderlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.white, width: 1),
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
                                color: Colors.white,
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
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            fixedSize: Size(deviceWidth * 0.75, 30.0),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              color: Colors.indigo,
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
                            color: Colors.grey.shade300,
                          ),
                          const SizedBox(
                            width: 8,
                            height: 0,
                          ),
                          const Text(
                            'OR',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          const SizedBox(
                            width: 8,
                            height: 0,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            height: MediaQuery.of(context).size.height * 0.002,
                            color: Colors.grey.shade300,
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
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xfff0f4f4),
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
                                  color: Color(0xff768291),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const LoginPage()));
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already Registered ?',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          )),
                      const SizedBox(
                        height: 28,
                      ),
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
      color: Colors.white,
    );
  }
}