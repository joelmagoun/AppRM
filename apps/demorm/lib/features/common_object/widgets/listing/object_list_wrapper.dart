import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../typedefs/filter_field.dart';
import '../../../../typedefs/sort_field.dart';
import '../../entities/object_item.dart';
import '../object_filter_button.dart';
import 'object_list.dart';
import '../object_sort_button.dart';

class ObjectListWrapper extends ConsumerStatefulWidget {
  const ObjectListWrapper({
    super.key,
    required this.objectType,
    required this.mapperFn,
    this.itemCardBuilder,
    this.emptyBuilder,
    required this.sortFields,
    required this.filterFields,
    required this.searchFields,
    required this.onDetailNavigateFn,
  });

  final String objectType;
  final ObjectItem Function(Map<String, dynamic>) mapperFn;
  final Widget Function(ObjectItem item)? itemCardBuilder;
  final Widget Function()? emptyBuilder;
  final List<SortField> sortFields;
  final List<FilterField> filterFields;
  final List<String> searchFields;
  final void Function(String itemId) onDetailNavigateFn;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      ObjectListWrapperState();
}

class ObjectListWrapperState extends ConsumerState<ObjectListWrapper> {
  final listKey = GlobalKey<ObjectListState>();

  final sortValuesNotifier = ValueNotifier<Map<String, String?>>({});
  final filterValuesNotifier = ValueNotifier<Map<String, String?>>({});
  final searchValueNotifier = ValueNotifier<String?>(null);

  @override
  void dispose() {
    sortValuesNotifier.dispose();
    filterValuesNotifier.dispose();
    searchValueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16).copyWith(top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: const Icon(PhosphorIconsBold.magnifyingGlass),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (value) {
                    EasyDebounce.debounce(
                      'search_object',
                      const Duration(milliseconds: 300),
                      () {
                        searchValueNotifier.value = value;
                      },
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              ValueListenableBuilder(
                valueListenable: sortValuesNotifier,
                builder: (context, sortValues, _) {
                  return ObjectSortButton(
                    sortFields: widget.sortFields,
                    sortValues: sortValues,
                    onSortChange: (Map<String, String?> values) {
                      sortValuesNotifier.value = values;

                      CachedQuery.instance.refetchQueries(
                        keys: [widget.objectType, "list"],
                      );
                    },
                  );
                },
              ),
              ValueListenableBuilder(
                valueListenable: filterValuesNotifier,
                builder: (context, filterValues, _) {
                  return ObjectFilterButton(
                    objectType: widget.objectType,
                    filterFields: widget.filterFields,
                    filterValues: filterValues,
                    onFilterChange: (Map<String, String?> values) {
                      filterValuesNotifier.value = values;

                      CachedQuery.instance.refetchQueries(
                        keys: [widget.objectType, "list"],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: sortValuesNotifier,
            builder: (context, sortValues, _) {
              return ValueListenableBuilder(
                valueListenable: filterValuesNotifier,
                builder: (context, filterValues, _) {
                  return ValueListenableBuilder(
                    valueListenable: searchValueNotifier,
                    builder: (context, searchValue, _) {
                      return ObjectList(
                        key: listKey,
                        objectType: widget.objectType,
                        mapperFn: widget.mapperFn,
                        itemCardBuilder: widget.itemCardBuilder,
                        emptyBuilder: widget.emptyBuilder,
                        sortValues: sortValues,
                        filterValues: filterValues,
                        searchFields: widget.searchFields,
                        searchValue: searchValue,
                        onDetailNavigateFn: widget.onDetailNavigateFn,
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
