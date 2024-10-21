import 'package:auth_flutter_example/models/userModel.dart';
import 'package:auth_flutter_example/screens/authScreen/authScreenMixin.dart';
import 'package:auth_flutter_example/services/authServices.dart';
import 'package:auth_flutter_example/widgets/myDraggableScrollableSheet.dart';
import 'package:flutter/material.dart';

class Authscreen extends StatefulWidget {
  const Authscreen({super.key});

  @override
  State<Authscreen> createState() => _AuthscreenState();
}

class _AuthscreenState extends State<Authscreen> with AuthScreenMixin {
  String _authtitle = 'Auth Screen';

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.white,
          body: GestureDetector(
            onTap: () {
              closeDraggable();
              formType = 'logIn';

              setState(() {});
            },
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(top: 280),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          _authtitle,
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        loginButton(
                          space: 60,
                          title: 'Log in with email and password',
                          onPressed: () {
                            openDraggable();
                            setState(() {});
                          },
                        ),
                        loginButton(
                          space: 10,
                          title: 'Continue with Google',
                          onPressed: () async {
                            await Authservices().signInWithGoogle().then(
                              (user) {
                                if (user != null && user is UserModel) {
                                  Navigator.pushNamedAndRemoveUntil(context, '/home', (value) {
                                    return false;
                                  }, arguments: user);
                                }
                              },
                            );
                          },
                        ),
                        // loginButton(
                        //   space: 10,
                        //   title: 'Continue with Apple',
                        //   onPressed: () {
                        //     Authservices().signWithApple(context);
                        //   },
                        // ),
                        // loginButton(
                        //   space: 10,
                        //   title: 'Continue with Phone Number',
                        //   onPressed: () {},
                        // ),
                      ],
                    ),
                  ),
                ),
                myDraggableScrollableSheet(
                    draggableScrollableController: draggableScrollableController,
                    title: formType == "logIn"
                        ? 'Log in with email and password'
                        : 'Register in with email and password',
                    widget: formType == "logIn"
                        ? LoginForm(
                            context: context,
                            onRegister: () {
                              formType = 'register';
                              moveDraggable(0.85);
                              setState(() {});
                            })
                        : RegisterForm(
                            context: context,
                            onLogIn: () {
                              formType = 'logIn';
                              moveDraggable(0.7);
                              setState(() {});
                            }),
                    onClear: () {
                      formType = 'logIn';
                      setState(() {});
                      closeDraggable();
                    }),
              ],
            ),
          )),
    );
  }
}
