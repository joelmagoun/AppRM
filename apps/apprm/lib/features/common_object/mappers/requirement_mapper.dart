import '../entities/object_item.dart';
import '../foundation/models/requirement.dart';

class RequirementToObjectItemMapper {
  static ObjectItem fromModel(Requirement item, Map<String, dynamic> json) {
    return ObjectItem(
      id: item.id,
      title: item.requirement ?? '',
      subTitle: '',
      sortFields: [
        (key: 'requirement', label: 'Requirement'),
      ],
      raw: item,
      rawJson: json,
    );
  }

  static ObjectItem fromJson(Map<String, dynamic> json) {
    return fromModel(Requirement.fromJson(json), json);
  }
}
