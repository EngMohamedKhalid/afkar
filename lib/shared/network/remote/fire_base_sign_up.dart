import 'package:afkar/layout/BNB_layout/BNB_layout_screen.dart';
import 'package:afkar/shared/component/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirebaseSignUp {
  static Future<void> signUp({required String email,required String name,required String password , required BuildContext context})async{
     FirebaseAuth.instance.createUserWithEmailAndPassword(
         email: email,
         password: password,
     ).then((value){
       Fluttertoast.showToast(
           msg: "Sign Up Successfully",
         gravity: ToastGravity.CENTER_RIGHT,
         timeInSecForIosWeb: 2,
       ).then((value) async{
         navigateAndRemove(context: context, widget: BNBLayoutScreen());
         await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).set(
             {
               "name":name,
               "password":password,
               "email":email,
               "image":null,
             }
         );
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