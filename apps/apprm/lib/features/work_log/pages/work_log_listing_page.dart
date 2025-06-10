import 'package:flutter/material.dart';

import '../../../constants/color.dart';
import '../../common_object/widgets/listing/object_list_wrapper.dart';
import '../../object/widgets/generic_item_card.dart';
import '../../object/widgets/generic_list_empty.dart';
import '../../common_object/mappers/work_log_mapper.dart';
import '../../common_object/foundation/object_repository.dart';
import '../../../router.dart';

class WorkLogListingPage extends StatelessWidget {
  const WorkLogListingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const Text('Work Log'),
      ),
      body: ObjectListWrapper(
        objectType: 'work_logs',
        mapperFn: WorkLogToObjectItemMapper.fromJson,
        itemCardBuilder: (item) => GenericItemCard(item: item),
        emptyBuilder: () => const GenericListEmpty(),
        sortFields: const [
          (key: 'created_at', label: 'Date', value: null),
        ],
        filterFields: const [],
        searchFields: const ['description'],
        onDetailNavigateFn: (id) async {
          final data = await ObjectRepository().getObjectItem(
            tableName: 'work_logs',
            objectId: id,
          );
          final appId = data['app_id'] as String?;
          if (appId != null) {
            await ObjectDetailRoute(
              appId: appId,
              objectType: 'work_logs',
              objectId: id,
            ).push(context);
          }
        },
      ),
    );
  }
}
