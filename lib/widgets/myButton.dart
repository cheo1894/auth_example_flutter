import 'package:auth_flutter_example/widgets/loadWidget.dart';
import 'package:auth_flutter_example/widgets/myText.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  String title;
  Function()? onPressed;
  bool load;
  Color? backgroundColor;
  Color? borderColor;
  Color? titleColor;
  MyButton(
      {super.key,
      this.title = '',
      this.onPressed,
      this.load = false,
      this.backgroundColor,
      this.borderColor, this.titleColor});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: double.infinity),
      child: ElevatedButton(
        child: load
            ? LoadWidget(
                size: 20,
              )
            : MyText(
                text: title,
                color: titleColor,
              ),
        onPressed: onPressed != null && !load ? onPressed : null,
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 15),
            elevation: 0,
            backgroundColor: backgroundColor ?? Colors.deepPurple[400],

            shape: RoundedRectangleBorder(
              side: BorderSide(color: borderColor ?? Colors.transparent),
              borderRadius: BorderRadius.circular(16),
            )),
      ),
    );
  }
}
