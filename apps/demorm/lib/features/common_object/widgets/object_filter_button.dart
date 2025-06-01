import 'package:demorm/widgets/icon_with_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../typedefs/filter_field.dart';
import 'object_filtering.dart';

class ObjectFilterButton extends ConsumerStatefulWidget {
  const ObjectFilterButton({
    super.key,
    required this.objectType,
    required this.filterFields,
    required this.filterValues,
    required this.onFilterChange,
  });

  final String objectType;
  final List<FilterField> filterFields;
  final Map<String, String?> filterValues;
  final void Function(Map<String, String?> values) onFilterChange;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ObjectFilterButtonState();
}

class _ObjectFilterButtonState extends ConsumerState<ObjectFilterButton> {
  @override
  Widget build(BuildContext context) {
    final cleanedFilter = widget.filterValues.entries
        .fold({}, (r, e) => {...r, if (e.value != null) e.key: e.value});
    return IconWithIndicator(
      hasIndicator: cleanedFilter.isNotEmpty,
      icon: IconButton(
        onPressed: () async {
          final result = await showCupertinoModalBottomSheet(
            context: context,
            barrierColor: Colors.black38,
            builder: (context) => ObjectFiltering(
              objectType: widget.objectType,
              filterFields: widget.filterFields,
              filterValues: widget.filterValues,
            ),
            enableDrag: true,
            expand: true,
            backgroundColor: Colors.transparent,
          );

          if (result != null) {
            widget.onFilterChange(result);
          }
        },
        icon: const Icon(PhosphorIconsBold.funnelSimple),
      ),
    );
  }
}
