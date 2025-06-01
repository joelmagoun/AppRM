import '../entities/object_item.dart';
import '../foundation/models/adp_user.dart';

class AdpUserToObjectItemMapper {
  static ObjectItem fromModel(AdpUser item, Map<String, dynamic> json) {
    return ObjectItem(
      id: item.id,
      title: '${item.firstName} ${item.lastName}',
      subTitle: item.jobTitle,
      raw: item,
      rawJson: json,
    );
  }

  static ObjectItem fromJson(Map<String, dynamic> json) {
    return fromModel(AdpUser.fromJson(json), json);
  }
}

class AdpUserToPersonMapper {
  static Map<String, dynamic> getJson(Map<String, dynamic> json) {
    final adpUser = AdpUser.fromJson(json);
    return {
      'first': adpUser.firstName,
      'last': adpUser.lastName,
      'jobTitle': adpUser.jobTitle,
      'email': adpUser.email,
    };
  }
}
