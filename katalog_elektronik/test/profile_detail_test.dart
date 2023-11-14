import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:katalog_elektronik/screens/profile/profile_detail.dart';

void main() {
  testWidgets('Halaman Profile screen terdapat "Profile Detail" text', (WidgetTester tester) async {
    const username = 'Hafif';

    await tester.pumpWidget(
      const MaterialApp(
        home: ProfileDetailScreen(username: username),
      ),
    );
    expect(find.text("Profile Detail"), findsOneWidget);
  });

  testWidgets('Circle Avatar Profile Detail Screen', (WidgetTester tester) async {
    const username = 'Hafif';
    await tester.pumpWidget(
      const MaterialApp(
        home: ProfileDetailScreen(username: username),
        
      ),
    );
    expect(find.byType(CircleAvatar), findsOneWidget);
  });

}