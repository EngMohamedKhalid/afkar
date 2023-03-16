import 'package:afkar/layout/BNB_layout/BNB_layout_screen.dart';
import 'package:afkar/shared/component/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirebaseSignIn {
  static Future<void> signIn({required String email,required String password , required BuildContext context})async{
    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    ).then((value){
      Fluttertoast.showToast(
        msg: "Sign in Successfully",
        gravity: ToastGravity.CENTER_RIGHT,
        timeInSecForIosWeb: 2,
      ).then((value) {
        navigateAndRemove(context: context, widget: BNBLayoutScreen());
      });
    }).catchError((error){
      Fluttertoast.showToast(
        msg: error.toString(),
        gravity: ToastGravity.CENTER_RIGHT,
        timeInSecForIosWeb: 5,
      );
    });
  }
}