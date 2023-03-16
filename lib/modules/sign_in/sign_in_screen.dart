// ignore_for_file: must_be_immutable

import 'package:afkar/modules/sign_up/sign_up_screen.dart';
import 'package:afkar/shared/component/custom_button.dart';
import 'package:afkar/shared/component/custom_text_field.dart';
import 'package:afkar/shared/constant.dart';
import 'package:afkar/shared/cubit/cubit.dart';
import 'package:afkar/shared/cubit/states.dart';
import 'package:afkar/shared/network/remote/fire_base_sign_in.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInScreen extends StatelessWidget {
   SignInScreen({Key? key}) : super(key: key);
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color5,
      body: BlocConsumer<AppCubit, AppStates>(
  listener: (context, state) {},
  builder: (context, state) {
    var cubit = AppCubit.getObject(context);
    return Center(
        child: Container(
          margin:  EdgeInsets.all(20.sp),
          padding: EdgeInsets.all(30.sp),
          decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(10.sp)
          ),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "welcomeBack".tr(),
                    style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w900,
                        color: Colors.white
                    ),
                  ),
                  SizedBox(height: 40.h,),
                  CustomStatelessTextField(
                    helpText: "exampel@gmail.com",
                    labelText: "email".tr(),
                    controller: emailController,
                  ),
                   SizedBox(height: 12.h,),
                  CustomStatelessTextField(
                    helpText: "passwordChar".tr(),
                    labelText: "password".tr(),
                    controller: passwordController,
                  ),
                  SizedBox(height: 30.h,),
                  cubit.isLoading?
                  CustomButton(
                    onPressed:  ()async{
                      cubit.loading(false);
                      if(formKey.currentState!.validate()){
                        FirebaseSignIn.signIn(email: emailController.text, password: passwordController.text, context: context);
                        cubit.loading(true);
                      }else{
                        print("Not Validate");
                      }
                    },
                    text: "signIn".tr(),
                  ):Center(
                    child: CircularProgressIndicator(),
                  ),
                  SizedBox(height: 10.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "noAccount".tr(),
                        style: TextStyle(
                            fontSize: 16.h,
                            fontWeight: FontWeight.w600,
                            color: Colors.white
                        ),
                      ),
                      TextButton(
                          onPressed:(){
                            navigateTo(context: context, widget: SignUpScreen());
                          },
                          child: Text(
                            "signUp".tr(),
                            style: TextStyle(
                                fontSize: 18.h,
                                fontWeight: FontWeight.w600,
                                color: Colors.deepOrange
                            ),
                          ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
  },
),
    );
  }
}
