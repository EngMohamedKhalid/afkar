import 'package:flutter/material.dart';

void navigateTo({required BuildContext context , required Widget widget}){
  Navigator.of(context).push(
      MaterialPageRoute(builder:(context) => widget, )
  );
}
void navigateAndRemove({required BuildContext context , required Widget widget}){
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => widget,),
          (Route<dynamic> route)=>false
  );
}

Color color1 = const Color(0xff65b0bb);
Color color2 = const Color(0xff5a9ea8);
Color color3 = const Color(0xff508c95);
Color color4 =const Color(0xff467b82);
Color color5 =const Color(0xff3c6970);
Color color6 =const Color(0xff32585d);
Color color7 =const Color(0xff28464a);
