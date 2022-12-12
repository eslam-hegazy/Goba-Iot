import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:lottie/lottie.dart';
import 'package:semi/business_logic/login_cubit/login_cubit.dart';
import 'package:semi/core/functions.dart';
import 'package:semi/presentation/style/colors.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "titleApp".tr(),
              style: GoogleFonts.acme(
                color: getStatusTheme(context) == true
                    ? AppColor.kWhite
                    : AppColor.kBlack,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  changeLanguage(context);
                },
                icon: Icon(
                  Icons.language,
                  color: getStatusTheme(context) == true
                      ? AppColor.kWhite
                      : AppColor.kBlack,
                ),
              ),
              IconButton(
                onPressed: () {
                  changeTheme(context);
                },
                icon: getStatusTheme(context) == true
                    ? Icon(
                        Icons.light_mode,
                        color: getStatusTheme(context) == true
                            ? AppColor.kWhite
                            : AppColor.kBlack,
                      )
                    : Icon(
                        Icons.light,
                        color: getStatusTheme(context) == true
                            ? AppColor.kWhite
                            : AppColor.kBlack,
                      ),
              ),
            ],
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: cubit.usersStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Something went wrong'),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView(
                physics: const BouncingScrollPhysics(),
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  var end = double.parse(data['degree']);
                  var index = int.parse(data['index']);
                  var start = double.parse(data['startDegree']);
                  return Container(
                    margin: EdgeInsets.all(5.w),
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: AppColor.kBlack.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(5.w),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              SizedBox(
                                  height: 10.h,
                                  width: 10.h,
                                  child: Lottie.asset(cubit.image[index])),
                              Text(
                                translator.currentLanguage == 'ar'
                                    ? data['name_ar']
                                    : data['name_en'],
                                style: GoogleFonts.cairo(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${data['degree']}  ${data['type']}",
                                style: GoogleFonts.acme(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Sparkline(
                            averageLine: true,
                            averageLabel: true,
                            gridLineLabelColor: AppColor.kWhite,
                            gridLineColor: Colors.grey,
                            useCubicSmoothing: true,
                            cubicSmoothingFactor: 0.2,
                            pointsMode: PointsMode.last,
                            pointIndex: 7,
                            pointSize: 9.sp,
                            lineColor: getStatusTheme(context) == true
                                ? AppColor.kWhite
                                : AppColor.kBlack,
                            lineWidth: 1.w,
                            pointColor: Colors.red,
                            data: [start, 0.5, 0.7, end],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            },
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
