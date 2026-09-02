class TableSession {
  final String sessionId;
  final String hotelId;
  final String tableId;
  final DateTime createdAt;

  const TableSession({
    required this.sessionId,
    required this.hotelId,
    required this.tableId,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
    'sessionId': sessionId,
    'hotelId': hotelId,
    'tableId': tableId,
    'createdAt': createdAt.toIso8601String(),
  };

  factory TableSession.fromJson(Map<String, dynamic> json) => TableSession(
    sessionId: json['sessionId'] as String,
    hotelId: json['hotelId'] as String,
    tableId: json['tableId'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String),
  );
}