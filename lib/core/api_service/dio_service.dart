// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:developer';

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DioUtil {
  static Dio? instance;
  static bool responseRecieved = false;
  List requests = [];
//method for getting dio instance
  static Dio? getInstance() {
    instance ??= DioUtil().createDioInstance();
    return instance;
  }

  Dio createDioInstance() {
    var dio = Dio();
    // (dio.httpClientAdapter as HttpClientAdapter). = (HttpClient client) {
    //   client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    //   return client;
    // };

    // adding interceptor
    dio.interceptors.clear();
    dio.options = BaseOptions(receiveDataWhenStatusError: true, connectTimeout: const Duration(milliseconds: 60 * 1000), receiveTimeout: const Duration(milliseconds: 30 * 1000));
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      // requests.add(options.path);
      print("request send : ${options.path}");
      print(dio.interceptors.length);
      handler.next(options); //modify your request
    }, onResponse: (response, handler) {
      // ignore: unnecessary_null_comparison
      print("response received : ${response.requestOptions.path}");
      if (response != null) {
        try {
          log(
            // "✅" +
            "\x1B[32mType => ${response.requestOptions.method}\nURL => ${response.requestOptions.path.toString()}\nQuery => ${const JsonEncoder.withIndent('  ').convert(response.requestOptions.queryParameters)}\nRequest Data => ${const JsonEncoder.withIndent('  ').convert(response.requestOptions.data)}\nRESPONSE => ${const JsonEncoder.withIndent('  ').convert(json.decode((response).toString()))} \x1B[0m",
            name: "API_SUCCESS",
          );
        } catch (e) {}

        return handler.next(response);
      } else {
        return;
      }
    }, onError: (DioError e, handler) async {
      try {
        log(
          // "🚫" +
          "\x1B[31mType => ${e.requestOptions.method}\nURL => ${e.requestOptions.path.toString()}\nQuery => ${e.requestOptions.queryParameters}\nRequest Data => ${e.requestOptions.data}\nRESPONSE => ${const JsonEncoder.withIndent('  ').convert(json.decode((e.response).toString()))} \x1B[0m",
          name: "API_ERROR",
        );
      } catch (e) {}

      if (e.type == DioErrorType.connectionTimeout || e.type == DioErrorType.receiveTimeout) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          Get.rawSnackbar(
            message: 'Something went wrong',
            backgroundColor: Colors.black,
            mainButton: TextButton(
              onPressed: () {
                dio.request(
                  e.requestOptions.path,
                  cancelToken: e.requestOptions.cancelToken,
                  data: e.requestOptions.data,
                  onReceiveProgress: e.requestOptions.onReceiveProgress,
                  onSendProgress: e.requestOptions.onSendProgress,
                  queryParameters: e.requestOptions.queryParameters,
                );
              },
              child: const Text(
                'Retry',
              ),
            ),
          );
        });
      }
      if (e.response != null) {
        if (e.response!.statusCode == 403) {
          RequestOptions requestOptions = e.requestOptions;
          final opts = Options(method: requestOptions.method);
          dio.options.headers["Accept"] = "*/*";
          final response = await dio.request(requestOptions.path,
              options: opts, cancelToken: requestOptions.cancelToken, onReceiveProgress: requestOptions.onReceiveProgress, data: requestOptions.data, queryParameters: requestOptions.queryParameters);
          // ignore: unnecessary_null_comparison
          if (response != null) {
            handler.resolve(response);
          } else {
            return;
          }
        } else {
          if (e.response!.statusCode == 444) {}
          if (e.response!.statusCode == 445) {}
          if (e.response!.statusCode == 446) {
            final responseData = jsonDecode(e.response.toString());
            // final SnackBar snackBar = SnackBar(
            //     content: Text(
            //   ,
            //   style: const TextStyle(color: Colors.white),
            // ));
            Get.rawSnackbar(message: responseData["response"]["message"]);
            // snackbarKey.currentState?.showSnackBar(snackBar);
          }
          if (e.response!.statusCode == 401) {
            final responseData = jsonDecode(e.response.toString());
            if (!e.requestOptions.path.contains('tamara')) {
              Get.rawSnackbar(
                message: responseData["response"]["message"],
              );
            }
            handler.next(e);
          }
          if (e.response!.statusCode == 500) {
            // if (!e.requestOptions.path.contains('tamara')) {
            //   Get.rawSnackbar(
            //     message: "500: Something went wrong",
            //     backgroundColor: Colors.red,
            //   );
            // }
            handler.next(e);
          }
          if (e.response!.statusCode == 400) {
            handler.resolve(e.response!);
          }
          handler.resolve(e.response!);
        }
      } else {
        handler.next(e);
      }
    }));
    return dio;
  }
}
