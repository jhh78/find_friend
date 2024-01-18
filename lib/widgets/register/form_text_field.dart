import 'package:flutter/material.dart';

class RegisterFormText extends StatelessWidget {
  final String title;
  final String hintText;
  final bool? isDropdown;
  final String? errorText;
  const RegisterFormText({
    Key? key,
    required this.title,
    required this.hintText,
    this.isDropdown = false,
    this.errorText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int currentYear = DateTime.now().year;
    List<String> years =
        List<String>.generate(101, (index) => (currentYear - index).toString());
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          isDropdown != null && isDropdown!
              ? DropdownButton<String>(
                  isExpanded: true,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  hint: Text(hintText),
                  items: years.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Center(child: Text('$value年卒業')),
                    );
                  }).toList(),
                  onChanged: (_) {},
                )
              : TextField(
                  decoration: InputDecoration(
                      hintText: hintText, border: const OutlineInputBorder()),
                ),
          errorText != null
              ? Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    errorText!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.red[400]),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
