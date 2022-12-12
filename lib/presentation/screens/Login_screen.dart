import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:semi/core/functions.dart';
import 'package:semi/presentation/screens/update_data_screen.dart';
import 'package:semi/presentation/style/colors.dart';

import 'package:sizer/sizer.dart';

import '../../business_logic/login_cubit/login_cubit.dart';
import '../../core/constant_image.dart';
import '../view/flutter_toast.dart';
import '../widgets/default_button.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LocalAuthentication auth = LocalAuthentication();
  late bool canCheckBiometric;
  late List<BiometricType> availableBiometric;
  String autherized = "Not autherized";

  //////Check
  Future<void> checkBiometric() async {
    late bool canCheck;
    try {
      canCheck = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      canCheckBiometric = canCheck;
    });
  }

  //this function will get all the available biometrics inside our device
  //it will return a list of objects, but for our example it will only
  //return the fingerprint biometric
  Future<void> getAvailableBiometrics() async {
    late List<BiometricType> available;
    try {
      available = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      availableBiometric = available;
    });
  }

  //this function will open an authentication dialog
  // and it will check if we are authenticated or not
  // so we will add the major action here like moving to another activity
  // or just display a text that will tell us that we are authenticated
  Future<void> authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: "Scan your finger print to authenticate",
      );
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      autherized =
          authenticated ? "Autherized success" : "Failed to authenticate";
      if (authenticated) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
          return HomeScreen();
        }));
      } else {
        toast("Please scan your finger", Colors.red);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    checkBiometric();
    getAvailableBiometrics();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Scaffold(
          body: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(12.w),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return UpdateDataScreen();
                      }));
                    },
                    child: Text(
                      "login".tr(),
                      style: GoogleFonts.fredoka(
                          fontSize: 30.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  SvgPicture.asset(
                    ConstantImage.authLogin,
                    height: 20.h,
                  ),
                  Text(
                    "titleLogin".tr(),
                    style: GoogleFonts.cairo(
                        fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 9.w),
                    child: Text(
                      "subTitleLogin".tr(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cairo(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 3.h),
                  DefaultButton(
                    title: "authButton".tr(),
                    press: () {
                      authenticate();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
