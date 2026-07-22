import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/food_item.dart';
import '../widgets/food_item_card.dart';
import '../widgets/app_widgets.dart';
import '../theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'All';
  final TextEditingController _searchController = TextEditingController();

  final List<String> _categories = [
    'All', 'Vegetables', 'Fruits', 'Grains', 'Dairy', 'Greens', '🎁 Donations',
  ];

  final List<Map<String, dynamic>> _nearbyFarmers = [
    {'name': 'Green Valley', 'initials': 'GV', 'distance': '1.2 km', 'rating': 4.9, 'products': 12},
    {'name': 'Sunny Side', 'initials': 'SS', 'distance': '3.5 km', 'rating': 4.7, 'products': 8},
    {'name': 'Happy Earth', 'initials': 'HE', 'distance': '5.1 km', 'rating': 4.6, 'products': 15},
    {'name': 'Orchard Hills', 'initials': 'OH', 'distance': '7.8 km', 'rating': 4.4, 'products': 6},
    {'name': 'Metro Green', 'initials': 'MG', 'distance': '2.2 km', 'rating': 4.8, 'products': 20},
  ];

  List<FoodItem> get _filteredItems {
    if (_selectedCategory == 'All') return mockFoodItems;
    if (_selectedCategory == '🎁 Donations') {
      return mockFoodItems.where((i) => i.isDonation).toList();
    }
    return mockFoodItems
        .where((i) => i.category == _selectedCategory)
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final donationItems = mockFoodItems.where((i) => i.isDonation).toList();
    final freshItems = _filteredItems.where((i) => !i.isDonation).toList();

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── Header ──
          SliverToBoxAdapter(
            child: _buildHeader(),
          ),

          // ── Search ──
          SliverToBoxAdapter(
            child: _buildSearchBar().animate().fadeIn(delay: 100.ms),
          ),

          // ── Promo Banner ──
          SliverToBoxAdapter(
            child: _buildPromoBanner().animate().fadeIn(delay: 150.ms),
          ),

          // ── Filter Chips ──
          SliverToBoxAdapter(
            child: _buildFilterChips().animate().fadeIn(delay: 200.ms),
          ),

          // ── Nearby Farmers ──
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                SectionHeader(
                  title: '🌾 Nearby Farmers',
                  actionLabel: 'View map',
                  onAction: () {},
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 112,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: _nearbyFarmers.length,
                    itemBuilder: (ctx, i) =>
                        _buildFarmerChip(_nearbyFarmers[i], i),
                  ),
                ),
              ],
            ).animate().fadeIn(delay: 250.ms),
          ),

          // ── Community Donations ──
          if (donationItems.isNotEmpty) ...[
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 28),
                  SectionHeader(
                    title: '💚 Community Donations',
                    actionLabel: 'See all',
                    onAction: () {},
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Free produce from local farmers for those in need',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ),
                ],
              ).animate().fadeIn(delay: 300.ms),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 330,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
                  itemCount: donationItems.length,
                  itemBuilder: (ctx, i) => FoodItemCard(item: donationItems[i]),
                ),
              ).animate().fadeIn(delay: 350.ms),
            ),
          ],

          // ── AI Recommendation Banner ──
          SliverToBoxAdapter(
            child: _buildAIBanner().animate().fadeIn(delay: 400.ms),
          ),

          // ── Fresh Local Produce ──
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 28),
                SectionHeader(
                  title: '🥦 Fresh Local Produce',
                  actionLabel: 'See all',
                  onAction: () {},
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Harvested today and yesterday from farms near you',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ),
              ],
            ).animate().fadeIn(delay: 450.ms),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 330,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
                itemCount: freshItems.length,
                itemBuilder: (ctx, i) => FoodItemCard(item: freshItems[i]),
              ),
            ).animate().fadeIn(delay: 500.ms),
          ),

          // ── Trending Section ──
          SliverToBoxAdapter(
            child: _buildTrendingSection().animate().fadeIn(delay: 550.ms),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 56, 20, 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFECFDF5), Color(0xFFF8FAFC)],
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good Morning, Pardhu 👋',
                  style: GoogleFonts.outfit(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.textPrimary,
                    letterSpacing: -0.3,
                  ),
                ).animate().fadeIn(delay: 50.ms).slideY(begin: -0.1),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on_rounded,
                        size: 14, color: AppTheme.primary),
                    const SizedBox(width: 4),
                    Text(
                      'Hyderabad, Telangana',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: AppTheme.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ).animate().fadeIn(delay: 100.ms),
              ],
            ),
          ),
          // Notification + Avatar
          Stack(
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppTheme.surface,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: AppTheme.shadowSmall,
                    border: Border.all(color: AppTheme.divider),
                  ),
                  child: const Icon(Icons.notifications_outlined,
                      color: AppTheme.textSecondary, size: 22),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 9,
                  height: 9,
                  decoration: BoxDecoration(
                    color: AppTheme.error,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                ),
              ),
            ],
          ).animate().fadeIn(delay: 100.ms),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: AppTheme.shadowSmall,
          border: Border.all(color: AppTheme.border),
        ),
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search vegetables, fruits, farms…',
            hintStyle: GoogleFonts.inter(
                color: AppTheme.textTertiary, fontSize: 14),
            prefixIcon: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Icon(Icons.search_rounded,
                  color: AppTheme.primary, size: 22),
            ),
            prefixIconConstraints:
                const BoxConstraints(minWidth: 50, minHeight: 50),
            suffixIcon: Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: AppTheme.gradientPrimary,
                borderRadius: BorderRadius.circular(10),
              ),
              child:
                  const Icon(Icons.tune_rounded, color: Colors.white, size: 18),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.transparent,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      ),
    );
  }

  Widget _buildPromoBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Container(
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppTheme.radiusXL),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xFF065F46), Color(0xFF10B981)],
          ),
          boxShadow: AppTheme.shadowPrimary,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Circles
            Positioned(
              right: -20,
              top: -20,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.08),
                ),
              ),
            ),
            Positioned(
              right: 30,
              bottom: -30,
              child: Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.06),
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'LIMITED OFFER',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Get 20% off your\nfirst order 🌱',
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Use code FRESH20',
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            // Right emoji
            Positioned(
              right: 20,
              top: 0,
              bottom: 0,
              child: const Center(
                child: Text('🥗', style: TextStyle(fontSize: 52)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
        itemCount: _categories.length,
        itemBuilder: (ctx, i) {
          final cat = _categories[i];
          final isSelected = _selectedCategory == cat;
          return GestureDetector(
            onTap: () => setState(() => _selectedCategory = cat),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 10),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
              decoration: BoxDecoration(
                gradient: isSelected ? AppTheme.gradientPrimary : null,
                color: isSelected ? null : AppTheme.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? Colors.transparent : AppTheme.border,
                ),
                boxShadow: isSelected ? AppTheme.shadowPrimary.map((s) =>
                    BoxShadow(color: s.color.withValues(alpha: 0.15), blurRadius: s.blurRadius, offset: s.offset)).toList() : null,
              ),
              child: Text(
                cat,
                style: GoogleFonts.inter(
                  color: isSelected ? Colors.white : AppTheme.textSecondary,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFarmerChip(Map<String, dynamic> farmer, int index) {
    final colors = [
      AppTheme.primary,
      AppTheme.info,
      AppTheme.accent,
      AppTheme.error,
      AppTheme.primaryDark,
    ];
    final color = colors[index % colors.length];

    return Container(
      width: 90,
      margin: const EdgeInsets.only(right: 14),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color.withValues(alpha: 0.8), color],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                farmer['initials'],
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            farmer['name'],
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            farmer['distance'],
            style: GoogleFonts.inter(
              fontSize: 10,
              color: AppTheme.textTertiary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAIBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppTheme.radiusXL),
          border: Border.all(color: AppTheme.border),
          color: AppTheme.surface,
          boxShadow: AppTheme.shadowSmall,
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF7C3AED), Color(0xFF6D28D9)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Center(
                child: Text('🤖', style: TextStyle(fontSize: 28)),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'AI Recommendation',
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEDE9FE),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'AI',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF7C3AED),
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Tomatoes are 23% cheaper than last week. Great time to stock up!',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: AppTheme.textSecondary,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            const Icon(Icons.arrow_forward_ios_rounded,
                size: 14, color: AppTheme.textTertiary),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendingSection() {
    final trending = [
      {'name': 'Tomatoes', 'trend': '+23%', 'emoji': '🍅', 'up': true},
      {'name': 'Spinach', 'trend': '+18%', 'emoji': '🥬', 'up': true},
      {'name': 'Potatoes', 'trend': '-5%', 'emoji': '🥔', 'up': false},
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: '📈 Trending Produce',
            actionLabel: 'View all',
            onAction: () {},
          ),
          const SizedBox(height: 12),
          ...trending.map((item) => Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                  border: Border.all(color: AppTheme.divider),
                  boxShadow: AppTheme.shadowSmall,
                ),
                child: Row(
                  children: [
                    Text(item['emoji'] as String,
                        style: const TextStyle(fontSize: 28)),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['name'] as String,
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          Text(
                            'High demand this week',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: (item['up'] as bool)
                            ? AppTheme.successSubtle
                            : AppTheme.errorSubtle,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            (item['up'] as bool)
                                ? Icons.trending_up_rounded
                                : Icons.trending_down_rounded,
                            size: 14,
                            color: (item['up'] as bool)
                                ? AppTheme.success
                                : AppTheme.error,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            item['trend'] as String,
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              color: (item['up'] as bool)
                                  ? AppTheme.success
                                  : AppTheme.error,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
