import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchInput extends StatelessWidget {
  SearchInput({super.key, this.icon, this.placeholder, this.controller, this.onChanged});

  final String? placeholder;
  final Icon? icon;
  final TextEditingController? controller;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: GoogleFonts.poppins(fontSize: 18, color: Colors.black),
        decoration: InputDecoration(
          hintStyle: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
          hintText: placeholder,
          suffixIcon: icon,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    );
  }
}
