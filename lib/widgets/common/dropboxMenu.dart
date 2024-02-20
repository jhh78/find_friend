import 'package:find_friend/widgets/common/text.dart';
import 'package:flutter/material.dart';

class CustomDropBoxMenu extends StatelessWidget {
  final String label;
  final List<Map<String, dynamic>> items;
  final Function(String) onSelected;
  final bool? isExpanded;
  final bool isRequired;

  const CustomDropBoxMenu({
    super.key,
    required this.label,
    required this.items,
    required this.onSelected,
    this.isExpanded,
    this.isRequired = false,
  });

  Widget _renderTextTitle(BuildContext context) {
    if (isRequired) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextWidget(
            text: label,
            kind: 'inputFieldTitle',
          ),
          const CustomTextWidget(
            text: ' *必須',
            kind: 'error',
          ),
        ],
      );
    }

    return CustomTextWidget(
      text: label,
      kind: 'inputFieldTitle',
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = isExpanded == null
        ? MediaQuery.of(context).size.width * 0.45
        : MediaQuery.of(context).size.width * 0.95;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _renderTextTitle(context),
        DropdownMenu(
          width: width,
          menuHeight: MediaQuery.of(context).size.height / 3,
          trailingIcon: const Icon(
            Icons.arrow_drop_down,
          ),
          textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(),
          dropdownMenuEntries:
              items.map<DropdownMenuEntry<String>>((Map<String, dynamic> json) {
            return DropdownMenuEntry<String>(
              value: json['value'],
              label: json['label'],
            );
          }).toList(),
          onSelected: (value) {
            onSelected(value.toString());
          },
        ),
      ],
    );
  }
}
