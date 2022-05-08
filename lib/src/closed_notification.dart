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

  Map<String, String?> toJson() {
    return {
      'id': id,
      'last_display_at': lastDisplayAt?.toString(),
      'next_display_at': nextDisplayAt?.toString(),
    };
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
