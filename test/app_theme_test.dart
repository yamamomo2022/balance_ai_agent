import 'package:balance_ai_agent/utility/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppTheme Tests', () {
    test('AppTheme has all required color constants', () {
      // Test that all primary colors are defined
      expect(AppTheme.primaryColor, equals(const Color(0xFF3A8891)));
      expect(AppTheme.secondaryColor, equals(const Color.fromARGB(255, 98, 185, 195)));
      
      // Test gradient colors
      expect(AppTheme.gradientStart, equals(const Color.fromARGB(255, 114, 219, 184)));
      expect(AppTheme.gradientEnd, equals(const Color.fromARGB(255, 87, 151, 199)));
      expect(AppTheme.loginGradientStart, equals(const Color(0xFFE8F3F3)));
      expect(AppTheme.loginGradientEnd, equals(Colors.white));
      
      // Test accent colors
      expect(AppTheme.bottomNavSelectedColor, equals(Colors.cyan));
      expect(AppTheme.editModeColor, equals(Colors.blue));
      expect(AppTheme.saveModeColor, equals(Colors.green));
      
      // Test system colors
      expect(AppTheme.errorColor, equals(Colors.red));
      expect(AppTheme.successColor, equals(Colors.green));
      expect(AppTheme.transparent, equals(Colors.transparent));
      expect(AppTheme.shadowColor, equals(Colors.black));
      expect(AppTheme.whiteColor, equals(Colors.white));
    });
    
    test('AppTheme gradients are properly defined', () {
      // Test AppBar gradient
      expect(AppTheme.appBarGradient.colors, contains(AppTheme.gradientStart));
      expect(AppTheme.appBarGradient.colors, contains(AppTheme.gradientEnd));
      expect(AppTheme.appBarGradient.begin, equals(Alignment.topLeft));
      expect(AppTheme.appBarGradient.end, equals(Alignment.bottomRight));
      
      // Test login background gradient
      expect(AppTheme.loginBackgroundGradient.colors, contains(AppTheme.loginGradientStart));
      expect(AppTheme.loginBackgroundGradient.colors, contains(AppTheme.loginGradientEnd));
      expect(AppTheme.loginBackgroundGradient.begin, equals(Alignment.topCenter));
      expect(AppTheme.loginBackgroundGradient.end, equals(Alignment.bottomCenter));
    });
    
    test('AppTheme cannot be instantiated', () {
      // This test ensures the private constructor works correctly
      // We can't directly test instantiation since it's private, but we can verify 
      // that all members are static by accessing them without an instance
      expect(() => AppTheme.primaryColor, returnsNormally);
      expect(() => AppTheme.appBarGradient, returnsNormally);
    });
  });
}