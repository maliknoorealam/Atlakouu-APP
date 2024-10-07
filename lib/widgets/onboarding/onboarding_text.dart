import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class OnBoardText extends StatelessWidget {
  const OnBoardText({super.key, required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(left: 40, right: 40,bottom: 5),
      constraints: BoxConstraints(maxHeight: size.height/4.35,minHeight: size.height/10),
      child: Wrap(
        children: [
          AutoSizeText(
            description,
            textAlign: TextAlign.center,
            maxLines: 3,
            minFontSize: 10,
            maxFontSize: 30,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 23.5,
              color: navyColor,
            )
          ),
        ],
      ),
    );
  }
}
