import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/food_item.dart';
import '../theme/app_theme.dart';
import '../screens/food_details_screen.dart';
import 'app_widgets.dart';

class FoodItemCard extends StatefulWidget {
  final FoodItem item;

  const FoodItemCard({super.key, required this.item});

  @override
  State<FoodItemCard> createState() => _FoodItemCardState();
}

class _FoodItemCardState extends State<FoodItemCard> {
  bool _isWishlisted = false;

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final hasDiscount = item.originalPrice != null && item.originalPrice! > item.price && !item.isDonation;
    final discountPct = hasDiscount ? item.discountPercent.round() : 0;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (_, animation, _) => FoodDetailsScreen(item: item),
            transitionsBuilder: (_, animation, _, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 300),
          ),
        );
      },
      child: Container(
        width: 210,
        margin: const EdgeInsets.only(right: 16, bottom: 4, top: 4),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(AppTheme.radiusXL),
          boxShadow: AppTheme.shadowMedium,
          border: Border.all(color: AppTheme.divider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Image ──
            Stack(
              children: [
                Hero(
                  tag: 'food-image-${item.id}',
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(AppTheme.radiusXL),
                    ),
                    child: Image.network(
                      item.imageUrl,
                      height: 148,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (ctx, child, progress) => progress == null
                          ? child
                          : const SkeletonLoader(
                              width: double.infinity,
                              height: 148,
                              borderRadius: 0,
                            ),
                      errorBuilder: (ctx, _, _) => Container(
                        height: 148,
                        color: AppTheme.surfaceElevated,
                        child: const Icon(Icons.image_not_supported_outlined,
                            color: AppTheme.textTertiary, size: 40),
                      ),
                    ),
                  ),
                ),

                // Gradient overlay
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.45),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                // Top-left: Badges
                Positioned(
                  top: 10,
                  left: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (item.isDonation)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 9, vertical: 5),
                          decoration: BoxDecoration(
                            gradient: AppTheme.gradientAccent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.favorite_rounded,
                                  size: 11, color: Colors.white),
                              const SizedBox(width: 4),
                              Text(
                                'FREE',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (item.isOrganic) ...[
                        if (item.isDonation) const SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppTheme.success,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.eco_rounded,
                                  size: 10, color: Colors.white),
                              const SizedBox(width: 3),
                              Text(
                                'ORGANIC',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      if (hasDiscount && discountPct > 0) ...[
                        if (item.isOrganic || item.isDonation)
                          const SizedBox(height: 5),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppTheme.error,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '-$discountPct%',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Top-right: Wishlist
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () => setState(() => _isWishlisted = !_isWishlisted),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: _isWishlisted
                            ? AppTheme.error.withValues(alpha: 0.15)
                            : Colors.white.withValues(alpha: 0.88),
                        shape: BoxShape.circle,
                        boxShadow: AppTheme.shadowSmall,
                      ),
                      child: Icon(
                        _isWishlisted
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        size: 16,
                        color: _isWishlisted ? AppTheme.error : AppTheme.textSecondary,
                      ),
                    )
                        .animate(target: _isWishlisted ? 1 : 0)
                        .scale(begin: const Offset(1, 1), end: const Offset(1.2, 1.2), duration: 150.ms)
                        .then()
                        .scale(begin: const Offset(1.2, 1.2), end: const Offset(1, 1), duration: 150.ms),
                  ),
                ),

                // Bottom-left: Rating
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Row(
                    children: [
                      const Icon(Icons.star_rounded,
                          size: 13, color: AppTheme.accent),
                      const SizedBox(width: 3),
                      Text(
                        item.rating.toStringAsFixed(1),
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),

                // Bottom-right: Distance
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: Row(
                    children: [
                      const Icon(Icons.location_on_rounded,
                          size: 11, color: Colors.white70),
                      const SizedBox(width: 2),
                      Text(
                        item.location.replaceAll(' away', ''),
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // ── Details ──
            Padding(
              padding: const EdgeInsets.fromLTRB(13, 12, 13, 13),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: AppTheme.textPrimary,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Farmer
                  Row(
                    children: [
                      Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          gradient: AppTheme.gradientPrimary,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            item.farmerAvatar.isNotEmpty
                                ? item.farmerAvatar[0]
                                : item.farmerName[0],
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          item.farmerName,
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            color: AppTheme.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Freshness progress bar
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Freshness',
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              color: AppTheme.textTertiary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '${item.freshnessDays}d left',
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              color: item.freshnessDays <= 2
                                  ? AppTheme.error
                                  : item.freshnessDays <= 4
                                      ? AppTheme.warning
                                      : AppTheme.success,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: (item.freshnessDays / 10).clamp(0.0, 1.0),
                          backgroundColor: AppTheme.surfaceElevated,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            item.freshnessDays <= 2
                                ? AppTheme.error
                                : item.freshnessDays <= 4
                                    ? AppTheme.warning
                                    : AppTheme.primary,
                          ),
                          minHeight: 5,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Price row + Quick Add
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.isDonation
                                ? 'Free'
                                : '₹${item.price.toStringAsFixed(0)}',
                            style: GoogleFonts.outfit(
                              color: item.isDonation
                                  ? AppTheme.accent
                                  : AppTheme.primary,
                              fontSize: 17,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          if (hasDiscount)
                            Text(
                              '₹${item.originalPrice!.toStringAsFixed(0)}',
                              style: GoogleFonts.inter(
                                color: AppTheme.textTertiary,
                                fontSize: 11,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => FoodDetailsScreen(item: item),
                            ),
                          );
                        },
                        child: Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            gradient: AppTheme.gradientPrimary,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: AppTheme.shadowPrimary.map((s) =>
                                BoxShadow(
                                  color: s.color.withValues(alpha: 0.2),
                                  blurRadius: s.blurRadius,
                                  offset: s.offset,
                                )).toList(),
                          ),
                          child: const Icon(Icons.add_rounded,
                              color: Colors.white, size: 20),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
