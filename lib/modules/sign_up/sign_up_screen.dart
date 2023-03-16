// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'dart:io';
import 'dart:math';

import 'package:afkar/modules/sign_in/sign_in_screen.dart';
import 'package:afkar/shared/component/custom_button.dart';
import 'package:afkar/shared/component/custom_text_field.dart';
import 'package:afkar/shared/constant.dart';
import 'package:afkar/shared/network/remote/fire_base_sign_up.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class SignUpScreen extends StatefulWidget {
   SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var pickedImage;

   File? image;

   String? url;

  final ImagePicker imagePicker = ImagePicker();

   @override
   Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: color5,
      body:
      Center(
        child: Container(
          margin:  EdgeInsets.all(20.sp),
          padding:  EdgeInsets.all(30.sp),
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(10)
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
                     "Welcome",
                     style: TextStyle(
                       fontSize: 22.sp,
                       fontWeight: FontWeight.w900,
                       color: Colors.white
                     ),
                   ),
                  SizedBox(height: 30.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async{
                        pickedImage = await imagePicker.pickImage(
                              source: ImageSource.gallery,
                          );
                          // setState(() {
                          //  pickedImage = image;
                          // });
                        },
                        child: CircleAvatar(
                          radius: 40.sp,
                          backgroundColor: color2,
                          child:
                          image==null?Icon(
                            Icons.person_pin,
                            color: color7,
                            size: 60.sp,
                          ):Image.file(image!),
                        )
                      ),
                    ],
                  ),
                  SizedBox(height: 40.h,),
                  CustomStatelessTextField(
                    helpText: "Mohamed Khalid",
                      labelText: "name".tr(),
                    controller: nameController,
                  ),
                  SizedBox(height: 12.h,),
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
                  CustomButton(
                      onPressed:  ()async{
                       if(formKey.currentState!.validate()){
                        FirebaseSignUp.signUp(
                            name: nameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            context: context
                        ).then((value) async{
                          image = File(pickedImage.path);
                          var name = basename(pickedImage.path);
                          var rand = Random().nextInt(100000000);
                          name = rand.toString()+name;
                          var refStorage= FirebaseStorage.instance.ref("images/$name");
                          await refStorage.putFile(image!);
                          url = await refStorage.getDownloadURL();
                         await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).update(
                              {
                                "image":url,
                              }
                          );
                        }
                        );
                        }else{}
                      },
                    text: "signUp".tr(),
                  ),
                  SizedBox(height: 10.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text(
                        "haveAccount".tr(),
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white
                        ),
                      ),
                      TextButton(
                        onPressed:(){
                          navigateTo(context: context, widget: SignInScreen());
                        },
                        child: Text(
                          "signIn".tr(),
                          style: TextStyle(
                              fontSize: 18.sp,
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
      ),
    );
  }
}
