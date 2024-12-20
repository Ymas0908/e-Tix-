import 'package:flutter/material.dart';


class SearchInput extends StatelessWidget {
  SearchInput({super.key, this.icon, this.placeholder,  this.controller,this.onChanged});
  final String? placeholder;
  final Icon? icon;
  TextEditingController? controller ;
  Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 1,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(fontSize: 18, color: Colors.black),
        decoration: InputDecoration(
          hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
          hintText: placeholder,
          suffixIcon: icon,
          border: OutlineInputBorder(
            borderSide:
            BorderSide(color: Theme.of(context).colorScheme.primary),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          // labelText: 'Rechercher une MMP',
        ),
      ),
    );
  }
}
