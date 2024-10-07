import 'package:atalakou/utils/constants.dart';
import 'package:flutter/material.dart';


  buildBottomSheet(BuildContext context, {required VoidCallback onTapFunction, required String sheetText}){
    Size size = MediaQuery.of(context).size;
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: size.height / 4,
            width: size.width,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: goldColor,
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(25))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  sheetText,
                  textAlign: TextAlign.center,
                  style:
                  const TextStyle(color: whiteColor, fontSize: 24),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    bottomSheetButton(size, "Non",()=>Navigator.pop(context)),
                    bottomSheetButton(size, "Oui",() {
                      onTapFunction();
                      Navigator.pop(context);
                    }),
                  ],
                )
              ],
            ),
          );
        });
  }

  bottomSheetButton(Size size,String buttonText, VoidCallback onPressed){
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            backgroundColor: const WidgetStatePropertyAll(navyColor),
            fixedSize: WidgetStatePropertyAll(Size(size.width/2.5, 40)),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)))
        ),
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          style:
          const TextStyle(color: whiteColor, fontSize: 24),
        )
    );
  }


