import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/food_provider.dart';
import '../models/food_item.dart';
import '../theme/app_theme.dart';
import '../widgets/app_widgets.dart';

class FoodDetailsScreen extends StatefulWidget {
  final FoodItem item;
  const FoodDetailsScreen({super.key, required this.item});

  @override
  State<FoodDetailsScreen> createState() => _FoodDetailsScreenState();
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  int _quantity = 1;
  bool _isWishlisted = false;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: CustomScrollView(
        slivers: [
          // ── App Bar with Image ──
          SliverAppBar(
            expandedHeight: 320,
            pinned: true,
            backgroundColor: AppTheme.surface,
            elevation: 0,
            iconTheme: const IconThemeData(color: AppTheme.textPrimary),
            actions: [
              GestureDetector(
                onTap: () => setState(() => _isWishlisted = !_isWishlisted),
                child: Container(
                  margin: const EdgeInsets.only(right: 4),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppTheme.surface.withValues(alpha: 0.9),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _isWishlisted
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    color: _isWishlisted ? AppTheme.error : AppTheme.textSecondary,
                    size: 22,
                  ),
                )
                    .animate(target: _isWishlisted ? 1 : 0)
                    .scale(
                        begin: const Offset(1, 1),
                        end: const Offset(1.2, 1.2),
                        duration: 150.ms)
                    .then()
                    .scale(
                        begin: const Offset(1.2, 1.2),
                        end: const Offset(1, 1),
                        duration: 150.ms),
              ),
              Container(
                margin: const EdgeInsets.only(right: 16),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.surface.withValues(alpha: 0.9),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.share_rounded,
                    color: AppTheme.textSecondary, size: 22),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'food-image-${item.id}',
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      item.imageUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (ctx, child, progress) => progress == null
                          ? child
                          : const SkeletonLoader(
                              width: double.infinity,
                              height: 320,
                              borderRadius: 0,
                            ),
                      errorBuilder: (ctx, _, _) => Container(
                        color: AppTheme.surfaceElevated,
                        child: const Icon(Icons.image_not_supported_outlined,
                            color: AppTheme.textTertiary, size: 64),
                      ),
                    ),
                    // Bottom gradient
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [0.5, 1.0],
                          colors: [
                            Colors.transparent,
                            AppTheme.background,
                          ],
                        ),
                      ),
                    ),
                    // Badges overlay
                    Positioned(
                      bottom: 20,
                      left: 20,
                      child: Row(
                        children: [
                          if (item.isOrganic)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppTheme.primary,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.eco_rounded,
                                      size: 12, color: Colors.white),
                                  const SizedBox(width: 5),
                                  Text(
                                    'ORGANIC',
                                    style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 0.5),
                                  ),
                                ],
                              ),
                            ),
                          if (item.isDonation) ...[
                            if (item.isOrganic) const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppTheme.accent,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.favorite_rounded,
                                      size: 12, color: Colors.white),
                                  const SizedBox(width: 5),
                                  Text(
                                    'FREE DONATION',
                                    style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── Main Content ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Title + Price ──
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          style: GoogleFonts.outfit(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.textPrimary,
                            height: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            item.isDonation
                                ? 'FREE'
                                : '₹${item.price.toStringAsFixed(0)}',
                            style: GoogleFonts.outfit(
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              color: item.isDonation
                                  ? AppTheme.accent
                                  : AppTheme.primary,
                            ),
                          ),
                          if (!item.isDonation)
                            Text(
                              'per ${item.unit}',
                              style: GoogleFonts.inter(
                                  fontSize: 12, color: AppTheme.textSecondary),
                            ),
                          if (item.originalPrice != null && !item.isDonation)
                            Text(
                              '₹${item.originalPrice!.toStringAsFixed(0)}',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                color: AppTheme.textTertiary,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // ── Rating + Location ──
                  Row(
                    children: [
                      RatingRow(
                          rating: item.rating, reviewCount: item.reviewCount),
                      const SizedBox(width: 16),
                      const Icon(Icons.location_on_rounded,
                          size: 14, color: AppTheme.textSecondary),
                      const SizedBox(width: 4),
                      Text(
                        item.location,
                        style: GoogleFonts.inter(
                            fontSize: 13, color: AppTheme.textSecondary),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // ── Farmer Card ──
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.surface,
                      borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                      border: Border.all(color: AppTheme.divider),
                      boxShadow: AppTheme.shadowSmall,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            gradient: AppTheme.gradientPrimary,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              item.farmerAvatar.isNotEmpty
                                  ? item.farmerAvatar
                                  : item.farmerName[0],
                              style: GoogleFonts.outfit(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.farmerName,
                                style: GoogleFonts.outfit(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.verified_rounded,
                                      size: 13, color: AppTheme.primary),
                                  const SizedBox(width: 4),
                                  Text(
                                    'Verified Producer',
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: AppTheme.primary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text('Follow',
                              style: GoogleFonts.outfit(
                                  fontWeight: FontWeight.w600, fontSize: 13)),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ── Info Grid ──
                  Row(
                    children: [
                      InfoRowTile(
                        icon: Icons.location_on_rounded,
                        label: 'Distance',
                        value: item.location,
                      ),
                      const SizedBox(width: 12),
                      InfoRowTile(
                        icon: Icons.hourglass_bottom_rounded,
                        label: 'Expires in',
                        value: item.expiryDate,
                        iconColor: AppTheme.warning,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      InfoRowTile(
                        icon: Icons.scale_rounded,
                        label: 'Available',
                        value: '${item.quantity} ${item.unit}',
                      ),
                      const SizedBox(width: 12),
                      InfoRowTile(
                        icon: Icons.calendar_today_rounded,
                        label: 'Harvested',
                        value: item.harvestDate,
                        iconColor: AppTheme.success,
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // ── Freshness Score ──
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.surface,
                      borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                      border: Border.all(color: AppTheme.divider),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '🌿 Freshness Score',
                              style: GoogleFonts.outfit(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            Text(
                              '${item.freshnessDays} days fresh',
                              style: GoogleFonts.outfit(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: item.freshnessDays > 5
                                    ? AppTheme.success
                                    : item.freshnessDays > 2
                                        ? AppTheme.warning
                                        : AppTheme.error,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: LinearProgressIndicator(
                            value: (item.freshnessDays / 10).clamp(0.0, 1.0),
                            backgroundColor: AppTheme.surfaceElevated,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              item.freshnessDays > 5
                                  ? AppTheme.success
                                  : item.freshnessDays > 2
                                      ? AppTheme.warning
                                      : AppTheme.error,
                            ),
                            minHeight: 10,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item.freshnessDays > 5
                              ? 'Excellent freshness — harvested very recently'
                              : item.freshnessDays > 2
                                  ? 'Good — best consumed within ${item.freshnessDays} days'
                                  : 'Use soon — expires in ${item.freshnessDays} days!',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ── Description ──
                  Text(
                    'About this Product',
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    item.description,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      color: AppTheme.textSecondary,
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ── Nutrition ──
                  Text(
                    '🥗 Nutrition Info (per 100g)',
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.surface,
                      borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                      border: Border.all(color: AppTheme.divider),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _nutritionItem('18', 'Calories', 'kcal'),
                        _nutritionItem('1.2g', 'Protein', ''),
                        _nutritionItem('3.5g', 'Fiber', ''),
                        _nutritionItem('A,C,K', 'Vitamins', ''),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ── AI Recommendation ──
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDE9FE),
                      borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                      border: Border.all(
                          color: const Color(0xFFDDD6FE)),
                    ),
                    child: Row(
                      children: [
                        const Text('🤖', style: TextStyle(fontSize: 28)),
                        const SizedBox(width: 12),
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
                                      color: const Color(0xFF5B21B6),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF7C3AED),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      'AI',
                                      style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontSize: 9,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Great for salads, pasta sauce, and fresh juices. Pairs well with organic spinach from Metro Greenhouses.',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: const Color(0xFF5B21B6),
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ── Delivery Estimate ──
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: AppTheme.primarySubtle,
                            borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.local_shipping_rounded,
                                  color: AppTheme.primary, size: 22),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Est. Delivery',
                                    style: GoogleFonts.inter(
                                        fontSize: 11, color: AppTheme.primaryDark),
                                  ),
                                  Text(
                                    'Today, 4–6 PM',
                                    style: GoogleFonts.outfit(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13,
                                      color: AppTheme.primaryDark,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: AppTheme.accentSubtle,
                            borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.access_time_rounded,
                                  color: AppTheme.accent, size: 22),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Delivery Fee',
                                    style: GoogleFonts.inter(
                                        fontSize: 11, color: AppTheme.accent),
                                  ),
                                  Text(
                                    '₹49 only',
                                    style: GoogleFonts.outfit(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13,
                                      color: AppTheme.accent,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 120),
                ],
              ),
            ).animate().fadeIn(delay: 100.ms),
          ),
        ],
      ),

      // ── Bottom Bar ──
      bottomSheet: Container(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          border: const Border(top: BorderSide(color: AppTheme.divider)),
          boxShadow: AppTheme.shadowLarge,
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Quantity selector
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Quantity',
                        style: GoogleFonts.inter(
                            fontSize: 12, color: AppTheme.textSecondary),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Max: ${widget.item.quantity.toInt()} ${widget.item.unit}',
                        style: GoogleFonts.inter(
                            fontSize: 11, color: AppTheme.textTertiary),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppTheme.border),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_rounded,
                              color: AppTheme.primary, size: 18),
                          onPressed: _quantity > 1
                              ? () => setState(() => _quantity--)
                              : null,
                          constraints: const BoxConstraints(
                              minWidth: 40, minHeight: 40),
                        ),
                        SizedBox(
                          width: 36,
                          child: Text(
                            '$_quantity',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.outfit(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add_rounded,
                              color: AppTheme.primary, size: 18),
                          onPressed: _quantity < widget.item.quantity
                              ? () => setState(() => _quantity++)
                              : null,
                          constraints: const BoxConstraints(
                              minWidth: 40, minHeight: 40),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              GradientButton(
                label: widget.item.isDonation
                    ? 'Request $_quantity ${widget.item.unit}'
                    : 'Add to Cart • ₹${(widget.item.price * _quantity).toStringAsFixed(0)}',
                icon: widget.item.isDonation
                    ? Icons.volunteer_activism_rounded
                    : Icons.shopping_cart_rounded,
                onPressed: () {
                  context
                      .read<FoodProvider>()
                      .addToCart(widget.item, quantity: _quantity);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        widget.item.isDonation
                            ? '✅  Added $_quantity ${widget.item.unit} donation to cart!'
                            : '✅  Added $_quantity ${widget.item.unit} to cart!',
                        style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _nutritionItem(String value, String label, String unit) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: AppTheme.primary,
          ),
        ),
        if (unit.isNotEmpty)
          Text(
            unit,
            style: GoogleFonts.inter(fontSize: 10, color: AppTheme.textTertiary),
          ),
        const SizedBox(height: 2),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 11,
            color: AppTheme.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
