import '../entities/object_item.dart';
import '../foundation/models/prompt.dart';

class PromptToObjectItemMapper {
  static ObjectItem fromModel(Prompt item, Map<String, dynamic> json) {
    return ObjectItem(
      id: item.id,
      title: item.purpose ?? '',
      subTitle: item.notes,
      sortFields: [
        (key: 'purpose', label: 'Purpose'),
      ],
      raw: item,
      rawJson: json,
    );
  }

  static ObjectItem fromJson(Map<String, dynamic> json) {
    return fromModel(Prompt.fromJson(json), json);
  }
}
