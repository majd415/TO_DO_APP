


import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



import '../cubit/cubit.dart';
import '../cubit/states.dart';
import '../styles/colors.dart';

//نحدد الشغلات التي يمكن ان تتغير
Widget defaultButton({
  double width=double.infinity,//default value
  Color background=Colors.blue,
  bool isUpperCase=true,// for case smale or apper
  required void Function() function ,//الدالة الذي يعمل بها متغير
  required String text ,
  double radius=0.0,

})=> Container(
  width: width,
  height: 40.0,
  child: MaterialButton(
    onPressed:function ,//func
    child: Text(isUpperCase ?  text.toUpperCase() : text,// هنا نستخدمعها
      style: TextStyle(
        color: Colors.white,
      ),   ),
  ),
  decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(radius),

    color: background,
  ),
);

////////////////////////////////////
Widget defaultFormfield({//حقول الادخال
  required TextEditingController controller,
  required TextInputType type,
required void Function(String) onChanged ,
  required void Function(String)  onSubmit,
  required String? Function(String?) validate,
  required String label ,
  required IconData prefix ,
   IconData?  suffix,
  bool isPassword=false,
  Function()? suffixPressed,//for press and show password
Function()? onTap,//مثلا لحتا نعمل شي معيت لما نضفط علية مثلا لما يلي بدنا نحط التاريخ مشان ما نحطو بايدنا منخلية يطلع                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            ونحنا منختار
bool isClickable=true,//مشان ما نخلي كل ما نضغط مثلا على التاريخ يطلع اول كيبوورد يلي ما منستخدما
})=>     TextFormField(//  مربع يوسر
  controller: controller,
  keyboardType:type ,//تستخدم لتعببن لوحة المفاتيح بجبث تتوافق مع نوع الادخال
  onChanged:onChanged,
  onFieldSubmitted: onSubmit,

  decoration: InputDecoration(
    // hintText: '',//يكتب بشكل نوضيحي على الادخال ويخنفي عمدما نكتب
    labelText: label,//نفس الشي بس لا بخنفي يطلع فوق
    prefixIcon: Icon(//تعطي ايقونة اول ال انبوت
        prefix
    ),
    suffixIcon:suffix!= null ? IconButton(icon: Icon(suffix),onPressed:suffixPressed ,): null,// تعطي ايقونة اخر ال انبوت
    border: OutlineInputBorder(),//لاظهار الحواف البوردر
  ),
  validator:validate  ,
  obscureText: isPassword,//تعطي النجم لل باسسورد اثناء الكتابة
  onTap: onTap,
  enabled:isClickable,
);
// ( value){//التحقق من الداتا
// if(value == null || value.isEmpty){
// return 'email adress must not be empty ';
// }
// return null;
// }
///////////////////////////////////
 Widget  defaultAppBar({
 required BuildContext context,
  String? title,
  dynamic actions,
})=>AppBar(
  leading: IconButton(
    icon: Icon(Icons.add),
    onPressed: (){
      Navigator.pop(context);
    },
  ),
  title: Text(
       '${title}',
    style: TextStyle(color: Colors.black),
  ),
  titleSpacing: 5.0,
  actions: actions ,
);
Widget buildTaskItem(Map model,context  )=> Dismissible(//تعمل سواب يمين و يسار
  key:Key(model['id'].toString()) ,//مفتاح غريب للودحت فهو رح يتغير بنائا علئ كل ايتم
  child:   Padding( //بما انة كانت بالاصل ليست اوف ماب نوعا اي البيانات يلي بدا تعرضا

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        CircleAvatar(

          radius: 40,

          child: Text("${model['time']}"),

        ),

        SizedBox(

          width: 20.0,

        ),

        Expanded(

          child: Column(

            mainAxisSize: MainAxisSize.min,

            crossAxisAlignment: CrossAxisAlignment.start,//لتكون البداية نقسا

            children: [

              Text("${model['title']}",

                style: TextStyle(

                  fontWeight: FontWeight.bold,

                  fontSize: 18.0,

                ),),

              Text("${model['date']}",

                style: TextStyle(

                  color: Colors.grey,

                ),),



            ],

          ),

        ),

        SizedBox(

          width: 20.0,

        ),

        IconButton(

            onPressed: (){

            AppCubit.get(context).updateData(status: 'done', id: model['id']);//هوة محتاج conte xt مع الايتم منبعنو للكونتيكست كبارا متر مع العنصر

            },

            icon:Icon(

              Icons.check_box,

              color: Colors.green,

            )),

        IconButton(

            onPressed: (){

              AppCubit.get(context).updateData(status: 'archive', id: model['id']);//هوة محتاج conte xt مع الايتم منبعنو للكونتيكست كبارا متر مع العنصر



            },

            icon:Icon(

              Icons.archive,

              color: Colors.black54,

            )),



      ],

    ),

  ),
  onDismissed: (direction){
  AppCubit.get(context).deleteData(id: model['id']);//نحزف بالسواب يكيم او يسار
  },//بيديني الدايركشن يلي هوة عمل ديسمسبل فية يعني يمين او شمال
);

