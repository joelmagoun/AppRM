import '../entities/object_item.dart';
import '../foundation/models/screen_function.dart';

class ScreenFunctionToObjectItemMapper {
  static ObjectItem fromModel(ScreenFunction item, Map<String, dynamic> json) {
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
    return fromModel(ScreenFunction.fromJson(json), json);
  }
}
