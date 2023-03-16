import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewNote extends StatelessWidget {
  const ViewNote({Key? key,  this.title,  this.content}) : super(key: key);
final String? title;
final String? content;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed:() {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 30.sp,
            ),
        ),
        title: Text(
          "View Note",
          style: TextStyle(
            fontSize: 24,
            color: Colors.black
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Note Title:- $title",
                style: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.black,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 30.h,),
              Text(
                "Note Title:-\n $content",
                style: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
