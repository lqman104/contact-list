import 'package:flutter/material.dart';

class SearchFormField extends StatelessWidget {
  final Function(String) onChange;
  const SearchFormField({super.key, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChange,
      decoration: InputDecoration(
          suffixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.grey.shade300,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          hintText: 'Search Name',
          hintStyle: const TextStyle(color: Colors.grey)),
    );
  }
}
