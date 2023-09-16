import 'dart:convert';

import 'package:election_admin_panel/config/routes/api_url.dart';
import 'package:election_admin_panel/core/api_service/dio_service.dart';
import 'package:election_admin_panel/feature/dashboard/models/result_data.dart';
import 'package:election_admin_panel/feature/dashboard/views/dashboard_home.dart';

class ElectionResultService {
  static var dio = DioUtil.getInstance();

  static Future<void> getElectionResult() async {
    dio!.options.headers["language"] = "1";
    // dio!.options.headers['Authorization'] = await LogInService.getAccessToken();
    // var response = await dio!.get(ApiUrl.getPlanByTrainerId);
    // return planModelFromJson(response.toString());
  }

  static Future<List<ResultData>> getGeneralResult() async {
    try {} catch (e) {}
    var response = await dio!.get(ApiUrl.getGeneralResult);
    var responseData = json.decode(response.toString());

    List<ResultData> resultData = [];
    try {
      if (responseData["data"] != null) {
        for (var i = 0; i < responseData["data"].length; i++) {
          print(responseData["data"][i]);
          resultData.add(ResultData.fromJson(responseData["data"][i]));
        }
      }
    } catch (e) {
      print(e);
    }
    return resultData;
  }
}
