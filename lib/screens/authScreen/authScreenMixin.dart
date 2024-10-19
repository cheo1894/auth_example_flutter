
import 'package:auth_flutter_example/models/userModel.dart';
import 'package:auth_flutter_example/services/authServices.dart';
import 'package:auth_flutter_example/widgets/myButton.dart';
import 'package:auth_flutter_example/widgets/myText.dart';
import 'package:auth_flutter_example/widgets/myTextFormfield.dart';
import 'package:flutter/material.dart';

mixin AuthScreenMixin {
  Duration _duration = Duration(milliseconds: 300);
  DraggableScrollableController draggableScrollableController = DraggableScrollableController();
  String formType = 'logIn';
  loginButton(
          {double space = 0.0,
          String title = '',
          dynamic Function()? onPressed,
          bool load = false}) =>
      Column(
        children: [
          SizedBox(
            height: space,
          ),
          MyButton(
            title: title,
            onPressed: onPressed,
            load: load,
          ),
        ],
      );

  void closeDraggable() {
    draggableScrollableController.animateTo(0.0, duration: _duration, curve: Curves.easeIn);
  }

  void openDraggable() {
    draggableScrollableController.animateTo(0.7, duration: _duration, curve: Curves.easeIn);
  }

  void moveDraggable(double value) async {
    draggableScrollableController.animateTo(value, duration: _duration, curve: Curves.easeIn);
  }

  LoginForm({dynamic Function()? onRegister, required BuildContext context}) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 10,
          ),
          MyTextFormField(
            controller: _emailController,
            title: 'Email',
            validator: (value) {
              if (value == '' || value == null) {
                return 'This field cannot be empty';
              }

              return null;
            },
          ),
          SizedBox(
            height: 10,
          ),
          MyTextFormField(
            controller: _passwordController,
            title: 'Password',
            validator: (value) {
              if (value == '' || value == null) {
                return 'This field cannot be empty';
              }
              return null;
            },
          ),
          SizedBox(
            height: 20,
          ),
          MyButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                var response = await Authservices().loginWithEmailAndPassword(
                    email: _emailController.text, password: _passwordController.text);

                if (response != null && response is UserModel) {
                  closeDraggable();
                  Future.delayed(Duration(milliseconds: 500), () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: MyText(
                      text: 'Log in successfully',
                    )));
                    Navigator.pushNamedAndRemoveUntil(context, '/home', (value) {
                      return false;
                    }, arguments: response);
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: MyText(
                    text: 'The user does not exist',
                  )));
                }
              }
            },
            title: 'Log in',
          ),
          SizedBox(
            height: 10,
          ),
          MyButton(
            onPressed: onRegister,
            title: 'Register',
            titleColor: Colors.black,
            borderColor: Colors.deepPurpleAccent[400],
            backgroundColor: Colors.transparent,
          ),
        ],
      ),
    );
  }

  Form RegisterForm({required BuildContext context, dynamic Function()? onLogIn}) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _repeatPasswordController = TextEditingController();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          MyTextFormField(
            controller: _emailController,
            title: 'Email',
            validator: (value) {
              if (value == '' || value == null) {
                return 'This field cannot be empty';
              }

              return null;
            },
          ),
          SizedBox(
            height: 10,
          ),
          MyTextFormField(
            controller: _passwordController,
            title: 'Password',
            validator: (value) {
              if (value == '' || value == null) {
                return 'This field cannot be empty';
              }
              if (value.length < 8) {
                return 'The password is to weak';
              }
              return null;
            },
          ),
          SizedBox(
            height: 10,
          ),
          MyTextFormField(
            controller: _repeatPasswordController,
            title: 'Repeat password',
            validator: (value) {
              if (value == '' || value == null) {
                return 'This field cannot be empty';
              }
              if (value.length < 8) {
                return 'The password is to weak';
              }
              return null;
            },
          ),
          SizedBox(
            height: 20,
          ),
          MyButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                if (_passwordController.text != _repeatPasswordController.text) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: MyText(
                    text: 'Passwords do not match',
                  )));
                  return;
                }
                var response = await Authservices()
                    .createUser(email: _emailController.text, password: _passwordController.text, context: context);

                if (response != null && response is UserModel) {
                  closeDraggable();
                  Future.delayed(Duration(milliseconds: 500), () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: MyText(
                      text: 'User created successfully',
                    )));
                    Navigator.pushNamedAndRemoveUntil(context, '/home', (value) {
                      return false;
                    }, arguments: response);
                  });
                }
              }
            },
            title: 'Register',
          ),
          SizedBox(
            height: 10,
          ),
          MyButton(
            onPressed: onLogIn,
            title: 'Log In',
            titleColor: Colors.black,
            borderColor: Colors.deepPurpleAccent[400],
            backgroundColor: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
