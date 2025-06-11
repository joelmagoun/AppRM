import 'dart:convert';

import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:pull_down_button/pull_down_button.dart';

import '../../../../constants/color.dart';

import '../../../../typedefs/display_field.dart';
import '../../entities/object_item.dart';
import '../../foundation/object_repository.dart';
import '../../foundation/use_cases/delete_object_item_usecase.dart';
import '../../foundation/use_cases/get_object_item_usecase.dart';
import 'object_detail_card.dart';

class ObjectDetailWrapper extends ConsumerStatefulWidget {
  const ObjectDetailWrapper({
    super.key,
    required this.objectType,
    required this.objectId,
    required this.appId,
    required this.mapperFn,
    required this.displayFields,
    required this.onEditingNavigateFn,
    this.screenId,
  });

  final String objectType;
  final String objectId;
  final String appId;
  final String? screenId;
  final ObjectItem Function(Map<String, dynamic>) mapperFn;
  final List<DisplayField> displayFields;
  final VoidCallback onEditingNavigateFn;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ObjectDetailWrapperState();
}

class _ObjectDetailWrapperState extends ConsumerState<ObjectDetailWrapper> {
  final deleteObjectItemMutation =
      Mutation<void, DeleteObjectItemUseCaseParams>(
    queryFn: (params) => DeleteObjectItemUseCase(
      objectRepository: ObjectRepository(),
    ).execute(params),
  );

  @override
  Widget build(BuildContext context) {
    return QueryBuilder<Map<String, dynamic>>(
        query: Query(
            key: [
              widget.objectType,
              "item",
              widget.objectId,
            ],
            queryFn: () async {
              return await GetObjectItemUseCase(
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
          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: false,
              title: Builder(
                builder: (context) {
                  if (state.data != null) {
                    final objectItem = widget.mapperFn(state.data ?? {});
                    return Text(objectItem.title);
                  }

                  return const Text('--');
                },
              ),
              actions: [
                PullDownButton(
                  itemBuilder: (context) => [
                    PullDownMenuItem(
                      icon: PhosphorIconsRegular.pencilSimple,
                      title: 'Edit',
                      onTap: () {
                        widget.onEditingNavigateFn();
                      },
                    ),
                    PullDownMenuItem(
                      icon: PhosphorIconsRegular.trash,
                      title: 'Delete',
                      onTap: () async {
                        final result = await showDialog(
                          context: context,
                          builder: (dialogContext) {
                            return AlertDialog(
                              icon: const Icon(
                                PhosphorIconsDuotone.trash,
                                color: Colors.red,
                                size: 40,
                              ),
                              title: const Text('Delete this record?'),
                              content: const Text(
                                'Are you sure you want to delete this record? You can\'t undo this action.',
                                textAlign: TextAlign.center,
                              ),
                              actionsPadding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 16,
                              ).copyWith(top: 0),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(dialogContext).pop();
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.black54,
                                  ),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    Navigator.of(dialogContext).pop(true);
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.red,
                                  ),
                                  child: const Text('Delete'),
                                )
                              ],
                            );
                          },
                        );

                        if (result == true) {
                          try {
                            EasyLoading.show(status: 'Deleting...');
                            await deleteObjectItemMutation
                                .mutate(DeleteObjectItemUseCaseParams(
                              objectType: widget.objectType,
                              objectId: widget.objectId,
                            ));
                            CachedQuery.instance.refetchQueries(
                              filterFn: (listKeys, _) {
                                return (listKeys as List)
                                    .where(
                                      (e) =>
                                          jsonEncode(e).startsWith(jsonEncode([
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
                      isDestructive: true,
                    ),
                  ],
                  buttonBuilder: (context, showMenu) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: IconButton(
                      onPressed: showMenu,
                      icon: const Icon(PhosphorIconsBold.dotsThreeOutline),
                    ),
                  ),
                )
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: ObjectDetailCard(
                objectType: widget.objectType,
                objectId: widget.objectId,
                appId: widget.appId,
                screenId: widget.screenId,
                displayFields: widget.displayFields,
                objectItem: state.data,
              ),
            ),
          );
        });
  }
}
