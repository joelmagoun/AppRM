import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:apprm/constants/mapper.dart';
import 'package:apprm/typedefs/action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../constants/color.dart';

import '../../../../typedefs/display_field.dart';
import '../../entities/object_item.dart';
import '../../foundation/external_object_repository.dart';
import '../../foundation/object_repository.dart';
import '../../foundation/use_cases/connect_to_external_object_usecase.dart';
import '../../foundation/use_cases/create_object_from_external_object_usecase.dart';
import '../../foundation/use_cases/disconnect_from_external_object_usecase.dart';
import '../../foundation/use_cases/get_external_object_item_usecase.dart';
import 'menu_action.dart';
import 'object_detail_card.dart';

class ExternalObjectDetailWrapper extends ConsumerStatefulWidget {
  const ExternalObjectDetailWrapper({
    super.key,
    this.objectType,
    this.objectId,
    required this.externalObjectType,
    required this.externalObjectId,
    required this.mapperFn,
    required this.displayFields,
    required this.actionButtons,
  });

  final String? objectType;
  final String? objectId;
  final String externalObjectType;
  final String externalObjectId;
  final ObjectItem Function(Map<String, dynamic>) mapperFn;
  final List<DisplayField> displayFields;
  final List<ActionButton> actionButtons;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ExternalObjectDetailWrapperState();
}

class _ExternalObjectDetailWrapperState
    extends ConsumerState<ExternalObjectDetailWrapper> {
  final connectToExternalObjectMutation =
      Mutation<void, ConnectToExternalObjectUseCaseParams>(
    queryFn: (params) => ConnectToExternalObjectUseCase(
      objectRepository: ObjectRepository(),
    ).execute(params),
  );

  final disconnectFromExternalObjectMutation =
      Mutation<void, DisconnectFromExternalObjectUseCaseParams>(
    queryFn: (params) => DisconnectFromExternalObjectUseCase(
      objectRepository: ObjectRepository(),
    ).execute(params),
  );

  final createObjectFromExternalObjectMutation =
      Mutation<void, CreateObjectFromExternalObjectUseCaseParams>(
    queryFn: (params) => CreateObjectFromExternalObjectUseCase(
      objectRepository: ObjectRepository(),
    ).execute(params),
  );

  late Query<Map<String, dynamic>> query;

  @override
  void initState() {
    query = Query(
        key: [
          widget.externalObjectType,
          "item",
          widget.externalObjectId,
        ],
        queryFn: () async {
          return await GetExternalObjectItemUseCase(
            externalObjectRepository: ExternalObjectRepository(),
          ).execute(GetExternalObjectItemUseCaseParams(
            externalObjectType: widget.externalObjectType,
            externalObjectId: widget.externalObjectId,
          ));
        },
        config: QueryConfig(
          cacheDuration: const Duration(seconds: 1),
          refetchDuration: const Duration(seconds: 1),
          storeQuery: false,
        ));
    super.initState();
  }

  Widget _renderMainAction(Map<String, dynamic>? item) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 24,
        ),
        child: Builder(builder: (context) {
          if (item?['parent_object_id'] != null &&
              item?['parent_object_type'] != null) {
            return FilledButton.icon(
              onPressed: () async {
                await disconnectFromExternalObjectMutation.mutate(
                  DisconnectFromExternalObjectUseCaseParams(
                    objectType: item?['parent_object_type'],
                    objectId: item?['parent_object_id'],
                    externalObjectType: widget.externalObjectType,
                    externalObjectId: widget.externalObjectId,
                  ),
                );
                query.refetch();
              },
              icon: const Icon(PhosphorIconsBold.x),
              label: const Text('Disconnect'),
            );
          }

          if (widget.objectType != null &&
              widget.objectId != null &&
              item?['parent_object_type'] == null &&
              item?['parent_object_id'] == null) {
            return FilledButton.icon(
              onPressed: () async {
                await connectToExternalObjectMutation.mutate(
                  ConnectToExternalObjectUseCaseParams(
                    objectType: widget.objectType!,
                    objectId: widget.objectId!,
                    externalObjectType: widget.externalObjectType,
                    externalObjectId: widget.externalObjectId,
                  ),
                );
                query.refetch();
              },
              icon: const Icon(PhosphorIconsBold.plus),
              label: const Text('Connect'),
            );
          }

          return FilledButton.icon(
            onPressed: () async {
              await createObjectFromExternalObjectMutation.mutate(
                CreateObjectFromExternalObjectUseCaseParams(
                  objectType: widget.objectType!,
                  externalObjectType: widget.externalObjectType,
                  externalObjectId: widget.externalObjectId,
                  data: kExternalDataMapperFnMap[widget.objectType]
                              ?[widget.externalObjectType]
                          ?.call(item ?? {}) ??
                      {},
                ),
              );
              if (context.mounted) {
                context.pop(true);
              }
            },
            icon: const Icon(PhosphorIconsBold.plus),
            label: const Text('Add'),
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QueryBuilder<Map<String, dynamic>>(
      query: query,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: false,
            title: const Text('Personal System Details'),
            actions: [
              MenuAction(
                externalObjectType: widget.externalObjectType,
                externalObjectId: widget.externalObjectId,
                actionButtons: widget.actionButtons,
              )
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: ExternalObjectDetailCard(
                    externalObjectType: widget.externalObjectType,
                    externalObjectId: widget.externalObjectId,
                    displayFields: widget.displayFields,
                    objectItem: state.data,
                  ),
                ),
              ),
              _renderMainAction(state.data),
            ],
          ),
        );
      },
    );
  }
}
