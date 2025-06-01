import 'package:demorm/features/common_object/widgets/item_sorting.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../constants/color.dart';
import '../../../typedefs/sort_field.dart';

class ObjectSorting extends StatefulWidget {
  const ObjectSorting({
    super.key,
    required this.sortFields,
    required this.sortValues,
  });

  final List<SortField> sortFields;
  final Map<String, String?> sortValues;

  @override
  State<ObjectSorting> createState() => _ObjectSortingState();
}

class _ObjectSortingState extends State<ObjectSorting> {
  final sortValuesNotifier = ValueNotifier<Map<String, String?>>({});

  @override
  void initState() {
    sortValuesNotifier.value = widget.sortValues;
    super.initState();
  }

  @override
  void dispose() {
    sortValuesNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
                        'Sort',
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
            ValueListenableBuilder(
              valueListenable: sortValuesNotifier,
              builder: (context, sortValues, _) {
                return ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (_, idx) {
                    final sortField = widget.sortFields[idx];
                    return ItemSorting(
                      label: sortField.label,
                      ascLabel: 'Ascending',
                      ascValue: 'asc',
                      descLabel: 'Descending',
                      descValue: 'desc',
                      value: sortValues[sortField.key],
                      onChange: (value) {
                        sortValuesNotifier.value = {
                          sortField.key: value,
                        };
                      },
                    );
                  },
                  separatorBuilder: (_, idx) => const SizedBox(height: 8),
                  itemCount: widget.sortFields.length,
                );
              },
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
                          sortValuesNotifier.value = {};
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
                          Navigator.of(context).pop(sortValuesNotifier.value);
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
