import '../entities/object_item.dart';
import '../foundation/models/data_field.dart';

class DataFieldToObjectItemMapper {
  static ObjectItem fromModel(DataField item, Map<String, dynamic> json) {
    return ObjectItem(
      id: item.id,
      title: item.name ?? '',
      subTitle: item.type ?? '',
      sortFields: [
        (key: 'name', label: 'Name'),
      ],
      raw: item,
      rawJson: json,
    );
  }

  static ObjectItem fromJson(Map<String, dynamic> json) {
    return fromModel(DataField.fromJson(json), json);
  }
}
