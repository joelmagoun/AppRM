import '../entities/object_item.dart';

class WorkLogToObjectItemMapper {
  static ObjectItem fromJson(Map<String, dynamic> json) {
    return ObjectItem(
      id: json['id'] as String,
      title: (json['amount'] ?? '').toString(),
      subTitle: json['description'] ?? '',
      sortFields: [
        (key: 'amount', label: 'Amount'),
      ],
      raw: json,
      rawJson: json,
    );
  }
}
