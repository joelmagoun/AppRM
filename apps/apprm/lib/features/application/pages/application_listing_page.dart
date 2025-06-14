import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../bootstrap/powersync.dart';

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
  bool _isAdmin = false;

  @override
  void initState() {
    super.initState();
    _loadRole();
  }

  Future<void> _loadRole() async {
    final admin = await isAdminUser();
    if (mounted) {
      setState(() {
        _isAdmin = admin;
      });
    }
  }

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
            child: _isAdmin
                ? IconButton.filled(
                    onPressed: () async {
                      await ApplicationAddingRoute().push(context);
                      listWrapperKey.currentState?.listKey.currentState?.onRefreshList();
                    },
                    icon: const Icon(PhosphorIconsBold.plus),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: Colors.white,
                    ),
                  )
                : IconButton(
                    onPressed: () async {
                      await logout();
                      if (context.mounted) {
                        const AuthPageRoute().pushReplacement(context);
                      }
                    },
                    icon: const Icon(PhosphorIconsBold.signOut),
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
          ApplicationHomeRoute(appId: id).push(context);
        },
      ),
    );
  }
}
