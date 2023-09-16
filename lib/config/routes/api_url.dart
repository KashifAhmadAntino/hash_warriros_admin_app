String baseUrl = "https://3f4a-49-249-44-114.ngrok-free.app";

class ApiUrl {
  static String getGeneralResult = "$baseUrl/admin/result";
  static String verifyLogin = "$baseUrl/strict-admin/login";
  static String changeElectionStatus = "$baseUrl/strict-admin/enable-disable";
  static String getElectionStatus = "$baseUrl/strict-admin/elections";
}
