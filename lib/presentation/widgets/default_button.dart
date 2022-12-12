import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:semi/presentation/style/colors.dart';
import 'package:sizer/sizer.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({Key? key, required this.press, required this.title})
      : super(key: key);
  final VoidCallback press;
  final String title;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      height: 7.h,
      elevation: 6,
      color: AppColor.kBlue,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.h),
        borderSide: const BorderSide(
          color: AppColor.kBlue,
        ),
      ),
      onPressed: press,
      child: Text(
        title,
        style: GoogleFonts.cairo(
          fontWeight: FontWeight.bold,
          color: AppColor.kWhite,
        ),
      ),
    );
  }
}
