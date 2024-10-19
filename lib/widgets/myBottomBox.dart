import 'package:flutter/material.dart';

class MyBottomBox extends StatelessWidget {
  Widget? child;
  MyBottomBox({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: 10, right: 10, top: 10, bottom: MediaQuery.of(context).viewInsets.bottom + 10),
      width: double.infinity,
      color: ThemeData.light().scaffoldBackgroundColor,
      child: child,
    );
  }
}
