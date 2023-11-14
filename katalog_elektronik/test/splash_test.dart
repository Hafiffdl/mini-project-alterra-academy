import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:katalog_elektronik/screens/splash_screen.dart';

void main() {
  testWidgets('Text ElectroHub', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SplashScreen(),
      ),
    );

    expect(find.text('ElectroHub'), findsOneWidget);
  });

  testWidgets('Text The Electronic Catalog App', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SplashScreen(),
      ),
    );
    
    expect(find.text('The Electronic Catalog App'), findsOneWidget);
  });

  testWidgets('Image ElectroHub', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SplashScreen(),
      ),
    );
    
    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('Elevated Button Login', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SplashScreen(),
      ),
    );
    
    expect(find.widgetWithText(ElevatedButton, 'Login'), findsWidgets);
  });

  testWidgets('Elevated Button Sign Up', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SplashScreen(),
      ),
    );
    
    expect(find.widgetWithText(ElevatedButton, 'Sign Up'), findsWidgets);
  });
}