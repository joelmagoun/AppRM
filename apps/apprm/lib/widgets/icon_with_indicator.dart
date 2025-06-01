import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IconWithIndicator extends ConsumerWidget {
  const IconWithIndicator({
    super.key,
    required this.icon,
    this.hasIndicator = false,
  });

  final bool hasIndicator;
  final Widget icon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        icon,
        if (hasIndicator)
          const Positioned(
            bottom: 8,
            right: 8,
            child: CircleAvatar(
              backgroundColor: Colors.green,
              radius: 4,
            ),
          )
      ],
    );
  }
}
