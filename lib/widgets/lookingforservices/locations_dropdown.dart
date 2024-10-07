import 'package:atalakou/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DropdownWidget extends StatelessWidget {
  final String hint;
  final String? selectedValue;
  final List<String> items;
  final void Function(String?)? onChanged;

  const DropdownWidget({
    super.key,
    required this.hint,
    this.selectedValue,
    required this.items,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: navyColor,
          borderRadius: BorderRadius.circular(10)
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Text(
            hint,
            style: GoogleFonts.oregano(
              textStyle: const TextStyle(color: Colors.white54, fontSize: 18),
            ),
          ),
          value: selectedValue,
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: GoogleFonts.oregano(
                  textStyle: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
          style: const TextStyle(color: whiteColor),
          dropdownColor: navyColor,
          icon: const Icon(Icons.search),
          iconDisabledColor: Colors.grey[700],
          iconEnabledColor: whiteColor,
        ),
      ),
    );
  }
}
