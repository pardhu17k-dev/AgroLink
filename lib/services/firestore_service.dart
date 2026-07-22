import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/food_item.dart';

class FirestoreService {
  FirebaseFirestore get _db => FirebaseFirestore.instance;

  // FOOD LISTINGS

  Stream<List<FoodItem>> getFoodListings() {
    return _db.collection('food_items').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return FoodItem(
          id: doc.id,
          title: data['title'] ?? '',
          description: data['description'] ?? '',
          price: (data['price'] ?? 0).toDouble(),
          farmerName: data['farmerName'] ?? 'Unknown',
          location: data['location'] ?? 'Unknown',
          quantity: (data['quantity'] ?? 0).toDouble(),
          unit: data['unit'] ?? 'kg',
          imageUrl: data['imageUrl'] ?? '',
          isDonation: data['isDonation'] ?? false,
          expiryDate: data['expiryDate'] ?? '',
          postedAt: (data['postedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
        );
      }).toList();
    });
  }

  Future<void> addFoodItem(FoodItem item) async {
    await _db.collection('food_items').doc(item.id).set({
      'title': item.title,
      'description': item.description,
      'price': item.price,
      'farmerName': item.farmerName,
      'location': item.location,
      'quantity': item.quantity,
      'unit': item.unit,
      'imageUrl': item.imageUrl,
      'isDonation': item.isDonation,
      'expiryDate': item.expiryDate,
      'postedAt': Timestamp.fromDate(item.postedAt),
    });
  }

  // ORDERS

  Stream<List<Map<String, dynamic>>> getOrders(String userId, String role) {
    if (role == 'farmer') {
      return _db.collection('orders').where('farmerId', isEqualTo: userId).snapshots().map((snapshot) {
        return snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList();
      });
    } else {
      return _db.collection('orders').where('userId', isEqualTo: userId).snapshots().map((snapshot) {
        return snapshot.docs.map((doc) => {'id': doc.id, ...doc.data()}).toList();
      });
    }
  }

  Future<void> placeOrder(Map<String, dynamic> orderData) async {
    await _db.collection('orders').add(orderData);
  }

  Future<void> updateOrderStatus(String orderId, String status) async {
    await _db.collection('orders').doc(orderId).update({'status': status});
  }

  // ANALYTICS

  Future<Map<String, dynamic>> getCompanyAnalytics() async {
    // Basic aggregation
    final foodSnap = await _db.collection('food_items').get();
    final orderSnap = await _db.collection('orders').get();

    double totalFoodQuantity = 0;
    for (var doc in foodSnap.docs) {
      totalFoodQuantity += (doc.data()['quantity'] ?? 0).toDouble();
    }

    return {
      'totalListings': foodSnap.docs.length,
      'totalOrders': orderSnap.docs.length,
      'totalFoodQuantity': totalFoodQuantity,
    };
  }
}
