class ResultData {
  String party;
  int votes;
  String? imageUrl;

  ResultData({required this.party, required this.votes, this.imageUrl});

  factory ResultData.fromJson(Map<String, dynamic> json) => ResultData(
        party: json["name"],
        votes: json["partyTotal"] ?? 0,
        imageUrl: json["symbol"],
      );

  // Map<String, dynamic> toJson() => {
  //       "party": party,
  //       "votes": votes,
  //     };
}
