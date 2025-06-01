import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:apprm/constants/color.dart';
import 'package:flutter/material.dart';

import '../foundation/object_repository.dart';
import '../foundation/use_cases/get_unique_field_list_usecase.dart';

class ItemFiltering extends StatefulWidget {
  const ItemFiltering({
    super.key,
    required this.field,
    required this.label,
    required this.objectType,
    this.value,
    this.onChange,
  });

  final String field;
  final String label;
  final String objectType;
  final String? value;
  final void Function(String? value)? onChange;

  @override
  State<ItemFiltering> createState() => _ItemFilteringState();
}

class _ItemFilteringState extends State<ItemFiltering> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      shape: const Border(),
      textColor: AppColors.primaryColor,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(widget.label),
          Visibility(
            visible: widget.value != null,
            child: const Padding(
              padding: EdgeInsets.only(left: 8),
              child: CircleAvatar(
                backgroundColor: Colors.green,
                radius: 4,
              ),
            ),
          )
        ],
      ),
      children: <Widget>[
        QueryBuilder<List<Map<String, dynamic>>>(
          query: Query(
              key: [widget.objectType, widget.field, "list"],
              queryFn: () async {
                return await GetUniqueFieldListUseCase(
                  objectRepository: ObjectRepository(),
                ).execute(GetUniqueFieldListUseCaseParams(
                  objectType: widget.objectType,
                  field: widget.field,
                ));
              },
              config: QueryConfig(
                cacheDuration: const Duration(seconds: 1),
                refetchDuration: const Duration(seconds: 1),
                storeQuery: false,
              )),
          builder: (context, state) {
            return Column(
              children: state.data?.map(
                    (e) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(4),
                            onTap: () {
                              if (widget.value == e[widget.field]) {
                                widget.onChange?.call(null);
                              } else {
                                widget.onChange?.call(e[widget.field]);
                              }
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      e[widget.field],
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                  Checkbox(
                                    value: widget.value == e[widget.field],
                                    onChanged: (value) {
                                      if (value ?? false) {
                                        widget.onChange?.call(e[widget.field]);
                                      } else {
                                        widget.onChange?.call(null);
                                      }
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ).toList() ??
                  [],
            );
          },
        ),
      ],
    );
  }
}
