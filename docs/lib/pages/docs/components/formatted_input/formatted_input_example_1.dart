import 'package:shadcn_flutter/shadcn_flutter.dart';

class FormattedInputExample1 extends StatelessWidget {
  const FormattedInputExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return FormattedInput(
      trailing: IconButton.text(
        density: ButtonDensity.compact,
        icon: Icon(Icons.calendar_month),
        onPressed: () {},
      ),
      onChanged: (value) {
        if (value == null) {
          return;
        }
        List<String> parts = [];
        for (FormattedValuePart part in value.parts) {
          parts.add(part.value ?? '');
        }
        print(parts.join('/'));
      },
      initialValue: FormattedValue([
        InputPart.editable(length: 2, width: 40, placeholder: Text('MM'))
            .withValue('01'),
        InputPart.static('/'),
        InputPart.editable(length: 2, width: 40, placeholder: Text('DD'))
            .withValue('02'),
        InputPart.static('/'),
        InputPart.editable(length: 4, width: 60, placeholder: Text('YYYY'))
            .withValue('2021'),
      ]),
    );
  }
}
