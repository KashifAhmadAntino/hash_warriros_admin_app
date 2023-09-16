import 'dart:convert';

import 'package:election_admin_panel/config/routes/api_url.dart';
import 'package:election_admin_panel/core/api_service/dio_service.dart';
import 'package:election_admin_panel/feature/dashboard/models/result_data.dart';
import 'package:election_admin_panel/feature/login/login_controller.dart';
import 'package:election_admin_panel/feature/login/login_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginService {
  static var dio = DioUtil.getInstance();

  static Future<bool?> VerifyCredentials(LogIn logIn) async {
    final controller = Get.find<LoginController>();
    dio!.options.headers["Content-Type"] = "application/json";
    controller.isLoading.value = true;
    var response = await dio!.post(ApiUrl.verifyLogin, data: logIn.toJson());
    var responseData = json.decode(response.toString());
    controller.isLoading.value = false;

    print(responseData);

    try {
      if (responseData["message"] == "success") {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
