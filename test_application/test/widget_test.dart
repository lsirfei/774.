import 'package:flutter_test/flutter_test.dart';
import 'package:test_application/main.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('LoginApp loads and shows login button', (WidgetTester tester) async {
    // 加载你的app
    await tester.pumpWidget(LoginApp());

    // 查找“登录”按钮，确保恰好有一个
    expect(find.widgetWithText(ElevatedButton, '登录'), findsOneWidget);
  });
}
