import 'package:flutter/material.dart';
import 'package:shakosh/new/Components/ParentCategories.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        ParentCategories()
      ],
    );
  }
}
