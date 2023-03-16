import 'package:afkar/modules/add/add_screen.dart';
import 'package:afkar/modules/home/home_screen.dart';
import 'package:afkar/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit <AppStates>{
  AppCubit(): super (InitialAppState());
 static AppCubit getObject(context)=> BlocProvider.of(context);
  late Database database ;
  int current = 0;
  bool isOpend = false;
  bool isLoading = true;
  List<Map<String ,dynamic>> notes = [];
  List<Widget>bodyScreen= [
    HomeScreen(),
    AddScreen(),
  ];
  void changeCurrentIndex (int index){
    current = index;
    emit(BNBChangeCurrentIndex());
  }
  void changeFABIcon(bool index){
   isOpend = index;
    emit(FABChange());
  }
  void loading(bool index){
    isLoading = index;
    emit(Loading());
  }
  void createDatabase(){
    openDatabase(
      "note.db",
      version: 1,
      onCreate: (db, version) {
        print("database created");
        db.execute(
            "create table notes (id INTEGER PRIMARY KEY , title TEXT , content TEXT , date TEXT , time TEXT)"
        ).then((value) {
          print("table created");
        }).catchError((onError){
          print("error${onError.toString()}");
        });
      },
      onOpen: (db) {
        getDataFromDatabase(db);
        print("database opened $db");
      },
    ).then((value){
      database = value;
      emit(DataCreate());
    });
  }
  insertToDatabase({required String title,required String content,required String date ,required String time})async{
    await database.transaction((txn) async{
      txn.rawInsert("insert into notes (title,content,date,time) values ('$title' ,'$content','$date','$time')").then((value) {
        print("$value $txn insert Successfully");
          emit(DataInsert());
          getDataFromDatabase(database);
      }).catchError((onError){
        print("error${onError.toString()}");
      });
      return null;
    });
  }
  void getDataFromDatabase (database){
    notes = [];
    emit(DataGet());
    database.rawQuery("select * from notes").then((value){
      value.forEach((element) {
        notes.add(element);
        print("newTasks${notes}");
      });
      emit(DataGet());
    });
  }
  void deleteStatus({ required int id}){
    database.rawDelete(
        "delete from notes where id = ?",[id]
    ).then((value) {
        getDataFromDatabase(database);
        emit(DataDelete());
    });
  }
}

