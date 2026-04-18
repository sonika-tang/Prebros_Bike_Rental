class Pass {
  final String passId;
  final PassType type;        // day, weekly, monthly, annual
  final double price;
  final DateTime? startDate;  // Nullable for catalog display
  final DateTime? endDate;    // Nullable for catalog display
  final bool isActive;

  const Pass({
    required this.passId,
    required this.type,
    required this.price,
    required this.startDate,
    required this.endDate,
    this.isActive = false,
  });

  // Helper for UI based on PassType
  String get typeName {
    switch (type) {
      case PassType.single:
        return "Single Ticket";
      case PassType.day:
        return "1-Day Pass";
      case PassType.weekly:
        return "Weekly Pass";
      case PassType.monthly:
        return "Monthly Pass";
      case PassType.annual:
        return "Annual Pass";
    }
  }
}

enum PassType { single, day, weekly, monthly, annual }
