import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:katalog_elektronik/auth/login_screen.dart';

void main() {
  testWidgets('Halaman Login screen terdapat "Login" text', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
      home: LoginScreen(),
    ));

    expect(find.text("Login"), findsWidgets);
  });

testWidgets('TextFormField', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
      home: LoginScreen(),
    ));

    expect(find.byType(TextFormField), findsWidgets);
  });

  testWidgets('TextFormField Username', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
      home: LoginScreen(),
    ));

    expect(find.widgetWithText(TextFormField, 'Username'), findsWidgets);
  });

    testWidgets('TextFormField Email', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
      home: LoginScreen(),
    ));

    expect(find.widgetWithText(TextFormField, 'Email'), findsWidgets);
  });

  testWidgets('TextFormField Password', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
      home: LoginScreen(),
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

testWidgets('Button Login', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LoginScreen(
        ),
      ),
    );
    expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
  });

testWidgets('Image Login Page', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LoginScreen(
        ),
      ),
    );
    expect(find.byType(Image), findsOneWidget);
  });
}


