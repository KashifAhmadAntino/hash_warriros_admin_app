import 'package:election_admin_panel/app_colors.dart';
import 'package:election_admin_panel/config/routes/app_routes.dart';
import 'package:election_admin_panel/feature/dashboard/dashboard.dart';
import 'package:election_admin_panel/image_path.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Admin Sign in"),
      ),
      body: SingleChildScrollView(
        child: Column(
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
            const SizedBox(
              width: 350,
              height: 100,
              // padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))), labelText: 'Email', hintText: 'Enter valid email id as abc@gmail.com'),
              ),
            ),
            const SizedBox(
              width: 350,
              height: 100,
              // padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))), labelText: 'Password', hintText: 'Enter secure password'),
              ),
            ),
            SizedBox(
              height: 50,
              width: 250,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.dashboard);
                },
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.grey151),
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                //TODO FORGOT PASSWORD SCREEN GOES HERE
              },
              child: const Text(
                'Forgot Password',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () => Navigator.popAndPushNamed(context, AppRoutes.signUp),
              child: const Text('New User? Create Account'),
            )
          ],
        ),
      ),
    );
  }
}
