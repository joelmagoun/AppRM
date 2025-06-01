import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../constants/color.dart';
import '../../entities/object_item.dart';

class ExternalObjectItemCard extends ConsumerWidget {
  const ExternalObjectItemCard({
    super.key,
    required this.item,
    this.objectId,
  });

  final String? objectId;
  final ObjectItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      ),
      selected: true,
      selectedTileColor: Colors.white,
      leading: CircleAvatar(
        backgroundColor: AppColors.primaryColor.withOpacity(0.1),
        child: const Icon(
          PhosphorIconsBold.dropHalf,
          color: AppColors.primaryColor,
          size: 24,
        ),
      ),
      title: Text(item.title),
      subtitle: item.subTitle != null ? Text(item.subTitle!) : null,
      trailing: Builder(builder: (context) {
        if (item.rawJson?['parent_object_id'] != null) {
          return const Icon(
            PhosphorIconsBold.check,
            size: 20,
          );
        }
        return const Icon(
          PhosphorIconsBold.caretRight,
          size: 20,
        );
      }),
    );
  }
}
