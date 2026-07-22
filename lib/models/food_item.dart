class FoodItem {
  final String id;
  final String title;
  final String description;
  final double price;
  final double? originalPrice; // For discount display
  final String farmerName;
  final String farmerAvatar; // Initials or URL
  final String location;
  final double quantity; // in kg or unit
  final String unit; // 'kg', 'bunch', 'box'
  final String imageUrl;
  final bool isDonation;
  final String expiryDate;
  final DateTime postedAt;
  final bool isOrganic;
  final double rating;
  final int reviewCount;
  final int freshnessDays; // Days the product stays fresh
  final String harvestDate;
  final String category; // 'Vegetables', 'Fruits', 'Grains', 'Dairy', 'Greens'

  FoodItem({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    this.originalPrice,
    required this.farmerName,
    this.farmerAvatar = '',
    required this.location,
    required this.quantity,
    required this.unit,
    required this.imageUrl,
    this.isDonation = false,
    required this.expiryDate,
    required this.postedAt,
    this.isOrganic = false,
    this.rating = 4.5,
    this.reviewCount = 0,
    this.freshnessDays = 5,
    this.harvestDate = 'Today',
    this.category = 'Vegetables',
  });

  double get discountPercent {
    if (originalPrice == null || originalPrice! <= price) return 0;
    return ((originalPrice! - price) / originalPrice! * 100);
  }
}

final List<FoodItem> mockFoodItems = [
  FoodItem(
    id: '1',
    title: 'Fresh Organic Tomatoes',
    description:
        'Freshly handpicked tomatoes from the farm. Very juicy and sweet. Grown using zero chemical pesticides with traditional farming techniques passed down for generations.',
    price: 299.0,
    originalPrice: 380.0,
    farmerName: 'Green Valley Farm',
    farmerAvatar: 'GV',
    location: '12 km away',
    quantity: 50,
    unit: 'kg',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/8/89/Tomato_je.jpg',
    expiryDate: '3 days',
    postedAt: DateTime.now().subtract(const Duration(hours: 2)),
    isOrganic: true,
    rating: 4.8,
    reviewCount: 124,
    freshnessDays: 5,
    harvestDate: 'Today',
    category: 'Vegetables',
  ),
  FoodItem(
    id: '2',
    title: 'Surplus Potatoes',
    description:
        'We have extra potatoes from this harvest! Free to take for community kitchens. Perfect for soups, curries and more.',
    price: 0.0,
    farmerName: 'Sunny Side Farms',
    farmerAvatar: 'SS',
    location: '5 km away',
    quantity: 100,
    unit: 'kg',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/a/ab/Patates.jpg',
    isDonation: true,
    expiryDate: '1 week',
    postedAt: DateTime.now().subtract(const Duration(hours: 5)),
    isOrganic: false,
    rating: 4.3,
    reviewCount: 42,
    freshnessDays: 10,
    harvestDate: 'Yesterday',
    category: 'Vegetables',
  ),
  FoodItem(
    id: '3',
    title: 'Organic Carrots',
    description:
        'Crunchy orange carrots grown without pesticides. Perfect for salads, juices and cooking. Harvested at peak ripeness.',
    price: 169.0,
    originalPrice: 210.0,
    farmerName: 'Happy Earth Farm',
    farmerAvatar: 'HE',
    location: '8 km away',
    quantity: 20,
    unit: 'kg',
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/a/a2/Vegetable-Carrot-Bundle-wStalks.jpg',
    expiryDate: '5 days',
    postedAt: DateTime.now().subtract(const Duration(hours: 12)),
    isOrganic: true,
    rating: 4.6,
    reviewCount: 88,
    freshnessDays: 7,
    harvestDate: 'Yesterday',
    category: 'Vegetables',
  ),
  FoodItem(
    id: '4',
    title: 'Imperfect Apples',
    description:
        'Slightly bruised apples perfect for pies and cider. Heavy discount. Taste is the same, appearance differs slightly.',
    price: 89.0,
    originalPrice: 180.0,
    farmerName: 'Orchard Hills',
    farmerAvatar: 'OH',
    location: '15 km away',
    quantity: 30,
    unit: 'kg',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/1/15/Red_Apple.jpg',
    expiryDate: '1 week',
    postedAt: DateTime.now().subtract(const Duration(days: 1)),
    isOrganic: false,
    rating: 4.2,
    reviewCount: 55,
    freshnessDays: 8,
    harvestDate: '2 days ago',
    category: 'Fruits',
  ),
  FoodItem(
    id: '5',
    title: 'Assorted Greens',
    description:
        'Spinach, kale, and lettuce mixed bags. Over-harvested, giving away today! Great for smoothies and salads.',
    price: 0.0,
    farmerName: 'Metro Greenhouses',
    farmerAvatar: 'MG',
    location: '3 km away',
    quantity: 15,
    unit: 'bags',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/e/eb/Spinach_leaves.jpg',
    isDonation: true,
    expiryDate: 'Tomorrow',
    postedAt: DateTime.now().subtract(const Duration(minutes: 30)),
    isOrganic: true,
    rating: 4.7,
    reviewCount: 31,
    freshnessDays: 2,
    harvestDate: 'Today',
    category: 'Greens',
  ),
];
