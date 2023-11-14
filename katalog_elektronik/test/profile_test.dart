import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:katalog_elektronik/screens/profile/profile_screen.dart';

// Fungsi callback
void onUsernameUpdated(String newUsername) {}

void main() {
  testWidgets('Halaman Profile screen terdapat "Profile" text', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ProfileScreen(onUsernameUpdated: onUsernameUpdated),
      ),
    );
    expect(find.text("Profile"), findsWidgets);
  });

  testWidgets('Image Profile Screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ProfileScreen(onUsernameUpdated: onUsernameUpdated),
        
      ),
    );
    expect(find.byType(CircleAvatar), findsOneWidget);
  });

  testWidgets('Text Button Edit Profile', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
      home: ProfileScreen(onUsernameUpdated: onUsernameUpdated,),
    ));

    expect(find.widgetWithText(TextButton, 'Edit Profile'), findsWidgets);
  });

  testWidgets('Button Log Out', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ProfileScreen(onUsernameUpdated: onUsernameUpdated),
      ),
    );
    expect(find.widgetWithText(ElevatedButton, 'Log Out'), findsOneWidget);
  });
}
