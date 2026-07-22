import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:smart_food_access/main.dart';
import 'package:smart_food_access/models/food_item.dart';
import 'package:smart_food_access/providers/food_provider.dart';
import 'package:smart_food_access/screens/auth_screen.dart';

void main() {
  group('Smart Food Access — Unit & Widget Tests', () {
    test('FoodItem model calculations and defaults', () {
      final item = FoodItem(
        id: 'test-1',
        title: 'Fresh Apples',
        description: 'Crisp red apples',
        price: 100.0,
        originalPrice: 150.0,
        farmerName: 'Test Farm',
        location: '1 km away',
        quantity: 10,
        unit: 'kg',
        imageUrl: 'https://example.com/apple.jpg',
        expiryDate: '3 days',
        postedAt: DateTime.now(),
      );

      expect(item.id, 'test-1');
      expect(item.discountPercent.round(), 33);
      expect(item.isOrganic, false);
      expect(item.rating, 4.5);
    });

    test('FoodProvider state management', () {
      final provider = FoodProvider();

      expect(provider.items.isNotEmpty, true);
      expect(provider.cart.isEmpty, true);

      final firstItem = provider.items.first;
      provider.addToCart(firstItem, quantity: 2);

      expect(provider.cart.length, 1);
      expect(provider.cart.first.selectedQuantity, 2);

      provider.placeOrder();

      expect(provider.cart.isEmpty, true);
      expect(provider.orders.length, 1);
      expect(provider.orders.first['status'], 'Requested');
    });

    testWidgets('App renders AuthScreen on launch', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => FoodProvider()),
          ],
          child: const MyApp(),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Smart Food Access'), findsOneWidget);
      expect(find.text('Find Food'), findsOneWidget);
      expect(find.text('Provide Food'), findsOneWidget);
      expect(find.text('Company Analytics'), findsOneWidget);
    });
  });
}
