import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: 50,
      minLines: 1,
      maxLines: 3,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(15),
        hintText: 'Search ENMU:',
        hintStyle: const TextStyle(fontSize: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(35.0),
        ),
      ),
    );
  }
}