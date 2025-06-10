import 'package:intl/intl.dart';

import '../entities/object_item.dart';

class WorkLogToObjectItemMapper {
  static ObjectItem fromJson(Map<String, dynamic> json) {
    final amount = (json['amount'] ?? '').toString();
    final username = (json['username'] ?? json['user_id'] ?? '').toString();
    final createdDateStr = json['created_at'] ?? json['created_date'];
    final appName = (json['app_name'] ?? json['app'] ?? '').toString();

    String subtitle = '';
    if (createdDateStr != null) {
      final parsedDate = DateTime.tryParse(createdDateStr.toString());
      final formattedDate = parsedDate != null
          ? DateFormat.yMd().format(parsedDate)
          : createdDateStr.toString();
      subtitle = formattedDate;
    }
    if (appName.isNotEmpty) {
      subtitle = subtitle.isNotEmpty ? '$subtitle - $appName' : appName;
    }

    return ObjectItem(
      id: json['id'] as String,
      title: '$amount - $username',
      subTitle: subtitle,
      sortFields: const [
        (key: 'amount', label: 'Amount'),
      ],
      raw: json,
      rawJson: json,
    );
  }
}
