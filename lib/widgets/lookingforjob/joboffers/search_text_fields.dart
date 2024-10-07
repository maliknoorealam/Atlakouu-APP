import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class SearchTextFields extends StatelessWidget {
  const SearchTextFields({super.key, required this.controller, required this.title});

  final TextEditingController controller;
  final String title;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Text(title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: navyColor,
                    fontSize: 25
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                  color: navyColorWithOpacity,
                  borderRadius: BorderRadius.circular(5)
              ),
              margin: const EdgeInsets.only(left: 10),
              width: size.width * 0.65,
              child: TextFormField(
                controller: controller,
                decoration: const InputDecoration(
                    border: InputBorder.none
                ),
              ),
            ),
          ]
      ),
    );
  }
}
