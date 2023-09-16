class ElectionResult {
  String candidateName;
  String district;
  String city;
  String state;
  int totalVotes;
  String finalStatus;
  String party;
  ElectionResult({
    required this.candidateName,
    required this.district,
    required this.city,
    required this.state,
    required this.totalVotes,
    required this.finalStatus,
    required this.party,
  });

  factory ElectionResult.fromJson(Map<String, dynamic> json) => ElectionResult(
        candidateName: json["candidateName"],
        district: json["district"],
        city: json["city"],
        state: json["state"],
        totalVotes: json["totalVotes"],
        finalStatus: json["finalStatus"],
        party: json["party"],
      );

  Map<String, dynamic> toJson() => {
        "candidateName": candidateName,
        "district": district,
        "city": city,
        "state": state,
        "totalVotes": totalVotes,
        "finalStatus": finalStatus,
        "party": party,
      };
}
