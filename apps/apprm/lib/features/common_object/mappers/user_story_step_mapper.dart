import '../entities/object_item.dart';
import '../foundation/models/user_story_step.dart';

class UserStoryStepToObjectItemMapper {
  static ObjectItem fromModel(UserStoryStep item, Map<String, dynamic> json) {
    return ObjectItem(
      id: item.id,
      title: item.name ?? '',
      subTitle: item.description ?? '',
      sortFields: [
        (key: 'rank', label: 'Rank'),
      ],
      raw: item,
      rawJson: json,
    );
  }

  static ObjectItem fromJson(Map<String, dynamic> json) {
    return fromModel(UserStoryStep.fromJson(json), json);
  }
}
