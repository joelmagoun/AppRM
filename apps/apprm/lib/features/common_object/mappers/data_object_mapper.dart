import '../entities/object_item.dart';
import '../foundation/models/data_object.dart';

class DataObjectToObjectItemMapper {
  static ObjectItem fromModel(DataObject item, Map<String, dynamic> json) {
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
    return fromModel(DataObject.fromJson(json), json);
  }
}
