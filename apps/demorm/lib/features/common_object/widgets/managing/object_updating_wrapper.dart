import 'dart:convert';

import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../constants/color.dart';
import '../../../../typedefs/input_field.dart';
import '../../foundation/object_repository.dart';
import '../../foundation/use_cases/get_object_item_usecase.dart';
import '../../foundation/use_cases/update_object_item_usecase.dart';
import 'object_updating_form.dart';

class ObjectUpdatingWrapper extends ConsumerStatefulWidget {
  const ObjectUpdatingWrapper({
    super.key,
    required this.objectType,
    required this.objectId,
    required this.objectLabel,
    required this.inputFields,
  });

  final String objectType;
  final String objectId;
  final String objectLabel;
  final List<InputField> inputFields;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ObjectUpdatingWrapperState();
}

class _ObjectUpdatingWrapperState extends ConsumerState<ObjectUpdatingWrapper> {
  late FormGroup formGroup;

  final updateObjectItemMutation =
      Mutation<void, UpdateObjectItemUseCaseParams>(
    queryFn: (params) => UpdateObjectItemUseCase(
      objectRepository: ObjectRepository(),
    ).execute(params),
  );

  @override
  void initState() {
    formGroup = FormGroup(widget.inputFields
        .fold({}, (r, e) => {...r, e.key: FormControl<String>()}));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: Text('Edit ${widget.objectLabel}'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: TextButton.icon(
              onPressed: () async {
                formGroup.markAllAsTouched();
                if (formGroup.valid) {
                  try {
                    EasyLoading.show(status: 'Updating...');
                    await updateObjectItemMutation
                        .mutate(UpdateObjectItemUseCaseParams(
                      objectType: widget.objectType,
                      objectId: widget.objectId,
                      data: formGroup.value,
                    ));
                    CachedQuery.instance.refetchQueries(
                      keys: [
                        jsonEncode([
                          widget.objectType,
                          "item",
                          widget.objectId,
                        ]),
                      ],
                    );
                    CachedQuery.instance.refetchQueries(
                      filterFn: (listKeys, _) {
                        return (listKeys as List)
                            .where(
                              (e) => jsonEncode(e).startsWith(jsonEncode([
                                widget.objectType,
                                "list",
                              ])),
                            )
                            .isNotEmpty;
                      },
                    );
                    if (context.mounted) {
                      context.pop(true);
                    }
                  } catch (e) {
                    EasyLoading.showError(e.toString());
                  } finally {
                    EasyLoading.dismiss();
                  }
                }
              },
              icon: const Icon(PhosphorIconsBold.check),
              label: const Text('Save'),
              style: IconButton.styleFrom(
                foregroundColor: AppColors.primaryColor,
              ),
            ),
          )
        ],
      ),
      body: QueryBuilder<Map<String, dynamic>>(
        query: Query(
            key: [
              widget.objectType,
              "item",
              widget.objectId,
            ],
            queryFn: () async {
              return GetObjectItemUseCase(
                objectRepository: ObjectRepository(),
              ).execute(GetObjectItemUseCaseParams(
                objectType: widget.objectType,
                objectId: widget.objectId,
              ));
            },
            config: QueryConfig(
              cacheDuration: const Duration(seconds: 1),
              refetchDuration: const Duration(seconds: 1),
              storeQuery: false,
            )),
        builder: (context, state) {
          if (state.status == QueryStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.data != null) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: ObjectUpdatingForm(
                formGroup: formGroup,
                formValues: state.data ?? {},
                inputFields: widget.inputFields,
              ),
            );
          }

          return const Center(child: Text('Data not found.'));
        },
      ),
    );
  }
}
