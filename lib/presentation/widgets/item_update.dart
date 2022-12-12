import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sizer/sizer.dart';

import 'default_button.dart';

class ItemUpdate extends StatelessWidget {
  const ItemUpdate({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    required this.press,
    required this.resetPress,
  }) : super(key: key);
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final VoidCallback press;
  final VoidCallback resetPress;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(2.h),
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: hintText,
              labelText: labelText,
              suffixIcon: IconButton(
                onPressed: resetPress,
                icon: const Icon(Icons.restore),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.h),
              ),
            ),
          ),
        ),
        DefaultButton(
          press: press,
          title: "Update",
        ),
      ],
    );
  }
}
