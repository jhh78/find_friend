import 'package:flutter/material.dart';

class CustomDropdownMenu extends StatelessWidget {
  const CustomDropdownMenu({
    super.key,
    required this.hintText,
    required this.years,
  });

  final String hintText;
  final List<String> years;

  @override
  Widget build(BuildContext context) {
    int currentYear = DateTime.now().year;
    List<String> years =
        List<String>.generate(101, (index) => (currentYear - index).toString());

    return DropdownButton<String>(
      isExpanded: true,
      style: const TextStyle(
        fontSize: 20,
      ),
      hint: Text(
        hintText,
        style:
            Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.grey),
      ),
      iconEnabledColor: Colors.blueGrey[700],
      items: years.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Center(child: Text('$value年卒業')),
        );
      }).toList(),
      onChanged: (_) {},
    );
  }
}
