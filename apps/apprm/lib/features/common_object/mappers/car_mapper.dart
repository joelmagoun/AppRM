import '../entities/object_item.dart';
import '../foundation/models/car.dart';

class CarToObjectItemMapper {
  static ObjectItem fromModel(Car item, Map<String, dynamic> json) {
    return ObjectItem(
      id: item.id,
      title: '${item.model} ${item.make}, ${item.year}',
      subTitle: item.vinNumber,
      sortFields: [
        (key: 'make', label: 'Make'),
        (key: 'model', label: 'Model'),
        (key: 'year', label: 'Year'),
      ],
      raw: item,
      rawJson: json,
    );
  }

  static ObjectItem fromJson(Map<String, dynamic> json) {
    return fromModel(Car.fromJson(json), json);
  }
}
