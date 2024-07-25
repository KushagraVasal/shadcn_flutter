import 'package:example/pages/docs/components/star_rating/star_rating_example_1.dart';
import 'package:example/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../component_page.dart';

class StarRatingExample extends StatelessWidget {
  const StarRatingExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'star_rating',
      displayName: 'Star Rating',
      description: 'A component for rating.',
      children: [
        WidgetUsageExample(
          title: 'Example',
          child: StarRatingExample1(),
          path:
              'lib/pages/docs/components/star_rating/star_rating_example_1.dart',
        ),
      ],
    );
  }
}
