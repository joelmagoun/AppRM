import 'package:flutter/material.dart';

import '../../../constants/color.dart';
import '../../common_object/widgets/listing/object_list_wrapper.dart';
import '../../object/widgets/generic_item_card.dart';
import '../../object/widgets/generic_list_empty.dart';
import '../../common_object/mappers/history_mapper.dart';

class HistoryListingPage extends StatelessWidget {
  const HistoryListingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const Text('History'),
      ),
      body: const ObjectListWrapper(
        objectType: 'history',
        mapperFn: HistoryToObjectItemMapper.fromJson,
        itemCardBuilder: (item) => GenericItemCard(item: item),
        emptyBuilder: GenericListEmpty.new,
        sortFields: [
          (key: 'created_at', label: 'Date', value: null),
        ],
        filterFields: [],
        searchFields: ['message'],
        onDetailNavigateFn: _noop,
      ),
    );
  }

  static void _noop(String id) {}
}
