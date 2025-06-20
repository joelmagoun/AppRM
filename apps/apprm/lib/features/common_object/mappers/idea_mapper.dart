import '../entities/object_item.dart';
import '../foundation/models/idea.dart';

class IdeaToObjectItemMapper {
  static ObjectItem fromModel(Idea item, Map<String, dynamic> json) {
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
    return fromModel(Idea.fromJson(json), json);
  }
}
