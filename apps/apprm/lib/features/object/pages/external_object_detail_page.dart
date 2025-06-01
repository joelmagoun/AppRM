import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../common_object/entities/object_item.dart';

import '../../common_object/mappers/adp_user_mapper.dart';
import '../../common_object/mappers/sap_user_mapper.dart';
import '../../common_object/widgets/external_detail/object_detail_wrapper.dart';

class ExternalObjectDetailPage extends StatefulWidget {
  const ExternalObjectDetailPage({
    super.key,
    required this.externalObjectType,
    required this.externalObjectId,
  });

  final String externalObjectType;
  final String externalObjectId;

  @override
  State<ExternalObjectDetailPage> createState() =>
      _ExternalObjectDetailPageState();
}

class _ExternalObjectDetailPageState extends State<ExternalObjectDetailPage> {
  final objectDataMap = {
    'adp_system_users': (
      dataMapperFn: AdpUserToObjectItemMapper.fromJson,
      displayFields: [
        (key: 'username_adp', label: 'Username'),
        (key: 'first_name', label: 'First name'),
        (key: 'last_name', label: 'Last name'),
        (key: 'email', label: 'Email'),
        (key: 'job_title', label: 'Job title'),
        (key: 'start_date_adp', label: 'Start date'),
        (key: 'end_date_adp', label: 'End date'),
      ],
      actionButtons: [
        (
          name: 'Reset Password',
          code: 'RESET_PASSWORD',
          params: [
            {"name": "password", "type": "TEXT"}
          ]
        ),
        (
          name: 'Suspend User',
          code: 'SUSPEND_USER',
          params: [],
        ),
        (
          name: 'Assign License',
          code: 'ASSIGN_LICENSE',
          params: [
            {
              "name": "license",
              "type": "SINGLE_SELECT",
              "value": ["E3", "E5", "F1"]
            }
          ],
        )
      ]
    ),
    'sap_system_users': (
      dataMapperFn: SapUserToObjectItemMapper.fromJson,
      displayFields: [
        (key: 'username_sap', label: 'Username'),
        (key: 'first_name', label: 'First name'),
        (key: 'last_name', label: 'Last name'),
        (key: 'email', label: 'Email'),
        (key: 'job_title', label: 'Job title'),
        (key: 'start_date_sap', label: 'Start date'),
        (key: 'end_date_sap', label: 'End date'),
      ],
      actionButtons: [
        (
          name: 'Reset Password',
          code: 'RESET_PASSWORD',
          params: [
            {"name": "password", "type": "TEXT"}
          ]
        ),
        (
          name: 'Suspend User',
          code: 'SUSPEND_USER',
          params: [],
        )
      ]
    ),
  };

  @override
  Widget build(BuildContext context) {
    final objectTypeParam =
        GoRouterState.of(context).queryParameters['object-type'];
    final objectIdParam =
        GoRouterState.of(context).queryParameters['object-id'];

    final objectData = objectDataMap[widget.externalObjectType];

    return ExternalObjectDetailWrapper(
      objectType: objectTypeParam,
      objectId: objectIdParam,
      externalObjectType: widget.externalObjectType,
      externalObjectId: widget.externalObjectId,
      mapperFn: objectData?.dataMapperFn ?? (e) => ObjectItem.fromJson(e),
      displayFields: objectData?.displayFields
              .map((e) => (key: e.key, label: e.label))
              .toList() ??
          [],
      actionButtons: objectData?.actionButtons
              .map((e) => (
                    name: e.name,
                    code: e.code,
                    params:
                        e.params.map<Map<String, dynamic>>((e) => e).toList(),
                  ))
              .toList() ??
          [],
    );
  }
}
