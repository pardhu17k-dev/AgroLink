import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

// ─── APP BUTTON ───────────────────────────────────────────────────────────────
enum AppButtonVariant { primary, secondary, danger, ghost }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final IconData? icon;
  final bool isLoading;
  final bool fullWidth;
  final double? height;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.icon,
    this.isLoading = false,
    this.fullWidth = false,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final child = isLoading
        ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18),
                const SizedBox(width: 8),
              ],
              Text(label),
            ],
          );

    Widget button;
    switch (variant) {
      case AppButtonVariant.primary:
        button = ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          child: child,
        );
        break;
      case AppButtonVariant.secondary:
        button = OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          child: child,
        );
        break;
      case AppButtonVariant.danger:
        button = ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.error,
            foregroundColor: Colors.white,
          ),
          child: child,
        );
        break;
      case AppButtonVariant.ghost:
        button = TextButton(
          onPressed: isLoading ? null : onPressed,
          child: child,
        );
        break;
    }

    if (fullWidth) {
      return SizedBox(
        width: double.infinity,
        height: height ?? 52,
        child: button,
      );
    }
    if (height != null) {
      return SizedBox(height: height, child: button);
    }
    return button;
  }
}

// ─── GRADIENT BUTTON ─────────────────────────────────────────────────────────
class GradientButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final LinearGradient? gradient;
  final double height;

  const GradientButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.gradient,
    this.height = 56,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: gradient ?? AppTheme.gradientPrimary,
          borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
          boxShadow: AppTheme.shadowPrimary,
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: Colors.white,
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon != null) ...[
                      Icon(icon, color: Colors.white, size: 20),
                      const SizedBox(width: 10),
                    ],
                    Text(
                      label,
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

// ─── APP BADGE ────────────────────────────────────────────────────────────────
enum AppBadgeVariant {
  success,
  warning,
  error,
  info,
  primary,
  secondary,
  neutral,
}

class AppBadge extends StatelessWidget {
  final String label;
  final AppBadgeVariant variant;
  final IconData? icon;

  const AppBadge({
    super.key,
    required this.label,
    this.variant = AppBadgeVariant.primary,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;

    switch (variant) {
      case AppBadgeVariant.success:
        bg = AppTheme.successSubtle;
        fg = AppTheme.success;
        break;
      case AppBadgeVariant.warning:
        bg = AppTheme.warningSubtle;
        fg = AppTheme.warning;
        break;
      case AppBadgeVariant.error:
        bg = AppTheme.errorSubtle;
        fg = AppTheme.error;
        break;
      case AppBadgeVariant.info:
        bg = AppTheme.infoSubtle;
        fg = AppTheme.info;
        break;
      case AppBadgeVariant.primary:
        bg = AppTheme.primarySubtle;
        fg = AppTheme.primaryDark;
        break;
      case AppBadgeVariant.secondary:
        bg = AppTheme.accentSubtle;
        fg = AppTheme.accent;
        break;
      case AppBadgeVariant.neutral:
        bg = AppTheme.surfaceElevated;
        fg = AppTheme.textSecondary;
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: icon != null ? 8 : 10,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: fg),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: GoogleFonts.inter(
              color: fg,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── APP CARD ─────────────────────────────────────────────────────────────────
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final Color? color;
  final List<BoxShadow>? shadow;
  final BorderRadius? borderRadius;
  final Border? border;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.color,
    this.shadow,
    this.borderRadius,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color ?? AppTheme.surface,
          borderRadius: borderRadius ?? BorderRadius.circular(AppTheme.radiusXL),
          boxShadow: shadow ?? AppTheme.shadowSmall,
          border: border ?? Border.all(color: AppTheme.divider),
        ),
        child: child,
      ),
    );
  }
}

