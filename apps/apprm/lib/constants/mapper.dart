import '../features/common_object/mappers/adp_user_mapper.dart';
import '../features/common_object/mappers/sap_user_mapper.dart';

const kExternalDataMapperFnMap = {
  'people': {
    'adp_system_users': AdpUserToPersonMapper.getJson,
    'sap_system_users': SapUserToPersonMapper.getJson,
  }
};
