import '../entities/object_item.dart';
import '../foundation/models/user_story_step_action.dart';

class UserStoryStepActionToObjectItemMapper {
  static ObjectItem fromModel(UserStoryStepAction item, Map<String, dynamic> json) {
    return ObjectItem(
      id: item.id,
      title: item.targetType ?? '',
      subTitle: item.description ?? '',
      sortFields: [
        (key: 'rank', label: 'Rank'),
      ],
      raw: item,
      rawJson: json,
    );
  }

  static ObjectItem fromJson(Map<String, dynamic> json) {
    return fromModel(UserStoryStepAction.fromJson(json), json);
  }
}
