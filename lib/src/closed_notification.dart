class ClosedNotification {
  final String id;
  final DateTime? lastDisplayAt;
  final DateTime? nextDisplayAt;

  const ClosedNotification({required this.id, this.lastDisplayAt, this.nextDisplayAt});

  factory ClosedNotification.foreverNoDisplay(String id) {
    return ClosedNotification(id: id);
  }

  factory ClosedNotification.interval(String id, DateTime lastDisplayAt, Duration interval) {
    final nextDisplayAt = lastDisplayAt.add(interval);
    return ClosedNotification(id: id, lastDisplayAt: lastDisplayAt, nextDisplayAt: nextDisplayAt);
  }

  factory ClosedNotification.fromJson(Map<String, String?> json) {
    if (json['last_display_at'] == null) return ClosedNotification(id: json['id']!);

    return ClosedNotification(
      id: json['id']!,
      lastDisplayAt: DateTime.parse(json['last_display_at']!),
      nextDisplayAt: DateTime.parse(json['next_display_at']!),
    );
  }

  Map<String, String?> toJson() {
    return {
      'id': id,
      'last_display_at': lastDisplayAt?.toString(),
      'next_display_at': nextDisplayAt?.toString(),
    };
  }

  bool shouldNotify(DateTime current) {
    if (nextDisplayAt == null) return false;

    return current.isAfter(nextDisplayAt!);
  }

  @override
  bool operator ==(Object other) =>
      other is ClosedNotification &&
      this.id == other.id &&
      this.lastDisplayAt == other.lastDisplayAt &&
      this.nextDisplayAt == other.nextDisplayAt;

  @override
  int get hashCode => super.hashCode;
}
