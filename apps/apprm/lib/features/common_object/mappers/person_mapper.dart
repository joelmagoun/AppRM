import '../entities/object_item.dart';
import '../foundation/models/person.dart';

class PersonToObjectItemMapper {
  static ObjectItem fromModel(Person item, Map<String, dynamic> json) {
    return ObjectItem(
      id: item.id,
      title: '${item.first} ${item.last}',
      subTitle: item.jobTitle,
      sortFields: [
        (key: 'fist', label: 'First Name'),
        (key: 'last', label: 'Last Name'),
      ],
      raw: item,
      rawJson: json,
    );
  }

  static ObjectItem fromJson(Map<String, dynamic> json) {
    return fromModel(Person.fromJson(json), json);
  }
}
