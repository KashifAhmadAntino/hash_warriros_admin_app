import 'package:election_admin_panel/app_colors.dart';
import 'package:election_admin_panel/config/routes/app_routes.dart';
import 'package:election_admin_panel/feature/login/login_controller.dart';
import 'package:election_admin_panel/feature/login/login_model.dart';
import 'package:election_admin_panel/image_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final controller = Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Admin Sign in"),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                  child: SizedBox(
                      width: 200,
                      height: 150,
                      /*decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(50.0)),*/
                      child: Image.asset(ImagePath.bgImage)),
                ),
              ),
              controller.credentials.value != null
                  ? const Text(
                      "",
                      style: TextStyle(color: AppColors.red35),
                    )
                  : const SizedBox(),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    SizedBox(
                      width: 350,
                      height: 100,
                      // padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        controller: _controller1,
                        validator: (value) {
                          if (value == null || value == "") {
                            return "Wrong info";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            labelText: 'Email',
                            hintText: 'Enter valid email id as abc@gmail.com'),
                      ),
                    ),
                    SizedBox(
                      width: 350,
                      height: 100,

                      // padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
                      child: TextFormField(
                        obscureText: true,
                        controller: _controller2,
                        validator: (value) {
                          if (value == null || value == "") {
                            return "Wrong info";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            labelText: 'Password',
                            hintText: 'Enter secure password'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                width: 250,
                child: ElevatedButton(
                  onPressed: () async {
                    controller.credentials.value = LogIn(
                        email: _controller1.text, password: _controller2.text);
                    bool? verify = await controller.verify();
                    print(verify);
                    if (verify == true) {
                      Navigator.of(context).pushNamed(AppRoutes.dashboard);
                    }
                    if (_formkey.currentState!.validate()) {}
                    // if (_formkey.currentState!.validate()) {
                    //   Navigator.of(context).pushNamed(AppRoutes.dashboard);
                    // } else {
                    //   print("Not validate");
                    // }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.grey151,
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              // TextButton(
              //   onPressed: () {
              //   },
              //   child: const Text(
              //     'Forgot Password',
              //     style: TextStyle(color: Colors.blue, fontSize: 15),
              //   ),
              // ),
              const SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () =>
                    Navigator.popAndPushNamed(context, AppRoutes.signUp),
                child: const Text('New User? Create Account'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
