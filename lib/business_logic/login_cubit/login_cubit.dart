import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:meta/meta.dart';
import 'package:semi/data/model/data_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);
  List<DataModel> data = [];
  final Stream<QuerySnapshot> usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  void getData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .listen((event) {
      event.docs.forEach((element) {
        print(element.data());
        data.add(
          DataModel(
            name_en: element.data()['name_en'],
            name_ar: element.data()['name_ar'],
            degree: element.data()['degree'],
            index: element.data()['index'],
            type: element.data()['type'],
            startDegree: element.data()['startDegree'],
          ),
        );
      });
    });
  }

  void addData({required String degree, required String doc}) async {
    await FirebaseFirestore.instance.collection("users").doc(doc).set(
      {
        "degree": degree,
      },
      SetOptions(merge: true),
    );
  }

  List image = [
    "assets/images/temp.json",
    "assets/images/heart_rate.json",
    "assets/images/oximeter.json",
  ];
  /////////navigate
  Future navigate({VoidCallback? afterSuccess}) async {
    await Future.delayed(const Duration(milliseconds: 3000), () {});
    afterSuccess!();
  }
}
