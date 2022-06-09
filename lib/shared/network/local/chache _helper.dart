import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{

  static SharedPreferences? prefs;

  static init() async{
    prefs = await SharedPreferences.getInstance();
  }

static Future setBool({
  required String key,
  required bool value
})async{
   return await prefs?.setBool(key, value);
}

  static getBool({
    required String key,
  }){
    return prefs?.getBool(key);
  }
}