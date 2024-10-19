import 'package:auth_flutter_example/services/personalInformation.dart';
import 'package:auth_flutter_example/widgets/myAppBar.dart';
import 'package:auth_flutter_example/widgets/myBottomBox.dart';
import 'package:auth_flutter_example/widgets/myButton.dart';
import 'package:auth_flutter_example/widgets/myText.dart';
import 'package:auth_flutter_example/widgets/myTextFormfield.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FormScreen extends StatefulWidget {
  FormScreen({Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  bool loadingButton = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Form Screen',
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  text: 'Personal Information',
                  fontSize: 22,
                ),
                SizedBox(
                  height: 20,
                ),
                MyTextFormField(
                  controller: firstNameController,
                  title: 'First name',
                  validator: (value) {
                    if (value == '' || value == null) {
                      return 'You must enter your first name';
                    }

                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                MyTextFormField(
                  controller: lastNameController,
                  title: 'Last name',
                  validator: (value) {
                    if (value == '' || value == null) {
                      return 'You must enter your last name';
                    }

                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                MyTextFormField(
                  controller: ageController,
                  title: 'Age',
                  validator: (value) {
                    if (value == '' || value == null) {
                      return 'You must enter your age';
                    }

                    return null;
                  },
                )
              ],
            ),
          )),
      bottomNavigationBar: MyBottomBox(
        child: MyButton(
          load: loadingButton,
          title: 'Send',
          onPressed: () async {
            if (formkey.currentState!.validate()) {
              formkey.currentState!.save();
              setState(() {
                loadingButton = true;
              });

              var response = await PersonalInformation().setPersonalInformation(
                  firstName: firstNameController.text,
                  lastName: lastNameController.text,
                  age: int.parse(ageController.text));

              if (response == 1) {
                setState(() {
                  loadingButton = false;
                });

                mySnackBar(context, 'Personal Information successfully saved');
              } else {
                setState(() {
                  loadingButton = false;
                });
                mySnackBar(context, 'An error has ocurred');
              }
            }
          },
        ),
      ),
    );
  }

  void mySnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
        content: MyText(
          text: text,
        )));
  }
}