// ─── STAT CARD ────────────────────────────────────────────────────────────────
class StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final String? trend; // e.g. "+12%"
  final bool trendPositive;

  const StatCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    this.trend,
    this.trendPositive = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusXL),
        boxShadow: AppTheme.shadowSmall,
        border: Border.all(color: AppTheme.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              if (trend != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: trendPositive
                        ? AppTheme.successSubtle
                        : AppTheme.errorSubtle,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        trendPositive
                            ? Icons.arrow_upward_rounded
                            : Icons.arrow_downward_rounded,
                        size: 11,
                        color: trendPositive ? AppTheme.success : AppTheme.error,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        trend!,
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color:
                              trendPositive ? AppTheme.success : AppTheme.error,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            value,
            style: GoogleFonts.outfit(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: AppTheme.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── SECTION HEADER ───────────────────────────────────────────────────────────
class SectionHeader extends StatelessWidget {
  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  const SectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.outfit(
              fontSize: 19,
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimary,
            ),
          ),
          if (actionLabel != null)
            GestureDetector(
              onTap: onAction,
              child: Row(
                children: [
                  Text(
                    actionLabel!,
                    style: GoogleFonts.inter(
                      color: AppTheme.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(width: 2),
                  const Icon(Icons.arrow_forward_ios_rounded,
                      size: 12, color: AppTheme.primary),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// ─── EMPTY STATE ─────────────────────────────────────────────────────────────
class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;

  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: AppTheme.primarySubtle,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 44, color: AppTheme.primary),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: GoogleFonts.outfit(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: AppTheme.textSecondary,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            if (actionLabel != null) ...[
              const SizedBox(height: 24),
              AppButton(
                label: actionLabel!,
                onPressed: onAction,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ─── SKELETON LOADER ─────────────────────────────────────────────────────────
class SkeletonLoader extends StatefulWidget {
  final double width;
  final double height;
  final double borderRadius;

  const SkeletonLoader({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 8,
  });

  @override
  State<SkeletonLoader> createState() => _SkeletonLoaderState();
}

class _SkeletonLoaderState extends State<SkeletonLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat(reverse: true);
    _animation =
        Tween<double>(begin: 0.4, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, _) => Opacity(
        opacity: _animation.value,
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: AppTheme.surfaceElevated,
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
        ),
      ),
    );
  }
}

// ─── INFO ROW TILE ────────────────────────────────────────────────────────────
class InfoRowTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? iconColor;

  const InfoRowTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.primary.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
          border: Border.all(color: AppTheme.primary.withValues(alpha: 0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: iconColor ?? AppTheme.primary, size: 22),
            const SizedBox(height: 10),
            Text(
              label,
              style: GoogleFonts.inter(
                color: AppTheme.textSecondary,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              value,
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: AppTheme.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── RATING ROW ───────────────────────────────────────────────────────────────
class RatingRow extends StatelessWidget {
  final double rating;
  final int reviewCount;
  final double starSize;

  const RatingRow({
    super.key,
    required this.rating,
    required this.reviewCount,
    this.starSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    final fullStars = rating.floor();
    final hasHalfStar = (rating - fullStars) >= 0.5;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(5, (i) {
          if (i < fullStars) {
            return Icon(Icons.star_rounded, size: starSize, color: AppTheme.accent);
          } else if (i == fullStars && hasHalfStar) {
            return Icon(Icons.star_half_rounded, size: starSize, color: AppTheme.accent);
          } else {
            return Icon(Icons.star_outline_rounded,
                size: starSize, color: AppTheme.textTertiary);
          }
        }),
        const SizedBox(width: 6),
        Text(
          rating.toStringAsFixed(1),
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w700,
            fontSize: starSize - 1,
            color: AppTheme.textPrimary,
          ),
        ),
        if (reviewCount > 0) ...[
          const SizedBox(width: 4),
          Text(
            '($reviewCount)',
            style: GoogleFonts.inter(
              fontSize: starSize - 2,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ],
    );
  }
}

// ─── DIVIDER WITH LABEL ──────────────────────────────────────────────────────
class LabeledDivider extends StatelessWidget {
  final String label;

  const LabeledDivider({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppTheme.border)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            label,
            style: GoogleFonts.inter(
              color: AppTheme.textTertiary,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const Expanded(child: Divider(color: AppTheme.border)),
      ],
    );
  }
}
