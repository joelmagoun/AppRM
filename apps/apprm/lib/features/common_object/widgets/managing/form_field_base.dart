import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../typedefs/input_field.dart';

class FormFieldBase extends ConsumerWidget {
  const FormFieldBase({super.key, required this.field});

  final InputField field;

  Widget _renderFormField(InputField item) {
    if (item.displayMode == 'SINGLE_SELECT') {
      return QueryBuilder<List<String>>(
          query: Query(
              key: [
                '${item.key}__option',
                "list",
              ],
              queryFn: () async {
                if (item.options != null) return item.options!;
                return item.asyncOptions?.call() ?? [];
              },
              config: QueryConfig(
                cacheDuration: const Duration(seconds: 1),
                refetchDuration: const Duration(seconds: 1),
                storeQuery: false,
              )),
          builder: (context, state) {
            return ReactiveDropdownField<String>(
              formControlName: item.key,
              hint: Text('Select ${item.label}...'),
              decoration: InputDecoration(
                hintText: item.placeholder,
                border: const OutlineInputBorder(),
              ),
              items: state.data
                      ?.map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList() ??
                  [],
            );
          });
    }

    return ReactiveTextField(
      formControlName: item.key,
      decoration: InputDecoration(
        hintText: item.placeholder,
        border: const OutlineInputBorder(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(field.label),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: _renderFormField(field),
        ),
      ],
    );
  }
}
