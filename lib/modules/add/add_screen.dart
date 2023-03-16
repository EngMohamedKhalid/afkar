import 'package:afkar/modules/view_note/view_note.dart';
import 'package:afkar/shared/component/custom_text_field.dart';
import 'package:afkar/shared/constant.dart';
import 'package:afkar/shared/cubit/cubit.dart';
import 'package:afkar/shared/cubit/states.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class AddScreen extends StatelessWidget {
  AddScreen({Key? key}) : super(key: key);
  final TextEditingController noteTitleController = TextEditingController();
  final TextEditingController noteContentController = TextEditingController();
  final TextEditingController noteTimeController = TextEditingController();
  final TextEditingController noteDateController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if(state is DataInsert){
          Navigator.pop(context);
          noteTitleController.clear();
          noteContentController.clear();
          noteTimeController.clear();
          noteDateController.clear();
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.getObject(context);
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: color5,
          floatingActionButton: FloatingActionButton(
            backgroundColor: color7,
            onPressed: () {
              if (cubit.isOpend) {
                if (formKey.currentState!.validate()) {
                  cubit.insertToDatabase(
                      title: noteTitleController.text,
                      content: noteContentController.text,
                      date: noteDateController.text,
                      time:noteTimeController.text ,
                  );
                }
              } else {
                scaffoldKey.currentState!.showBottomSheet(
                      (context) {
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      color: Colors.white,
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(height: 30.h,),
                            CustomStatelessTextField(
                              controller: noteTitleController,
                              labelText: "noteTitle".tr(),
                              helpText: "typeTitle".tr(),
                            ),
                            SizedBox(height: 30.h,),
                            CustomStatelessTextField(
                              controller: noteContentController,
                              labelText: "noteContent".tr(),
                              helpText: "typeNote".tr(),
                            ),
                            SizedBox(height: 30.h,),
                            CustomStatelessTextField(
                              controller: noteTimeController,
                              keyType: TextInputType.none,
                              labelText: "time".tr(),
                              onTap: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((value) {
                                  noteTimeController.text = value!.format(context);
                                });
                              },
                            ),
                            SizedBox(height: 30.h,),
                            CustomStatelessTextField(
                              controller:noteDateController,
                              keyType: TextInputType.none,
                              labelText: "date".tr(),
                              onTap: () {
                                showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.parse("2222-12-31")
                                ).then((value) {
                                  noteDateController.text = DateFormat.yMMMMEEEEd().format(value!);
                                }
                                );
                              },
                            ),
                            SizedBox(height: 30.h,),
                          ],
                        ),
                      ),
                    );
                  },
                ).closed.then((value) {
                  cubit.changeFABIcon(false);
                }
                );
              }
              cubit.changeFABIcon(true);
            },
            child: cubit.isOpend ?const Icon(
              Icons.save_as,
              size: 35,
            ) : const Icon(
              Icons.edit_note,
              size: 35,
            ),
          ),
          body: ListView.builder(
            itemCount: cubit.notes.length,
            physics:const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
           itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) {
                        return ViewNote(
                          title: cubit.notes[index]["title"],
                          content: cubit.notes[index]["content"],
                        );
                      },
                  )
                );
              },
              child: Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) {
                  cubit.deleteStatus(id: cubit.notes[index]["id"]);
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                   padding: EdgeInsets.all(5),
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(10),
                     color: color1,
                   ),
                   child:ListTile(
                     contentPadding: EdgeInsets.symmetric(horizontal: 10),
                     title: Row(
                       mainAxisSize: MainAxisSize.min,
                       children: [
                         Text(
                           "${"noteTitle".tr()} :- " ,
                           style: TextStyle(
                               fontSize: 22.5.sp,
                               color: Colors.red,
                               fontWeight: FontWeight.bold
                           ),
                         ),
                         Text(
                            cubit.notes[index]["title"],
                           style: TextStyle(
                               fontSize: 20.sp,
                               color: Colors.white,
                               fontWeight: FontWeight.bold
                           ),
                         ),
                       ],
                     ) ,
                     subtitle: Row(
                       mainAxisSize: MainAxisSize.min,
                       children: [
                         Text(
                           "${"noteContent".tr()} :- " ,
                           style: TextStyle(
                               fontSize: 22.5.sp,
                               color: Colors.red,
                               fontWeight: FontWeight.bold
                           ),
                         ),
                         Expanded(
                           child: Text(
                             cubit.notes[index]["content"],
                             textAlign: TextAlign.center,
                             maxLines: 1,
                             overflow: TextOverflow.ellipsis,
                             style: TextStyle(
                               fontSize: 25.sp,
                               color: Colors.white,
                             ),
                           ),
                         ),
                       ],
                     ),


                   ) ,
                 ),
              ),
            );
           },
          ),
        );
      },
    );
  }
}


