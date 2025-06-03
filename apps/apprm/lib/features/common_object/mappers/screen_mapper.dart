import '../entities/object_item.dart';
import '../foundation/models/screen.dart';

class ScreenToObjectItemMapper {
  static ObjectItem fromModel(Screen item, Map<String, dynamic> json) {
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
    return fromModel(Screen.fromJson(json), json);
  }
}
