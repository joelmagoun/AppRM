import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:demorm/typedefs/action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../foundation/action_repository.dart';
import '../../foundation/use_cases/create_action_usecase.dart';
import 'menu_action_dialog_content.dart';

class MenuAction extends ConsumerStatefulWidget {
  const MenuAction({
    super.key,
    required this.externalObjectType,
    required this.externalObjectId,
    required this.actionButtons,
  });

  final String externalObjectType;
  final String externalObjectId;
  final List<ActionButton> actionButtons;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MenuActionState();
}

class _MenuActionState extends ConsumerState<MenuAction> {
  final createActionMutation = Mutation<void, CreateActionUseCaseParams>(
    queryFn: (params) => CreateActionUseCase(
      actionRepository: ActionRepository(),
    ).execute(params),
  );

  @override
  Widget build(BuildContext context) {
    return PullDownButton(
      itemBuilder: (context) => widget.actionButtons
          .map((e) => PullDownMenuItem(
                title: e.name,
                onTap: () async {
                  String? paramValue;
                  if (e.params.isNotEmpty) {
                    final result = await showCupertinoModalBottomSheet<String?>(
                      context: context,
                      expand: false,
                      builder: (context) {
                        return MenuActionDialogContent(actionButton: e);
                      },
                    );

                    paramValue = result?.isNotEmpty ?? false ? result : null;
                  }

                  final userId = Supabase.instance.client.auth.currentUser?.id;
                  if (userId != null) {
                    try {
                      EasyLoading.show(status: 'Executing...');
                      await createActionMutation.mutate(
                        CreateActionUseCaseParams(userId: userId, data: {
                          'action': e.code,
                          'params': paramValue,
                          'user_id': userId,
                          'status': 'PENDING',
                          'external_object_type': widget.externalObjectType,
                          'external_object_id': widget.externalObjectId,
                        }),
                      );
                      EasyLoading.showSuccess(
                        'Execute action "${e.name}" successfully.',
                      );
                    } catch (e) {
                      EasyLoading.showError(e.toString());
                    } finally {
                      EasyLoading.dismiss();
                    }
                  }
                },
              ))
          .toList(),
      buttonBuilder: (context, showMenu) => Padding(
        padding: const EdgeInsets.only(right: 8),
        child: IconButton(
          onPressed: showMenu,
          icon: const Icon(PhosphorIconsBold.dotsThreeOutline),
        ),
      ),
    );
  }
}
