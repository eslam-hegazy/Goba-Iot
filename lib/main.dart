import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:semi/presentation/screens/Login_screen.dart';
import 'package:semi/presentation/screens/home_screen.dart';
import 'package:semi/presentation/screens/splash_screen.dart';
import 'package:semi/presentation/style/themes.dart';

import 'package:sizer/sizer.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'business_logic/MyBlocObserver.dart';
import 'business_logic/login_cubit/login_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();
  // await Firebase.initializeApp();
  await translator.init(
    localeType: LocalizationDefaultType.device,
    languagesList: <String>['ar', 'en'],
    assetsDirectory: 'assets/langs/',
  );
  runApp(
    LocalizedApp(
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return AdaptiveTheme(
          light: lightTheme,
          dark: darkTheme,
          initial: AdaptiveThemeMode.dark,
          builder: (theme, darkTheme) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => LoginCubit()..getData(),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: SplashScreen(),
              theme: theme,
              darkTheme: darkTheme,
              localizationsDelegates: translator.delegates,
              locale: translator.locale,
              supportedLocales: translator.locals(),
            ),
          ),
        );
      },
    );
  }
}
