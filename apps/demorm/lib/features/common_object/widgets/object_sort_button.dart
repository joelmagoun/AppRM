import 'package:demorm/typedefs/sort_field.dart';
import 'package:demorm/widgets/icon_with_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'object_sorting.dart';

class ObjectSortButton extends ConsumerStatefulWidget {
  const ObjectSortButton({
    super.key,
    required this.sortFields,
    required this.sortValues,
    required this.onSortChange,
  });

  final List<SortField> sortFields;
  final Map<String, String?> sortValues;
  final void Function(Map<String, String?> values) onSortChange;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ObjectSortButtonState();
}

class _ObjectSortButtonState extends ConsumerState<ObjectSortButton> {
  @override
  Widget build(BuildContext context) {
    final cleanedSort = widget.sortValues.entries
        .fold({}, (r, e) => {...r, if (e.value != null) e.key: e.value});
    return IconWithIndicator(
      hasIndicator: cleanedSort.isNotEmpty,
      icon: IconButton(
        onPressed: () async {
          final result = await showCupertinoModalBottomSheet(
            context: context,
            barrierColor: Colors.black38,
            builder: (context) => ObjectSorting(
              sortFields: widget.sortFields,
              sortValues: widget.sortValues,
            ),
            enableDrag: true,
            expand: false,
            backgroundColor: Colors.transparent,
          );

          if (result != null) {
            widget.onSortChange(result);
          }
        },
        icon: const Icon(PhosphorIconsBold.arrowsDownUp),
      ),
    );
  }
}
