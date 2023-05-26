import 'package:bloc/bloc.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/shared/cubit/states.dart';

import '../../modules/todo_app/archived_tasks/archived_tasks_screen.dart';
import '../../modules/todo_app/done_tasks/done_tasks_screen.dart';
import '../../modules/todo_app/new_tasks/new_tasks_screen.dart';
import '../network/local/cashe_helper.dart';

//هون الللوجيك كلو يا شباب اي متغير نجيبو هون
class AppCubit extends Cubit<AppStates>{
 AppCubit() : super(AppInitialState());
 static AppCubit get(context)=> BlocProvider.of(context);
 int currentIndex=0;//لتغيير حالة acvtive  عند الضغط على الزر

 List<Widget> screens=[//للتنقل بين الشاشات نجيب الشاشات ونحطها ب ليست ثم نغير غن كريق ال currentindex  المخزن مسبقا للزر
  NewTasksScreen(),
  DoneTasksScreen(),
  ArchivedTasksScreen(),
 ];
 List<String> titels=[//لتغيير عموان الصفحة فوف
  'Tasks',
  'Done Tasks',
  'Archived Tasks',

 ];
 void changeIndex(int index){
  currentIndex=index;
  emit(AppChangeBottomNavBarState());
 }

 ////database process
 late Database database;//نخليها عامة مشات الاستخدام
 List<Map> newTasks=[];//لعرض القيم القادمة من الداتا بيس من نفس النوع يلي بالدالة
 List<Map> doneTasks=[];
 List<Map> archivedTasks=[];
 void createDatabase() {//crate evrythings about sqflite for database
   openDatabase(
   'todo.db',
   version: 1,//بما انة اول استخدام نعطي 1 نغير ال الفيرحن اذا غيرتا ب قاعدة البيانات مثلا ضفنا جدول
   onCreate: (database,version)async {
    print("database created ");
    database.execute('CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT,date TEXT ,time TEXT , status TEXT )').then((value){
     print("table created");
    }).catchError((error){
     print("error create table${error.toString()}");
    });
   },
   onOpen: (database){//منبعتلها الداتا بيس لتفادي الفطاء الذي يحدث حيث يجب ان يكون لا database الموجود ضمن database لانخ بينشاء قبلا
    getDataFromDatabase(database);

    // });//يما انة بدنا نجيب الداتا فمنستدعيا هون مشان تنحاب مع انشاء القاعدة
    print("database created ");
   },
  ).then((value){//بعمل اميت لما اتاكد انو خلص
    database=value;
    emit(AppCreateDatabaseState());
   });

 }
  insertToDatabase  ({
  required String title,
  required String time,
  required String date,
 }) async {//اذا بدي اعمل then  عليها فوق لازم نحط futur و return

   await database.transaction((txn){
   txn.rawInsert('INSERT INTO tasks(title,date,time,status) VALUES("${title}","${date}","${time}","new")').then((value){
    //value this is id what i was insert
    print("${value} inserted");
    emit(AppInsertDatabaseState());//اميت هون

   //هون ينفع نعمل getfromdatabase لامو غملنا انسيرت وخلصن
////////
    getDataFromDatabase(database);
   }).catchError((error){
    print("Error when inserting new record${error.toString()}");
   });
   return Future(() => null);
  });

 }
////update
  void updateData({
  required String status,
    required int id
}) {
     database.rawUpdate(
    'UPDATE tasks SET status= ? WHERE id= ?',
     ['$status','$id']

   ).then((value){
     getDataFromDatabase(database);//بس تخلص اعمل get تاني لحتا تحدث الحالة مباشرة
     emit(AppUpdateDatabaseState());
     //we will get it

     });

  }
  ////dalete
  void deleteData({

    required int id
  }) {
    database.rawDelete(
        'DELETE FROM  tasks WHERE   id= ?',
        ['$id']

    ).then((value){
      getDataFromDatabase(database);//بس تخلص اعمل get تاني لحتا تحدث الحالة مباشرة
      emit(AppDeleteDatabaseState());
      //we will get it

    });

  }



void getDataFromDatabase(database) {  // منحطا من نوع فيوتشر لانة بالاصل اتا بدي امسك المعلومات بادي لاعرضها
 newTasks=[];//دائما لما نحيب الدانا نصفر لامة ممكن تصير مشكلة اذا جبناها مرتين رح يتطررو فوق بعض
doneTasks=[];
archivedTasks=[];
   emit(AppGetDatabaseLoadingState());//لكي نعمل شريط التحميل تغمل ستيت و نرجع نامت عليها نضعها قبل ما خلص غيت بالطبظ
//كمخلية يظهر لنا السنسن دي تيجي

  //بدل ما اسستدغي ال then كل مرة لما استدغي الgetfromdatabase  بحطا هون كرة وخدة
   database.rawQuery("SELECT * FROM tasks").then((value){//عطاني الليستا

     //مادام ال tasks في constants فهي مسمعة في كل السكريتات مش مختاجة setstate لاكن وضع الsetstate ليس غلط


    //بهد تعريف ليستا لكل نوع من المخام الجدلدة وو المنتخية و الارشيف عندما نجيب الداتا منمر على حمبع الغهناصر و التحقق و الملئ بنا يناسب
    value.forEach((element) {
      if(element['status']=='new' ){
        newTasks.add(element);}
        else if(element['status']=='done'){
          doneTasks.add(element);
      }
        else{
          archivedTasks.add(element);
      }


    });

     emit(AppGetDatabaseState());//هنا نعمل اميت

   });

 }


 ////bottom change icon state and state is shown or not
 bool isBotomSheetShown = false; //لعمل توغل بين حادتين او تبديل
 IconData fabIcon = Icons.edit;
 void changeBottomSheetState({
 required bool isShow,
  required IconData icon,
}){
    isBotomSheetShown=isShow;
    fabIcon=icon;
    emit(AppChangeBottomSheetState());
 }
 //dart and light mode
bool isDark=false;
 //ما بدي ياها اثناء الضغط بدي ياها اثناء تشغيل البرنامج
 void changeAppMode({bool?  fromShared}){//خلية اخنياري لان بدي ابعت معو حاجة لما بدي استدغية من المين
  if(fromShared !=null){
    isDark=fromShared;//القيمة الجيالي من لالشيرد
    emit(AppChangeModeState());
  }else {
    isDark = !isDark;
    //here for sharedPreferencess and set save value mode
    CasheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
      emit(AppChangeModeState());

    });
  }
 }

}



