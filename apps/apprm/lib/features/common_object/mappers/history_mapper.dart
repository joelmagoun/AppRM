import 'package:intl/intl.dart';

import '../entities/object_item.dart';

class HistoryToObjectItemMapper {
  static ObjectItem fromJson(Map<String, dynamic> json) {
    final createdDateStr = json['created_at'];
    final appName = (json['app_name'] ?? '').toString();
    final username = (json['username'] ?? '').toString();

    String title = '';
    if (createdDateStr != null) {
      final parsedDate = DateTime.tryParse(createdDateStr.toString());
      final formattedDate =
          parsedDate != null ? DateFormat.yMd().add_Hm().format(parsedDate) : createdDateStr.toString();
      title = formattedDate;
    }
    if (appName.isNotEmpty) {
      title = title.isNotEmpty ? '$title - $appName' : appName;
    }
    if (username.isNotEmpty) {
      title = title.isNotEmpty ? '$title - $username' : username;
    }

    return ObjectItem(
      id: json['id'] as String,
      title: title,
      subTitle: json['message']?.toString() ?? '',
      sortFields: const [
        (key: 'created_at', label: 'Date'),
      ],
      raw: json,
      rawJson: json,
    );
  }
}
