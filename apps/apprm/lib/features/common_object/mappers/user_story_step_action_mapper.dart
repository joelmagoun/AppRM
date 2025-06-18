import '../entities/object_item.dart';
import '../foundation/models/user_story_step_action.dart';

class UserStoryStepActionToObjectItemMapper {
  static ObjectItem fromModel(UserStoryStepAction item, Map<String, dynamic> json) {
    return ObjectItem(
      id: item.id,
      title: item.description ?? '',
      subTitle: item.targetType == 'element'
          ? (json['element_name'] ?? '')
          : (json['function_name'] ?? ''),
      sortFields: const [
        (key: 'description', label: 'Description'),
      ],
      raw: item,
      rawJson: json,
    );
  }

  static ObjectItem fromJson(Map<String, dynamic> json) {
    return fromModel(UserStoryStepAction.fromJson(json), json);
  }
}
