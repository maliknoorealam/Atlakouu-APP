import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(width: size.width * 0.25,),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 50,
            width: size.width * 0.65,
            decoration: BoxDecoration(
                color: whiteColor,
                borderRadius:  BorderRadius.circular(8),
                border: Border.all(color: goldColor,width: 2)
            ),
            child: const Center(child: Text(search,style: TextStyle(color: navyColor, fontWeight: FontWeight.w400, fontSize: 24),)),
          ),
        ),
      ],
    );
  }
}
