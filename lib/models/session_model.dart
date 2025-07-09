class SessionModel {
  final int focusCount;

  SessionModel({required this.focusCount});

  Map<String, dynamic> toJson() => {'focusCount': focusCount};

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(focusCount: json['focusCount'] ?? 0);
  }
}
