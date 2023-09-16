import 'package:election_admin_panel/app_colors.dart';
import 'package:election_admin_panel/config/routes/app_routes.dart';
import 'package:election_admin_panel/feature/login/login_controller.dart';
import 'package:election_admin_panel/image_path.dart';
import 'package:election_admin_panel/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Get.put(LoginController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.grey158,
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "Election 2024",
            style: TextStyle(
              fontSize: 50,
              color: AppColors.grey151,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: const [],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
          alignment: Alignment.centerLeft,
          image: AssetImage(ImagePath.bgImage),
        )),
        child: Align(
          alignment: Alignment.centerRight,
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: AppColors.grey151,
            margin: EdgeInsets.only(right: 250.0 * SizeConfig.widthMultiplier!),
            elevation: 40,
            child: SizedBox(
              height: 300 * SizeConfig.heightMultiplier!,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(onPressed: () => {Navigator.of(context).pushNamed(AppRoutes.login)}, child: const Text("Admin Sign in")),
                    ElevatedButton(onPressed: () => {Navigator.of(context).pushNamed(AppRoutes.signUp)}, child: const Text("Admin Sign up")),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
