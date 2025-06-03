import '../entities/object_item.dart';
import '../foundation/models/story.dart';

class StoryToObjectItemMapper {
  static ObjectItem fromModel(Story item, Map<String, dynamic> json) {
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
    return fromModel(Story.fromJson(json), json);
  }
}
