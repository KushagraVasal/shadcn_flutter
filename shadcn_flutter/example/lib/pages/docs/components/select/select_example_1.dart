import 'package:shadcn_flutter/shadcn_flutter.dart';

class SelectExample1 extends StatefulWidget {
  const SelectExample1({super.key});

  @override
  State<SelectExample1> createState() => _SelectExample1State();
}

class _SelectExample1State extends State<SelectExample1> {
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Select<String>(
      itemBuilder: (context, item) {
        return Text(item);
      },
      searchFilter: (item, query) {
        return item.toLowerCase().contains(query.toLowerCase()) ? 1 : 0;
      },
      popupConstraints: const BoxConstraints(
        maxHeight: 200,
      ),
      onChanged: (value) {
        setState(() {
          selectedValue = value;
        });
      },
      value: selectedValue,
      placeholder: Text('Select a fruit'),
      children: [
        SelectGroup(
          children: [
            SelectLabel(
              child: Text('Apple'),
            ),
            SelectItemButton(
              value: 'Red Apple',
              child: Text('Red Apple'),
            ),
            SelectItemButton(
              value: 'Green Apple',
              child: Text('Green Apple'),
            ),
          ],
        ),
        SelectGroup(
          children: [
            SelectLabel(
              child: Text('Banana'),
            ),
            SelectItemButton(
              value: 'Yellow Banana',
              child: Text('Yellow Banana'),
            ),
            SelectItemButton(
              value: 'Brown Banana',
              child: Text('Brown Banana'),
            ),
          ],
        ),
        SelectGroup(
          children: [
            SelectLabel(
              child: Text('Lemon'),
            ),
            SelectItemButton(
              value: 'Yellow Lemon',
              child: Text('Yellow Lemon'),
            ),
            SelectItemButton(
              value: 'Green Lemon',
              child: Text('Green Lemon'),
            ),
          ],
        ),
        SelectGroup(
          children: [
            SelectLabel(
              child: Text('Tomato'),
            ),
            SelectItemButton(
              value: 'Red Tomato',
              child: Text('Red Tomato'),
            ),
            SelectItemButton(
              value: 'Green Tomato',
              child: Text('Green Tomato'),
            ),
            SelectItemButton(
              value: 'Yellow Tomato',
              child: Text('Yellow Tomato'),
            ),
            SelectItemButton(
              value: 'Brown Tomato',
              child: Text('Brown Tomato'),
            ),
          ],
        ),
      ],
    );
  }
}