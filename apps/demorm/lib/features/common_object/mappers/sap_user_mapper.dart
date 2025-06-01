import '../entities/object_item.dart';
import '../foundation/models/sap_user.dart';

class SapUserToObjectItemMapper {
  static ObjectItem fromModel(SapUser item, Map<String, dynamic> json) {
    return ObjectItem(
      id: item.id,
      title: '${item.firstName} ${item.lastName}',
      subTitle: item.jobTitle,
      raw: item,
      rawJson: json,
    );
  }

  static ObjectItem fromJson(Map<String, dynamic> json) {
    return fromModel(SapUser.fromJson(json), json);
  }
}

class SapUserToPersonMapper {
  static Map<String, dynamic> getJson(Map<String, dynamic> json) {
    final sapUser = SapUser.fromJson(json);
    return {
      'first': sapUser.firstName,
      'last': sapUser.lastName,
      'jobTitle': sapUser.jobTitle,
      'email': sapUser.email,
    };
  }
}
