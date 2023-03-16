import 'package:afkar/shared/constant.dart';
import 'package:afkar/shared/cubit/cubit.dart';
import 'package:afkar/shared/cubit/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BNBLayoutScreen extends StatelessWidget {
  const BNBLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.getObject(context);
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: color7,
            actions: [
              IconButton(
                padding: EdgeInsets.only(right: 10),
                onPressed: () {
                  if(context.locale.languageCode=="en"){
                    context.setLocale(Locale("ar"));
                  }else{
                    context.setLocale(Locale("en"));
                  }
                },
                icon: Icon(
                  Icons.language,
                  color: Colors.white,
                  size: 35.sp,
                ),
              ),
            ],
          ),
          drawer: Drawer(
            backgroundColor: color7,
            child: FutureBuilder(
               future: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get(),
               builder: (context, snapshot) {
                 return  Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       SizedBox(height: 30.h,),
                       CircleAvatar(
                        radius: 90.r,
                          backgroundImage: NetworkImage(snapshot.data!["image"]),
                      ),
                       SizedBox(height: 15.h,),
                       ListTile(
                         onTap: () {

                         },
                         title: Text(
                           snapshot.data!["name"],
                           style: TextStyle(
                               fontSize: 18.sp,
                               fontWeight: FontWeight.w600,
                               color: Colors.white
                           ),
                         ),
                       ),
                       SizedBox(height: 10.h,),
                       ListTile(
                         onTap: () {

                         },
                         title:Text(
                           snapshot.data!["email"],
                           style: TextStyle(
                               fontSize: 18.sp,
                               fontWeight: FontWeight.w600,
                               color: Colors.white
                           ),
                         ),
                       ),
                       SizedBox(height: 30.h,),
                       ListTile(
                         onTap: () {
                           if(context.locale.languageCode=="en"){
                             context.setLocale(Locale("ar"));
                           }else{
                             context.setLocale(Locale("en"));
                           }
                         },
                         title:  Text(
                           "changeLang".tr(),
                           style: TextStyle(
                               fontSize: 18.sp,
                               fontWeight: FontWeight.w600,
                               color: Colors.white
                           ),
                         ),
                       )
                     ],
                   ),
                 );
               },
            ),
          ),
          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: color5,
            height: 50.h,
            animationDuration: Duration(milliseconds: 350),
            //buttonBackgroundColor: Colors.cyan,easeInBack easeInCirc
            //animationCurve: Curves.slowMiddle ,
            index: cubit.current,
            onTap: (value) {
             cubit.changeCurrentIndex(value);
            },
            items:  [
             Icon(Icons.home,size: 35.sp,color: color7,),
             Icon(Icons.edit_note,size: 35.sp,color: color7,),
            ],
          ),
          body: cubit.bodyScreen[cubit.current],
        );
      },
    );
  }
}



