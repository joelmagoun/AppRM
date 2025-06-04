import '../entities/object_item.dart';
import '../foundation/models/user_story.dart';

class UserStoryToObjectItemMapper {
  static ObjectItem fromModel(UserStory item, Map<String, dynamic> json) {
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
    return fromModel(UserStory.fromJson(json), json);
  }
}
