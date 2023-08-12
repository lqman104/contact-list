import 'package:flutter/material.dart';

class SearchFormField extends StatelessWidget {
  const SearchFormField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
