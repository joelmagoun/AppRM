import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common_object/entities/object_item.dart';

class HistoryItemCard extends ConsumerWidget {
  const HistoryItemCard({super.key, required this.item});

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
      title: Text(item.title),
      subtitle: item.subTitle != null ? Text(item.subTitle!) : null,
    );
  }
}
