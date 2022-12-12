import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:semi/business_logic/login_cubit/login_cubit.dart';
import 'package:semi/presentation/screens/Login_screen.dart';
import 'package:semi/presentation/style/colors.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
        return LoginScreen();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 25.h,
                    width: 25.h,
                    decoration: BoxDecoration(
                      color: AppColor.kBackground,
                      borderRadius: BorderRadius.circular(500.h),
                    ),
                    child: SvgPicture.asset("assets/images/splash_screen.svg"),
                  ),
                  Padding(
                    padding: EdgeInsets.all(3.h),
                    child: Text(
                      "titleSplash".tr(),
                      style: GoogleFonts.actor(
                          fontSize: 35.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