Widget tasksbuilder({
  required List<Map> tasks,
})=> ConditionalBuilder(//تذت كانت الداتا بيس فاضية
  condition:tasks.length >0,
  builder: (context)=>BlocConsumer<AppCubit,AppStates>(
    listener: (context,state){},
    builder: (context,state){

      //بلسن غليعا
      return ListView.separated(
        itemBuilder: (context,index)=>buildTaskItem(tasks[index],context,),//الاندكس رح يلق عالكل منمرق ال tasks يلي موجودة في constants
        separatorBuilder: (context,index)=> myDivider(),//القاصل يلي حطيناة بودجت لحالو
        itemCount: tasks.length,);
    },
  ),
  fallback:(context)=> Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.ice_skating,
          size: 100.0,
          color: Colors.grey,
        ),
        Text('No Tsks Yet Please enter some tasks ',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),),
      ],
    ),
  ) ,
);
//الفاصل
Widget myDivider()=>Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

/////news item



///////item bulder for news app
//isSearch=false عشان عرفو انو انا جايي نت السيرش مشان نستعني غن الشريط يلي بلف منبعتو اثناء السيرش فقط


//navegator method
//تاخد context و widget  رخ تروح الها
void navigateTo(context,widget)=>Navigator.push(//تنتقل وترجع بالترتيب
    context,
    MaterialPageRoute(
        builder: (context)=>widget));
void navigateAndFinish(context,widget)=>Navigator.pushAndRemoveUntil(//تنتقل وترجع بالترتيب
    context,
    MaterialPageRoute(
        builder: (context)=>widget),
    (Route<dynamic>route)=>false);
//routs يلي فاتت عاوذها نضل موجوده true او عايذ تلغي false
Widget defaultTextButton({
  required Function() function
,
required String text})=>    TextButton(
    onPressed: function,
    child: Text(text.toUpperCase()));


/////alert for login


//اذا كان عنا شغلة فيا اكتر من حالة مثلا هنا لون الخلفية حسب ال error
enum ToastStates{ SUCCESS,ERROR,WARNING}
Color? chooseToastColor(ToastStates state){
  Color color;
  switch(state){
    case ToastStates.SUCCESS:
      color= Colors.green;
      break;
    case ToastStates.ERROR:
      color= Colors.redAccent;
      break;
    case ToastStates.WARNING:
      color= Colors.amber;
      break;



  }
  return color;

}
//fav and search item
// Widget? defaultAppBar({
//   required BuildContext? context,
//   String? title,
//    List<Widget>?  actions,
// })=>AppBar(
//   leading: IconButton(
//     onPressed: (){
//       Navigator.pop(context!);
//     },
//     icon: Icon(
//       IconBroken.Arrow___Left_2,
//     ),
//   ),
//   title: Text('$title'??''),
//   actions: actions ?? [],
// );