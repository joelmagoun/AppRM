import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../constants/color.dart';
import '../../common_object/entities/object_item.dart';

class GenericItemCard extends ConsumerWidget {
  const GenericItemCard({super.key, required this.item});

  final ObjectItem item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      onTap: () {},
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
          PhosphorIconsFill.mapPin,
          color: AppColors.primaryColor,
          size: 24,
        ),
      ),
      title: Text(item.title),
      subtitle: item.subTitle != null ? Text(item.subTitle!) : null,
      trailing: const Icon(
        PhosphorIconsBold.caretRight,
        size: 20,
      ),
    );
  }
}
