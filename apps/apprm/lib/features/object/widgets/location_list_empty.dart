import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../constants/color.dart';

class LocationListEmpty extends ConsumerWidget {
  const LocationListEmpty({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Image.asset(
            'assets/images/img_location_empty.png',
            width: 128,
            height: 128,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 32),
            child: Text(
              'You haven\'t added any locations yet!',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Text(
            'Start by adding your favorite, frequent, or dream destinations!',
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: IconButton.filled(
              onPressed: () {},
              icon: const Icon(PhosphorIconsBold.plus),
              style: IconButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
