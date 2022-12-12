import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:semi/business_logic/login_cubit/login_cubit.dart';
import 'package:semi/presentation/view/flutter_toast.dart';
import 'package:semi/presentation/widgets/item_update.dart';
import 'package:sizer/sizer.dart';

class UpdateDataScreen extends StatelessWidget {
  final TextEditingController temperatureController = TextEditingController();
  final TextEditingController oximeterController = TextEditingController();
  final TextEditingController heartController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      builder: (context, state) {
        var cubit = LoginCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text("title_dash".tr()),
          ),
          body: Padding(
            padding: EdgeInsets.all(2.h),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ItemUpdate(
                    controller: temperatureController,
                    hintText: "Enter Temperature",
                    labelText: "Temperature",
                    press: () {
                      if (temperatureController.text.isNotEmpty) {
                        cubit.addData(
                            degree: temperatureController.text,
                            doc: "KbelScjjJQ4iKSklqosP");
                        temperatureController.text = '';
                        toast("Send Successfully", Colors.black);
                      }
                    },
                    resetPress: () {
                      cubit.addData(degree: "0", doc: "KbelScjjJQ4iKSklqosP");
                      toast("Reset Successfully", Colors.amber);
                    },
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  ItemUpdate(
                    controller: heartController,
                    hintText: "Enter Heart Rate",
                    labelText: "Heart Rate",
                    press: () {
                      if (heartController.text.isNotEmpty) {
                        cubit.addData(
                            degree: heartController.text,
                            doc: "aTAmVT0xORWElt9vW2Rx");
                        heartController.text = '';
                        toast("Send Successfully", Colors.black);
                      }
                    },
                    resetPress: () {
                      cubit.addData(degree: "0", doc: "aTAmVT0xORWElt9vW2Rx");
                      toast("Reset Successfully", Colors.amber);
                    },
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  ItemUpdate(
                    controller: oximeterController,
                    hintText: "Enter Oximeter",
                    labelText: "Oximeter",
                    press: () {
                      if (oximeterController.text.isNotEmpty) {
                        cubit.addData(
                            degree: oximeterController.text,
                            doc: "Gmg6j8jYpsRwBSHFhpdw");
                        oximeterController.text = '';
                        toast("Send Successfully", Colors.black);
                      }
                    },
                    resetPress: () {
                      cubit.addData(degree: "0", doc: "Gmg6j8jYpsRwBSHFhpdw");
                      toast("Reset Successfully", Colors.amber);
                    },
                  ),
                  SizedBox(
                    height: 8.h,
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
