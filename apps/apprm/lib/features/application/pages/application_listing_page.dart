import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../constants/color.dart';
import '../../common_object/entities/object_item.dart';
import '../../common_object/mappers/application_mapper.dart';
import '../../common_object/widgets/listing/object_list_wrapper.dart';
import '../../object/widgets/generic_item_card.dart';
import '../../object/widgets/generic_list_empty.dart';
import '../../../router.dart';

class ApplicationListingPage extends StatefulWidget {
  const ApplicationListingPage({super.key});

  @override
  State<ApplicationListingPage> createState() => _ApplicationListingPageState();
}

class _ApplicationListingPageState extends State<ApplicationListingPage> {
  final listWrapperKey = GlobalKey<ObjectListWrapperState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const Text('Applications'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton.filled(
              onPressed: () async {
                await ApplicationAddingRoute().push(context);
                listWrapperKey.currentState?.listKey.currentState?.onRefreshList();
              },
              icon: const Icon(PhosphorIconsBold.plus),
              style: IconButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: ObjectListWrapper(
        key: listWrapperKey,
        objectType: 'applications',
        mapperFn: ApplicationToObjectItemMapper.fromJson,
        itemCardBuilder: (item) => GenericItemCard(item: item),
        emptyBuilder: () => const GenericListEmpty(),
        sortFields: const [
          (key: 'name', label: 'Name', value: null),
        ],
        filterFields: const [],
        searchFields: const ['name'],
        onDetailNavigateFn: (id) {
          AppHomeRoute(appId: id).push(context);
        },
      ),
    );
  }
}
