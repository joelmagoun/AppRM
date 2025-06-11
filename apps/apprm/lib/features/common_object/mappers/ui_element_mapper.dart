import '../entities/object_item.dart';
import '../foundation/models/ui_element.dart';

class UiElementToObjectItemMapper {
  static ObjectItem fromModel(UiElement item, Map<String, dynamic> json) {
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
    return fromModel(UiElement.fromJson(json), json);
  }
}
