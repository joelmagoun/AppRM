import 'package:apprm/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../constants/color.dart';
import '../../common_object/entities/object_item.dart';
import '../../common_object/mappers/adp_user_mapper.dart';
import '../../common_object/mappers/sap_user_mapper.dart';
import '../../common_object/widgets/external_listing/external_object_list.dart';

class ExternalObjectListingPage extends StatefulWidget {
  const ExternalObjectListingPage({
    super.key,
    required this.externalObjectType,
  });

  final String externalObjectType;

  @override
  State<ExternalObjectListingPage> createState() =>
      _ExternalObjectListingPageState();
}

class _ExternalObjectListingPageState extends State<ExternalObjectListingPage> {
  final objectDataMap = {
    'adp_system_users': (
      title: 'ADP Users',
      dataMapperFn: AdpUserToObjectItemMapper.fromJson,
    ),
    'sap_system_users': (
      title: 'SAP Users',
      dataMapperFn: SapUserToObjectItemMapper.fromJson,
    ),
  };

  final listWrapperKey = GlobalKey<ExternalObjectListState>();

  @override
  Widget build(BuildContext context) {
    final objectTypeParam =
        GoRouterState.of(context).queryParameters['object-type'];
    final objectIdParam =
        GoRouterState.of(context).queryParameters['object-id'];
    final objectData = objectDataMap[widget.externalObjectType];

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Text(objectData?.title ?? '--'),
      ),
      body: ExternalObjectList(
        key: listWrapperKey,
        externalObjectType: widget.externalObjectType,
        objectId: objectIdParam,
        mapperFn: objectData?.dataMapperFn ?? (e) => ObjectItem.fromJson(e),
        onDetailNavigateFn: (itemId) async {
          final result = await ExternalObjectDetailRoute(
            objectType: objectTypeParam,
            objectId: objectIdParam,
            externalObjectType: widget.externalObjectType,
            externalObjectId: itemId,
          ).push(context);

          listWrapperKey.currentState?.onRefreshList();

          if (result == true && context.mounted) {
            context.pop();
          }
        },
      ),
    );
  }
}
