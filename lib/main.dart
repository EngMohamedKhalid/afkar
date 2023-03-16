import 'package:afkar/layout/BNB_layout/BNB_layout_screen.dart';
import 'package:afkar/modules/sign_in/sign_in_screen.dart';
import 'package:afkar/modules/sign_up/sign_up_screen.dart';
import 'package:afkar/shared/cubit/cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'shared/cubit/bloc_observer.dart';
//11.0.15
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await EasyLocalization.ensureInitialized();
  runApp(
      MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => AppCubit()..createDatabase(),)
    ],
      child: EasyLocalization(
          supportedLocales:const [ Locale('en',), Locale('ar',)],
          path: 'assets/translations',
          fallbackLocale: const Locale('en',),
          startLocale: const Locale("ar"),
          saveLocale: true,
        child: const MyApp(),
      ),
  )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(392.72727272727275, 737.4545454545455),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return child!;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home:SignInScreen()
        //FirebaseAuth.instance.currentUser==null?SignInScreen():const BNBLayoutScreen(),
      ),
    );
  }
}
