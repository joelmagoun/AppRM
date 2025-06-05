import '../entities/object_item.dart';
import '../foundation/models/application.dart';

class ApplicationToObjectItemMapper {
  static ObjectItem fromModel(Application item, Map<String, dynamic> json) {
    return ObjectItem(
      id: item.id,
      title: item.name ?? '',
      subTitle: item.description ?? '',
      sortFields: [
        (key: 'name', label: 'Name'),
      ],
      raw: item,
      rawJson: json,
    );
  }

  static ObjectItem fromJson(Map<String, dynamic> json) {
    return fromModel(Application.fromJson(json), json);
  }
}
