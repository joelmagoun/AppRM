import '../entities/object_item.dart';
import '../foundation/models/location.dart';

class LocationToObjectItemMapper {
  static ObjectItem fromModel(Location item, Map<String, dynamic> json) {
    return ObjectItem(
      id: item.id,
      title: item.streetAddress ?? '<empty>',
      subTitle: '${item.city} ${item.state}',
      sortFields: [
        (key: 'city', label: 'City'),
        (key: 'state', label: 'State'),
      ],
      raw: item,
      rawJson: json
    );
  }

  static ObjectItem fromJson(Map<String, dynamic> json) {
    return fromModel(Location.fromJson(json), json);
  }
}
