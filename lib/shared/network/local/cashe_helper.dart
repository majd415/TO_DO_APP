import 'package:shared_preferences/shared_preferences.dart';

class CasheHelper{
//لتخوين قيمة ال مود اذا كان دارك او لايت
  static SharedPreferences? sharedPreferences;
  static init()async{//نستدعيا في المين ذ
    sharedPreferences= await SharedPreferences.getInstance();

  }
  //ازاي حودي وححيب
  //set
  //اثناء الدوسة بالميوبيت بودي
static Future<bool?> putBoolean({
  required String key,
  required bool value,
})async{

 return await   sharedPreferences?.setBool(key, value);
}
//get
//   static bool? getBoolean({
//     required String key,
//
//   }){
//
//     return    sharedPreferences?.getBool(key);
//   }

  //static عشان اندهها برة
  static dynamic getData({ //بجيب اي نوع من الداتا نستدغية بالمين
    required String key,

  }){

    return    sharedPreferences?.get(key);
  }


  static Future<bool?> saveData({//لكي يتم استخدامها لتخزين جميع انواع البيانات
    required String key,
    required dynamic value,

  })async{
    if(value is String )return await sharedPreferences?.setString(key, value);
    if(value is int )return await sharedPreferences?.setInt(key, value);
    if(value is bool )return await sharedPreferences?.setBool(key, value);

    return await sharedPreferences?.setDouble(key, value);
  }

//clear sharedpref like sign out with remove token
  static Future<bool?>? removeData({required String key,})async{
    return await sharedPreferences?.remove(key);
}
static String getToken(){
    return   CasheHelper.getData(key:'token');

    }


}