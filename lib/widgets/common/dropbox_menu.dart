import 'package:find_friend/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomDropBoxMenu extends StatelessWidget {
  final String label;
  final List<Map<String, dynamic>> items;
  final Function(String) callBack;

  const CustomDropBoxMenu({
    super.key,
    required this.label,
    required this.items,
    required this.callBack,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: COLOR_MAP['text'],
              ),
        ),
        DropdownMenu(
          width: MediaQuery.of(context).size.width * 0.45,
          menuHeight: MediaQuery.of(context).size.height / 3,
          trailingIcon: const Icon(
            Icons.arrow_drop_down,
            color: Colors.black87,
          ),
          textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: COLOR_MAP['text'],
              ),
          menuStyle: const MenuStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(
              Colors.black87,
            ),
          ),
          dropdownMenuEntries:
              items.map<DropdownMenuEntry<String>>((Map<String, dynamic> json) {
            return DropdownMenuEntry<String>(
              value: json['value'],
              label: json['label'],
            );
          }).toList(),
          onSelected: (value) {
            callBack(value.toString());
          },
        ),
      ],
    );
  }
}
