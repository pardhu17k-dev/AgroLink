import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/food_provider.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';
import 'map_screen.dart';
import 'orders_screen.dart';
import 'payment_screen.dart';
import 'profile_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;
  final Set<int> _visitedTabs = {0};

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const MapScreen();
      case 2:
        return const OrdersScreen();
      case 3:
        return const ProfileScreen();
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartCount = context.watch<FoodProvider>().cart.length;

    return Scaffold(
      body: Stack(
        children: [
          // Pages
          IndexedStack(
            index: _currentIndex,
            children: List.generate(4, (i) {
              if (_visitedTabs.contains(i)) return _buildPage(i);
              return const SizedBox.shrink();
            }),
          ),
        ],
      ),

      // ── Floating Cart Button ──
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, animation, _) => const PaymentScreen(),
                    transitionsBuilder: (_, animation, _, child) =>
                        SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 1),
                        end: Offset.zero,
                      ).animate(CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeOutCubic,
                      )),
                      child: child,
                    ),
                    transitionDuration: const Duration(milliseconds: 350),
                  ),
                );
              },
              backgroundColor: AppTheme.primary,
              elevation: 4,
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(Icons.shopping_cart_rounded,
                      color: Colors.white, size: 22),
                  if (cartCount > 0)
                    Positioned(
                      top: -6,
                      right: -6,
                      child: Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          color: AppTheme.error,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                        child: Center(
                          child: Text(
                            '$cartCount',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ).animate(target: cartCount > 0 ? 1 : 0)
                          .scale(duration: 300.ms, curve: Curves.elasticOut),
                    ),
                ],
              ),
              label: Text(
                cartCount > 0 ? 'Cart ($cartCount)' : 'Cart',
                style: GoogleFonts.outfit(
                    color: Colors.white, fontWeight: FontWeight.w700),
              ),
            ).animate().scale(duration: 300.ms, curve: Curves.easeOutBack)
          : null,

      // ── Bottom Nav ──
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppTheme.surface,
          border: const Border(top: BorderSide(color: AppTheme.divider)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _navItem(0, Icons.home_outlined, Icons.home_rounded, 'Home'),
                _navItem(1, Icons.map_outlined, Icons.map_rounded, 'Map'),
                _navItem(
                  2,
                  Icons.receipt_long_outlined,
                  Icons.receipt_long_rounded,
                  'Orders',
                  badge: context.watch<FoodProvider>().orders.length,
                ),
                _navItem(3, Icons.person_outline_rounded,
                    Icons.person_rounded, 'Profile'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem(
    int index,
    IconData outlinedIcon,
    IconData filledIcon,
    String label, {
    int badge = 0,
  }) {
    final isActive = _currentIndex == index;

    return GestureDetector(
      onTap: () => setState(() {
        _visitedTabs.add(index);
        _currentIndex = index;
      }),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: EdgeInsets.symmetric(
          horizontal: isActive ? 20 : 16,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: isActive
              ? AppTheme.primary.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  isActive ? filledIcon : outlinedIcon,
                  color: isActive ? AppTheme.primary : AppTheme.textTertiary,
                  size: 24,
                ),
                if (badge > 0)
                  Positioned(
                    top: -4,
                    right: -6,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: AppTheme.error,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                      child: Center(
                        child: Text(
                          '$badge',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            if (isActive) ...[
              const SizedBox(width: 6),
              Text(
                label,
                style: GoogleFonts.outfit(
                  color: AppTheme.primary,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
