import 'package:demorm/constants/color.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ItemSorting<T> extends StatefulWidget {
  const ItemSorting({
    super.key,
    required this.label,
    required this.ascLabel,
    required this.ascValue,
    required this.descLabel,
    required this.descValue,
    this.value,
    this.onChange,
  });

  final String label;
  final String ascLabel;
  final String ascValue;
  final String descLabel;
  final String descValue;
  final String? value;
  final void Function(String? value)? onChange;

  @override
  State<ItemSorting<T>> createState() => _ItemSortingState<T>();
}

class _ItemSortingState<T> extends State<ItemSorting<T>> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(4),
      child: InkWell(
        onTap: () {
          if (widget.value == widget.ascValue) {
            widget.onChange?.call(widget.descValue);
          } else if (widget.value == widget.descValue) {
            widget.onChange?.call(null);
          } else {
            widget.onChange?.call(widget.ascValue);
          }
        },
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  widget.label,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Builder(builder: (context) {
                  if (widget.value == widget.ascValue) {
                    return Text(widget.ascLabel);
                  }

                  if (widget.value == widget.descValue) {
                    return Text(widget.descLabel);
                  }

                  return const SizedBox.shrink();
                }),
              ),
              Builder(builder: (context) {
                if (widget.value == widget.ascValue) {
                  return const Icon(
                    PhosphorIconsBold.sortAscending,
                    color: AppColors.primaryColor,
                  );
                }

                if (widget.value == widget.descValue) {
                  return const Icon(
                    PhosphorIconsBold.sortDescending,
                    color: AppColors.primaryColor,
                  );
                }

                return const Icon(
                  PhosphorIconsRegular.list,
                  color: Colors.black54,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
