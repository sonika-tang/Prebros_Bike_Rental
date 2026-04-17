import 'package:bike_rental/models/pass.dart';

class PassDto {
  static const String idKey = 'passId';
  static const String typeKey = 'type';
  static const String priceKey = 'price';
  static const String startDateKey = 'startDate';
  static const String endDateKey = 'endDate';
  static const String isActiveKey = 'isActive';

  static Pass fromJson(String id, Map<String, dynamic> json) {
    assert(json[typeKey] is String);
    assert(json[priceKey] is num);

    return Pass(
      passId: id,
      type: _mapType(json[typeKey] as String),
      price: (json[priceKey] as num).toDouble(),
      startDate: json[startDateKey] != null
          ? DateTime.tryParse(json[startDateKey].toString())
          : null,
      endDate: json[endDateKey] != null
          ? DateTime.tryParse(json[endDateKey].toString())
          : null,
      isActive: json[isActiveKey] ?? false,
    );
  }

  static Map<String, dynamic> toJson(Pass pass) {
    return {
      idKey: pass.passId,
      typeKey: pass.type.name,
      priceKey: pass.price,
      startDateKey: pass.startDate?.toIso8601String(),
      endDateKey: pass.endDate?.toIso8601String(),
      isActiveKey: pass.isActive,
    };
  }

  /// Helper to map string → enum
  static PassType _mapType(String type) {
    switch (type) {
      case 'day':
        return PassType.day;
      case 'weekly':
        return PassType.weekly;
      case 'monthly':
        return PassType.monthly;
      case 'annual':
        return PassType.annual;
      default:
        return PassType.day;
    }
  }
}
