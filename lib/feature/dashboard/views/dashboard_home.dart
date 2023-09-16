import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:election_admin_panel/app_colors.dart';
import 'package:election_admin_panel/config/routes/api_url.dart';
import 'package:election_admin_panel/feature/dashboard/models/result_data.dart';
import 'package:election_admin_panel/feature/dashboard/service/election_result_service.dart';
import 'package:election_admin_panel/feature/dashboard/widgets/dashboard_home.dart';
import 'package:election_admin_panel/image_path.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class DashBoardHome extends StatelessWidget {
  const DashBoardHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  ImagePath.bgImage,
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                ),
                const Text(
                  "GENERAL ELECTIONS-(2024) PORTAL",
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const GeneralResult(),
          ],
        ),
      ),
    );
  }
}

class GeneralResult extends StatefulWidget {
  const GeneralResult({super.key});

  @override
  State<GeneralResult> createState() => _GeneralResultState();
}

class _GeneralResultState extends State<GeneralResult> {
  Timer? timer;
  late IO.Socket socket;
  ValueNotifier<Map> data = ValueNotifier<Map>({});
  int totalVoters = 0;
  int remainingVoters = 0;
  int votedUsers = 0;
  @override
  void initState() {
    super.initState();
    socket = IO.io(baseUrl, <String, dynamic>{
      'Connection': 'upgrade',
      'Upgrade': 'websocket',
      "transports": ["websocket"],
      "autoConnect": true,
    });
    socket.disconnect();
    socket.connect();
    socket.onConnect((_) {
      print('connect');
      // socket.emit('msg', 'test');
    });
    socket.emit('GET_DASHBOARD');
    socket.on('GET_DASHBOARD', (data) {
      // print(data);
      getGeneralResultData(data);
    });
  }

  @override
  void dispose() {
    super.dispose();
    socket.dispose();
    timer?.cancel();
  }

  bool _isloading = true;
  List<ResultData> resultData = [];
  Color color = const Color.fromARGB(255, 240, 133, 61);

  void getGeneralResultData(Map<String, dynamic> data) async {
    var responseData = jsonDecode(jsonEncode(data["data"]));

    totalVoters = responseData['totalUser'] ?? 0;
    remainingVoters = responseData['remainingUser'] ?? 0;
    votedUsers = responseData['votedUser'] ?? 0;

    try {
      for (var i = 0; i < responseData["data"].length; i++) {
        resultData.add((ResultData.fromJson(responseData["data"][i])));
      }
    } catch (e) {
      print(e);
    }
    if (resultData.isNotEmpty) {
      setState(() {
        _isloading = false;
        // resultData = resultData;
        color = colors[Random().nextInt(colors.length)];
      });
    }
  }

  List<Color> colors = [
    const Color.fromARGB(255, 240, 133, 61),
    const Color.fromARGB(255, 150, 0, 0),
    const Color.fromARGB(255, 4, 119, 185),
    const Color.fromARGB(255, 90, 37, 1),
    const Color.fromARGB(255, 49, 16, 126),
    const Color.fromARGB(255, 100, 231, 13),
    const Color.fromARGB(255, 145, 19, 92),
  ];

  // final List<ResultData> resultData = [
  //   ResultData(party: "BJP", votes: 35),
  //   ResultData(party: "INC", votes: 50),
  //   ResultData(party: "AAP", votes: 100),
  //   ResultData(party: "Others", votes: 10),
  //   ResultData(party: "NOTA", votes: 40),
  // ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        ElectionStats(
            votedUsers: votedUsers,
            remainingVoters: remainingVoters,
            totalVoters: totalVoters),
        const Divider(),
        const ElectionResult(),
        _isloading
            ? const Center(child: CircularProgressIndicator())
            : SizedBox(
                child: SfCartesianChart(
                  isTransposed: true,
                  series: <ChartSeries>[
                    BarSeries<dynamic, String>(
                      color: color,
                      animationDelay: 10,
                      isVisible: true,
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                      dataSource: resultData,
                      // Renders the track
                      isTrackVisible: true,
                      xValueMapper: (datum, index) {
                        return datum.party.toUpperCase();
                      },
                      // xValueMapper: (ResultData data, _) => ,
                      yValueMapper: (data, _) => data.votes,
                    ),
                  ],
                  backgroundColor: const Color.fromARGB(255, 255, 226, 139),
                  plotAreaBackgroundColor:
                      const Color.fromARGB(255, 255, 248, 187),
                  plotAreaBorderColor: Colors.cyan,
                  primaryYAxis: NumericAxis(
                      title: AxisTitle(text: "Number of votes ---->"),
                      isVisible: true),
                  primaryXAxis: CategoryAxis(
                    title: AxisTitle(text: "<------- Parties ------->"),
                    axisLine: const AxisLine(),
                  ),
                  title: ChartTitle(text: "ELection updates Live 2024"),
                ),
              ),
      ],
    );
  }
}
