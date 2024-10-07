import 'package:atalakou/utils/constants.dart';
import 'package:flutter/material.dart';

class BackArrow extends StatelessWidget {
  final double iconSize;
  BackArrow({super.key,this.iconColor = whiteColor,this.iconSize = 20.0, });

  Color iconColor;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(Icons.arrow_back_ios_new,color: iconColor, size: iconSize,));
  }
}
