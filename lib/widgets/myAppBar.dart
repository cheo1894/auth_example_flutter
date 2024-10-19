import 'package:auth_flutter_example/widgets/myText.dart';

import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Size? preferredAppBarSize;
  final String title;
  const MyAppBar({Key? key, this.preferredAppBarSize, this.title = ''}) : super(key: key);

  @override
  Size get preferredSize => preferredAppBarSize ?? const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: false,
      title: MyText(
        text: title,
      ),
      titleSpacing: 10,
    );
  }
}
