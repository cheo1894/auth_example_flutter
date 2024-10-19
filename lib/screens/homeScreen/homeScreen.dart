
import 'package:auth_flutter_example/models/userModel.dart';
import 'package:auth_flutter_example/services/authServices.dart';
import 'package:auth_flutter_example/services/servicesMixin.dart';
import 'package:auth_flutter_example/widgets/myAppBar.dart';
import 'package:auth_flutter_example/widgets/myButton.dart';
import 'package:auth_flutter_example/widgets/myText.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget with Servicesmixin {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as UserModel;

    return PopScope(
      canPop: false,
      child: Scaffold(
          appBar: MyAppBar(
            title: 'Home screen',
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MyText(
                  text: 'Home Screen',
                ),
                SizedBox(
                  height: 10,
                ),
                MyText(
                  text: args.email,
                ),
                SizedBox(
                  height: 20,
                ),
                MyButton(
                  title: 'Sing out',
                  onPressed: () async {
                    await Authservices().signOut(context, args).then((value) {
                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: MyText(
                    text: 'session closed successfully',
                  )));
                    },);
                  },
                )
              ],
            ),
          )),
    );
  }
}
