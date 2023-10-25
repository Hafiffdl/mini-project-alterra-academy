import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:katalog_elektronik/auth/signup_screen.dart';

void main() {
  testWidgets('Halaman Sign Up screen terdapat "Sign Up" text', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
      home: SignupScreen(),
    ));

    expect(find.text("Sign Up"), findsWidgets);
  });

  testWidgets('Body Sign Up screen terdapat "Create an Account" text', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
      home: SignupScreen(),
    ));

    expect(find.text("Create an Account"), findsWidgets);
  });

testWidgets('TextFormField', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
      home: SignupScreen(),
    ));

    expect(find.byType(TextFormField), findsWidgets);
  });

  testWidgets('TextFormField Username', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
      home: SignupScreen(),
    ));

    expect(find.widgetWithText(TextFormField, 'Username'), findsWidgets);
  });

    testWidgets('TextFormField Email', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
      home: SignupScreen(),
    ));

    expect(find.widgetWithText(TextFormField, 'Email'), findsWidgets);
  });

  testWidgets('TextFormField Password', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
      home: SignupScreen(),
    ));

    expect(find.widgetWithText(TextFormField, 'Password'), findsWidgets);
  });

testWidgets('person icon', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Icon(Icons.person),
        ),
      ),
    );
    expect(find.byIcon(Icons.person), findsOneWidget);
  });

  testWidgets('password icon', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Icon(Icons.password),
        ),
      ),
    );
    expect(find.byIcon(Icons.password), findsOneWidget);
  });

testWidgets('email icon', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Icon(Icons.email),
        ),
      ),
    );
    expect(find.byIcon(Icons.email), findsOneWidget);
  });

testWidgets('Button Sign Up', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: SignupScreen(
        ),
      ),
    );
    expect(find.widgetWithText(ElevatedButton, 'Sign Up'), findsOneWidget);
  });

testWidgets('Image Sign Up Page', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: SignupScreen(
        ),
      ),
    );
    expect(find.byType(Image), findsOneWidget);
  });


}


