import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colors.dart';

ThemeData darkTheme=ThemeData(//dark mode
// scaffoldBackgroundColor:Colors.black26,//HexColor('333739'),
backgroundColor:  HexColor('333739'),
primarySwatch: defaultColor,//يغير الكل
appBarTheme:AppBarTheme(
titleSpacing: 20.0,//لحتا نعمل محاذاة لل title مع ال صورة او الكلام قي ال body
backwardsCompatibility: false,//بتغير الستيتوس بار نحطو false  لكي يتيح لنا التحكم بالستيتس بار
systemOverlayStyle: SystemUiOverlayStyle(//هون منعملن التحكم بالخصائص
statusBarColor:HexColor('333739'),
statusBarIconBrightness: Brightness.light,//.light, //iconn color is light

),
// backgroundColor:Colors.black26,//HexColor('333739'),
backgroundColor:  HexColor('333739'),
elevation: 0,
iconTheme: IconThemeData(//لون الايقونات فوق متل السيرش
color: Colors.white,
),
titleTextStyle:TextStyle(//تعديل عام على كل العناوين
  fontFamily: 'Jannah',

  color: Colors.white,
fontSize: 20.0,
fontWeight: FontWeight.bold,
),
),
bottomNavigationBarTheme: BottomNavigationBarThemeData(//التحكم العام بالشريط السفلي
type: BottomNavigationBarType.fixed,
selectedItemColor: defaultColor,//تغيير الالوان
unselectedItemColor: Colors.grey,
elevation: 20.0,
// backgroundColor: Colors.black26,//
backgroundColor:  HexColor('333739'),
),
textTheme: TextTheme(
bodyText1: TextStyle(
fontSize: 18.0,
fontWeight: FontWeight.w600,
color: Colors.white,
),
  subtitle1: TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    height: 1.3,


  )
),
    fontFamily: 'Jannah',

);
//////
ThemeData lightTheme=ThemeData(//ينطبق على الابلكيشن كلو
  primarySwatch: defaultColor,//يغير الكل
  scaffoldBackgroundColor: Colors.white,
  appBarTheme:AppBarTheme(
    titleSpacing: 20.0,//لحتا نعمل محاذاة لل title مع ال صورة او الكلام قي ال body

    backwardsCompatibility: true,//بتغير الستيتوس بار نحطو false  لكي يتيح لنا التحكم بالستيتس بار
    systemOverlayStyle: SystemUiOverlayStyle(//هون منعملن التحكم بالخصائص
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,//.light, //iconn color is light

    ),
    backgroundColor: Colors.white,
    elevation: 0,
    iconTheme: IconThemeData(//لون الايقونات فوق متل السيرش
      color: Colors.black,
    ),
    titleTextStyle:TextStyle(//تعديل عام على كل العناوين
      fontFamily: 'Jannah',

      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(//التحكم العام بالشريط السفلي
    // type: BottomNavigationBarType.fixed,
    //   selectedItemColor: Colors.deepOrange,//تغيير الالوان
    // elevation: 20.0,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,//تغيير الالوان
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    backgroundColor: Colors.white,
  ),
  // primarySwatch: Colors.deepOrange,//كل حاجة في الابلكيشن
  // floatingActionButtonTheme: FloatingActionButtonThemeData(
  //   backgroundColor: Colors.deepOrange,
  // ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
      subtitle1: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        color: Colors.black,
        height: 1.3,

      )
  ),
  fontFamily: 'Jannah',


);