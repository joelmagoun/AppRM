import 'package:demorm/router.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../../constants/mock.dart';

class ExternalSystemSelection extends StatefulWidget {
  const ExternalSystemSelection({
    super.key,
    required this.objectType,
    required this.objectId,
    required this.connectedSystemList,
  });

  final String objectType;
  final String objectId;
  final List<String> connectedSystemList;

  @override
  State<ExternalSystemSelection> createState() =>
      _ExternalSystemSelectionState();
}

class _ExternalSystemSelectionState extends State<ExternalSystemSelection> {
  @override
  Widget build(BuildContext context) {
    final availableExternalSystemList = kExternalSystemList
        .where((e) => !widget.connectedSystemList.contains(e))
        .toList();

    return SafeArea(
      bottom: false,
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.all(6),
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ).copyWith(bottom: 8),
              child: Row(
                children: [
                  Opacity(
                    opacity: 0,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(PhosphorIconsRegular.x),
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Connect HR System',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(PhosphorIconsRegular.x),
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
              thickness: 0.5,
              color: Colors.grey.shade300,
            ),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemBuilder: (_, idx) {
                return Material(
                  color: Colors.transparent,
                  child: ListTile(
                    onTap: () async {
                      await ExternalObjectListingRoute(
                        objectType: widget.objectType,
                        objectId: widget.objectId,
                        externalObjectType: availableExternalSystemList[idx],
                      ).push(context);

                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                    },
                    title: Text(
                      kExternalSystemMap[availableExternalSystemList[idx]] ??
                          '--',
                    ),
                    trailing: const Icon(
                      PhosphorIconsBold.caretRight,
                      size: 20,
                    ),
                  ),
                );
              },
              separatorBuilder: (_, idx) => const SizedBox(height: 8),
              itemCount: availableExternalSystemList.length,
            ),
            const SafeArea(child: SizedBox(height: 8))
          ],
        ),
      ),
    );
  }
}
