import 'package:election_admin_panel/config/routes/api_url.dart';
import 'package:election_admin_panel/feature/dashboard/views/dashboard_home.dart';
import 'package:election_admin_panel/feature/dashboard/views/elections_settings.dart';
import 'package:election_admin_panel/feature/dashboard/views/voters_info.dart';
import 'package:election_admin_panel/image_path.dart';
import 'package:flutter/material.dart';
import 'package:side_navigation/side_navigation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  List<Widget> views = const [
    DashBoardHome(),
    VotersInfo(),
    ElectionManagement(),
  ];
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    // socket.onDisconnect((_) => print('disconnect'));
    // socket.on('fromServer', (_) => print(_));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        // decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.contain, image: AssetImage(ImagePath.bgImage))),
        child: Row(
          children: [
            /// Pretty similar to the BottomNavigationBar!
            SideNavigationBar(
              initiallyExpanded: false,
              selectedIndex: selectedIndex,
              header: SideNavigationBarHeader(
                image: Image.asset(
                  ImagePath.bgImage,
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                ),
                title: const Text("DashBoard"),
                subtitle: const Text("Elections 2024"),
              ),
              items: const [
                SideNavigationBarItem(
                  icon: Icons.dashboard,
                  label: 'Dashboard',
                ),
                SideNavigationBarItem(
                  icon: Icons.person,
                  label: 'Voters Info',
                ),
                SideNavigationBarItem(
                  icon: Icons.settings,
                  label: 'Election Management',
                ),
              ],
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
            ),

            /// Make it take the rest of the available width
            Expanded(
              child: views.elementAt(selectedIndex),
            )
          ],
        ),
      ),
    );
  }
}
