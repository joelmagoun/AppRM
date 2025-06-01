import 'package:apprm/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../typedefs/filter_field.dart';
import 'item_filtering.dart';

class ObjectFiltering extends StatefulWidget {
  const ObjectFiltering({
    super.key,
    required this.objectType,
    required this.filterFields,
    required this.filterValues,
  });

  final String objectType;
  final List<FilterField> filterFields;
  final Map<String, String?> filterValues;

  @override
  State<ObjectFiltering> createState() => _ObjectFilteringState();
}

class _ObjectFilteringState extends State<ObjectFiltering> {
  final filterValuesNotifier = ValueNotifier<Map<String, String?>>({});

  @override
  void initState() {
    filterValuesNotifier.value = widget.filterValues;
    super.initState();
  }

  @override
  void dispose() {
    filterValuesNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.all(6),
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ).copyWith(bottom: 8),
              child: Row(
                children: [
                  Opacity(
                    opacity: 0,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(PhosphorIconsRegular.x),
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Filter',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(PhosphorIconsRegular.x),
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
              thickness: 0.5,
              color: Colors.grey.shade300,
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: filterValuesNotifier,
                builder: (context, filterValues, _) {
                  return ListView.separated(
                    itemBuilder: (_, idx) {
                      final filterField = widget.filterFields[idx];
                      return ItemFiltering(
                        objectType: widget.objectType,
                        field: filterField.key,
                        label: filterField.label,
                        value: filterValues[filterField.key],
                        onChange: (value) {
                          filterValuesNotifier.value = {
                            filterField.key: value,
                          };
                        },
                      );
                    },
                    separatorBuilder: (_, idx) => const SizedBox(height: 0),
                    itemCount: widget.filterFields.length,
                  );
                },
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          filterValuesNotifier.value = {};
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primaryColor,
                        ),
                        child: const Text('Clear All'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: FilledButton(
                        onPressed: () {
                          Navigator.of(context).pop(filterValuesNotifier.value);
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                        ),
                        child: const Text('Apply'),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
