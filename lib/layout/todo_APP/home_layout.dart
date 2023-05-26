import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';


import '../../modules/todo_app/new_tasks/new_tasks_screen.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
//ضمن ال statelase ما في initstate
//sqflite
//1.create database
  //.create table
//2.open database
//3.insert to database
//4.get from database
//5.update in database
//delete from database
class HomeLayout extends StatelessWidget {


  var scaffoldKey = GlobalKey<
      ScaffoldState>(); //لادخال المعبومات بما ان الفورم هو سكافلد
  var formKey = GlobalKey<FormState>(); //لعمل فاليديت

  var titleControler = TextEditingController();
  var timeControler = TextEditingController();
  var dateControler = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>AppCubit()..createDatabase(),


      // مانو سيقنو ب فاريبل لما عم اعطيو  .. و بالتالي يمكنني ان اخمل اكسسس عالي جواة
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
        //انا فيني روح عالدالة بالكيوبيت وابعن التغير ك بارا متر لاكن بما انة عمدي ليسن علة هذة الستيت فبس تخلص منحط هاد الشرط
          if(state is AppInsertDatabaseState){
               Navigator.pop(context);//تعمل الرجوع بهي وباكثر من شغلة

          }
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            //here key for form
            appBar: AppBar(
              title: Text(
                cubit.titels[cubit.currentIndex], //هتا
              ),
            ),
            body: ConditionalBuilder( // يدل ال inline if لكن لما نحد فيا القيمة للائحة اثناء اسنعاء getfromdatabase  نعمل   for reload screen  setstate
              condition: state is! AppGetDatabaseLoadingState,//هنا يطهر اذا كانت اي حالة اخرى غير هي
              builder: (context) => cubit.screens[cubit.currentIndex],
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
            //اذا كنا نريد ان نعرض سكرينة ضمن ال body  لسمرينة تانية قلا داغي ل scaffold ,,circolarProgresIndecator  هوي يلي بلف اذا ما كان في داتا اما اذا كات في فلا
            floatingActionButton: FloatingActionButton( //زر الزيادة

              onPressed: () {
                // insertToDatabase();//الادخال
                if (cubit.isBotomSheetShown) {
                  if (formKey.currentState!.validate()) { //التحقق من وجود قيم

                  cubit.insertToDatabase(title:titleControler.text, time: timeControler.text, date: dateControler.text);//هنا نقوم بالستدعائها بعد الوضع في cubit class


                  }
                } else {
                  scaffoldKey.currentState
                      ?.showBottomSheet( //الزر يلي بيطلع لقوق
                        (context) =>
                        Container(

                          color: Colors.grey[100],
                          padding: EdgeInsets.all(20.0),
                          child: Form(
                            key: formKey,
                            //لعمل الفاليديت نحول ال فورم ونهطيا key
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              //مشان ما يكلع للاخر
                              children: [
                                defaultFormfield(
                                    controller: titleControler,
                                    type: TextInputType.text,
                                    onChanged: (value) {},
                                    onSubmit: (value) {},
                                    validate: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'title must not be empty';
                                      }
                                      return null;
                                    },
                                    label: "Task Title",
                                    prefix: Icons.title),
                                SizedBox(
                                  height: 15.0,
                                ),
                                defaultFormfield(
                                  controller: timeControler,
                                  //كونترولر موجود عشان امسك القيمة يلي نكتبت ومتل ما فيني اخد منو كمان فيني اعطية
                                  type: TextInputType.datetime,
                                  onChanged: (value) {},
                                  onSubmit: (value) {},
                                  validate: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'time must not be empty';
                                    }
                                    return null;
                                  },
                                  label: "Task Time",
                                  prefix: Icons.watch_later_outlined,
                                  onTap: () {
                                    showTimePicker( //عرض كتابة التاريخ
                                      context: context,
                                      initialTime: TimeOfDay
                                          .now(), //القيمة المبدئية التي يفتح عليا وهون خترنا الةقت الحالي
                                    ).then((value) {
                                      timeControler.text =
                                          value!.format(context);
                                      //كونترولر موجود عشان امسك القيمة يلي نكتبت ومتل ما فيني اخد منو كمان فيني اعطية

                                      print(value.format(
                                          context), //الفورمات بظبط قيمة الوقت يعني بيعطية بالطريقة الصحيحة
                                      );
                                    }); //يما انة قيمة مستقبلية
                                  },
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                defaultFormfield(
                                  controller: dateControler,
                                  //كونترولر موجود عشان امسك القيمة يلي نكتبت ومتل ما فيني اخد منو كمان فيني اعطية
                                  type: TextInputType.datetime,
                                  onChanged: (value) {},
                                  onSubmit: (value) {},
                                  validate: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Date must not be empty';
                                    }
                                    return null;
                                  },
                                  label: "Task Date",
                                  prefix: Icons.calendar_today,
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(), //تاريخ اليوم
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse('2023-05-03'),)
                                        .then((
                                        value) { //الدوت ذين عشان اخد القفيمة منها

                                      print(DateFormat.yMMMd().format(
                                          value!)); //تغيير الصيغة من خلال المكتبة intl
                                      dateControler.text =
                                          DateFormat.yMMMd().format(
                                              value); //نعطي القيمة لل ديت كونترولر لنعرضها بالخقل
                                    }); //اضع التاريخ بايدي
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                    elevation: 15.0,)
                      .closed
                      .then((
                      value) { //لنجعل الحقول تتسكر عند الضغط على الور يدون ادخال و لنتفادا الخطاء غند التسطير اليدوي من عند closed
// منذلو بايدنا
                    cubit.changeBottomSheetState(
                        isShow: false,
                        icon: Icons.edit);//هون نستدعب الدالة
                    // setState(() {
                    //   fabIcon=Icons.edit;
                    // });
                  });

                  cubit.changeBottomSheetState(
                      isShow: true,
                      icon: Icons.add);//
                };
              },
              //listen on fabIcon from Cubit becase it is inside it
              child: Icon(cubit.fabIcon,),),
            bottomNavigationBar: BottomNavigationBar( //الشريط التحت
              type: BottomNavigationBarType.fixed,
              //shift if you clicked on bottom icon will be beger  than normal situations or fixed that is true
              //backgroundColor: ,
              //elevation: ,
              currentIndex: cubit.currentIndex,
              //بعلم علئ العنصر متل   bloc active
              onTap: (index) {
                cubit.changeIndex(index); //bloc
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: 'Tasks',),
                BottomNavigationBarItem(
                  icon: Icon(Icons.check_circle_outline),
                  label: 'Done',),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined),
                  label: 'Archived',),

              ],
            ),
          );
        },

      ),
    );
  }
}





