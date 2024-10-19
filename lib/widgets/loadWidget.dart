import 'package:flutter/material.dart';

class LoadWidget extends StatelessWidget {
  double size;
  LoadWidget({super.key, this.size = 10});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
        color: Colors.white,
        strokeWidth: 2,
        strokeCap: StrokeCap.round,
      ),
    );
  }
}
