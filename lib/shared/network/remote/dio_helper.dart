import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';


class DioHelper{

  static Dio? dio;


  static init(){
   dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type' : 'application/json'
        }
      )
    );
   (dio?.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
       (HttpClient client) {
     client.badCertificateCallback =
         (X509Certificate cert, String host, int port) => true;
     return client;
   };

  }

  static Future<Response> getData({
    required String url,
    required Map<String, dynamic> query
}) async {
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> postData(
  {
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic>? data,
    String lang = 'ar',
    String? token
}) async {
    dio?.options.headers = {
      'lang': lang,
      'token': token
    };
    return await dio!.post(url, queryParameters: query, data: data);
  }
}