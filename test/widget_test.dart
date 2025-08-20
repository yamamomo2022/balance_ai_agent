// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:balance_ai_agent/models/lifestyle.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Lifestyle Model Tests', () {
    test('Lifestyle model creation and serialization works correctly', () {
      // Create a lifestyle instance
      final lifestyle = Lifestyle(
        goals: 'Test goals',
        aspirations: 'Test aspirations',
      );

      // Verify the properties
      expect(lifestyle.goals, 'Test goals');
      expect(lifestyle.aspirations, 'Test aspirations');

      // Test serialization
      final map = lifestyle.toMap();
      expect(map['goals'], 'Test goals');
      expect(map['aspirations'], 'Test aspirations');

      // Test deserialization
      final fromMap = Lifestyle.fromMap(map);
      expect(fromMap.goals, lifestyle.goals);
      expect(fromMap.aspirations, lifestyle.aspirations);
    });

    test('Lifestyle model handles empty values', () {
      final lifestyle = Lifestyle(
        goals: '',
        aspirations: '',
      );

      expect(lifestyle.goals, '');
      expect(lifestyle.aspirations, '');
    });

    test('Lifestyle fromMap handles missing values', () {
      final lifestyle = Lifestyle.fromMap({});
      expect(lifestyle.goals, '');
      expect(lifestyle.aspirations, '');
    });
  });
}
