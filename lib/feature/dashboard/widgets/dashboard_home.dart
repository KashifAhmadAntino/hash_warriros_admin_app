import 'package:election_admin_panel/app_colors.dart';
import 'package:flutter/material.dart';

class ElectionResult extends StatelessWidget {
  const ElectionResult({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 500,
          height: 50,
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.red35),
          padding: const EdgeInsets.all(10),
          child: const Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.brightness_1,
                  size: 20,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Live Elections Result",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ElectionStats extends StatelessWidget {
  const ElectionStats({
    super.key,
    required this.voters,
    required this.candidates,
    required this.totalVotes,
  });
  final int voters;
  final int candidates;
  final int totalVotes;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            const Row(
              children: [
                Icon(Icons.people),
                Text("Voters"),
              ],
            ),
            Text(
              voters.toString(),
              style: const TextStyle(color: AppColors.grey151),
            )
          ],
        ),
        const SizedBox(
          height: 100,
          child: VerticalDivider(
            color: AppColors.grey158,
          ),
        ),
        Column(
          children: [
            const Row(
              children: [
                Icon(Icons.person),
                Text("Candidates"),
              ],
            ),
            Text(
              candidates.toString(),
              style: const TextStyle(color: AppColors.grey151),
            )
          ],
        ),
        const SizedBox(
          height: 100,
          child: VerticalDivider(
            color: AppColors.grey158,
          ),
        ),
        Column(
          children: [
            const Row(
              children: [
                Icon(Icons.bar_chart_sharp),
                Text("Total Votes"),
              ],
            ),
            Text(
              totalVotes.toString(),
              style: const TextStyle(color: AppColors.grey151),
            )
          ],
        ),
      ],
    );
  }
}
