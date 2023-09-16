import 'package:election_admin_panel/app_colors.dart';
import 'package:flutter/material.dart';

class ElectionManagement extends StatefulWidget {
  const ElectionManagement({super.key});

  @override
  State<ElectionManagement> createState() => _ElectionManagementState();
}

class _ElectionManagementState extends State<ElectionManagement> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(100),
      child: const Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 200,
                    height: 400,
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                      color: AppColors.red35,
                      elevation: 10,
                      child: Center(
                        child: Text(
                          "Stop Election",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    height: 400,
                    child: Card(
                      elevation: 10,
                      color: AppColors.grey151,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Center(child: Text("Raise an issue!")),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
