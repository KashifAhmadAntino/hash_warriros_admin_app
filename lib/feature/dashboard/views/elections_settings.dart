import 'package:election_admin_panel/app_colors.dart';
import 'package:election_admin_panel/feature/login/login_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ElectionManagement extends StatefulWidget {
  const ElectionManagement({super.key});

  @override
  State<ElectionManagement> createState() => _ElectionManagementState();
}

class _ElectionManagementState extends State<ElectionManagement> {
  @override
  void initState() {
    getElectionStatus();
    super.initState();
  }

  void getElectionStatus() async {
    await LoginService.getElectionStatus();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return LoginService.isElectionEnabled != null
        ? Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.all(100),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            bool? electionClosed =
                                await LoginService.changeElectionStatus(
                                    !(LoginService.isElectionEnabled ?? false));
                            if (electionClosed == true) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          LoginService.isElectionEnabled == true
                                              ? Text('Election Closed')
                                              : Text('Election Open Again')));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Something went wrong!')));
                            }
                            setState(() {});
                          },
                          child: SizedBox(
                            width: 200,
                            height: 400,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              color: LoginService.isElectionEnabled == true
                                  ? AppColors.red35
                                  : Colors.green,
                              elevation: 10,
                              child: Center(
                                child: Text(
                                  LoginService.isElectionEnabled == true
                                      ? "Stop Election"
                                      : "Start Election",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
