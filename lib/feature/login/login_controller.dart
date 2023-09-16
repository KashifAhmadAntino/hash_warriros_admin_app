import 'package:election_admin_panel/feature/login/login_model.dart';
import 'package:election_admin_panel/feature/login/login_service.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  Rxn<LogIn> credentials = Rxn();
  RxnBool verified = RxnBool();

  RxBool isLoading = false.obs;

  Future<bool?> verify() async {
    bool? isverified = await LoginService.VerifyCredentials(credentials.value!);
    return isverified;
  }
}
