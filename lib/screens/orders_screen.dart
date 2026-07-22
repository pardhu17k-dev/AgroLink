import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/food_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/app_widgets.dart';
import 'chat_screen.dart';
import 'route_map_screen.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orders = context.watch<FoodProvider>().orders;

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110),
        child: Container(
          color: AppTheme.surface,
          child: SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                  child: Text(
                    'My Orders',
                    style: GoogleFonts.outfit(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ),
                TabBar(
                  controller: _tabController,
                  labelColor: AppTheme.primary,
                  unselectedLabelColor: AppTheme.textSecondary,
                  labelStyle: GoogleFonts.outfit(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                  unselectedLabelStyle: GoogleFonts.outfit(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  indicatorColor: AppTheme.primary,
                  indicatorWeight: 3,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: [
                    Tab(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Active'),
                          const SizedBox(width: 6),
                          if (orders.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppTheme.primary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '${orders.length}',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const Tab(text: 'Completed'),
                    const Tab(text: 'Cancelled'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Active orders
          orders.isEmpty
              ? const EmptyState(
                  icon: Icons.receipt_long_outlined,
                  title: 'No Active Orders',
                  subtitle:
                      'When you place an order, it will appear here.\nStart shopping to see your orders!',
                  actionLabel: 'Browse Products',
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(20),
                  physics: const BouncingScrollPhysics(),
                  itemCount: orders.length,
                  itemBuilder: (ctx, i) =>
                      _buildOrderCard(orders[i], ctx, i).animate()
                          .fadeIn(delay: Duration(milliseconds: 80 * i))
                          .slideY(begin: 0.15),
                ),
          // Completed
          EmptyState(
            icon: Icons.check_circle_outline_rounded,
            title: 'No Completed Orders',
            subtitle: 'Your completed deliveries will appear here.',
            actionLabel: 'View Active Orders',
            onAction: () => _tabController.animateTo(0),
          ),
          // Cancelled
          EmptyState(
            icon: Icons.cancel_outlined,
            title: 'No Cancelled Orders',
            subtitle: 'Any cancelled orders will appear here.',
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(
      Map<String, dynamic> order, BuildContext ctx, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusXL),
        border: Border.all(color: AppTheme.divider),
        boxShadow: AppTheme.shadowSmall,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──
          Container(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
            decoration: BoxDecoration(
              color: AppTheme.primarySubtle,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(AppTheme.radiusXL)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.receipt_long_rounded,
                        size: 18, color: AppTheme.primaryDark),
                    const SizedBox(width: 8),
                    Text(
                      order['id'],
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: AppTheme.primaryDark,
                      ),
                    ),
                  ],
                ),
                AppBadge(
                  label: order['status'],
                  variant: AppBadgeVariant.warning,
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Items summary
                Text(
                  '${(order['items'] as List).length} item${(order['items'] as List).length > 1 ? 's' : ''} • ₹${(order['total'] as double).toStringAsFixed(0)}',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: AppTheme.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  'Farmer: Green Valley Farm',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AppTheme.textTertiary,
                  ),
                ),

                const SizedBox(height: 18),

                // ── Order Timeline ──
                _buildTimeline(order['status']),

                const SizedBox(height: 18),

                // Divider
                const Divider(color: AppTheme.divider, height: 1),
                const SizedBox(height: 14),

                // ── Action Buttons ──
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            ctx,
                            MaterialPageRoute(
                              builder: (_) => ChatScreen(
                                orderId: order['id'],
                                otherUserName: 'Farmer',
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.chat_bubble_outline_rounded,
                            size: 16),
                        label: Text('Chat',
                            style: GoogleFonts.outfit(fontWeight: FontWeight.w600)),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 11),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            ctx,
                            MaterialPageRoute(
                              builder: (_) => const RouteMapScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.location_on_rounded,
                            size: 16, color: Colors.white),
                        label: Text(
                          'Track Order',
                          style: GoogleFonts.outfit(
                              fontWeight: FontWeight.w600, color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 11),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline(String status) {
    final steps = [
      {'label': 'Requested', 'icon': Icons.add_circle_outline_rounded},
      {'label': 'Approved', 'icon': Icons.verified_outlined},
      {'label': 'Packed', 'icon': Icons.inventory_2_outlined},
      {'label': 'On Way', 'icon': Icons.local_shipping_outlined},
    ];

    // Active step index based on status
    int activeIndex = 0;
    if (status == 'Approved') activeIndex = 1;
    if (status == 'Packed') activeIndex = 2;
    if (status == 'Delivered') activeIndex = 3;

    return Row(
      children: List.generate(steps.length * 2 - 1, (i) {
        if (i.isEven) {
          final stepIndex = i ~/ 2;
          final isActive = stepIndex <= activeIndex;
          final isCurrent = stepIndex == activeIndex;
          return Expanded(
            flex: 0,
            child: Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: isActive
                        ? (isCurrent
                            ? AppTheme.primary
                            : AppTheme.primarySubtle)
                        : AppTheme.surfaceElevated,
                    shape: BoxShape.circle,
                    border: isActive
                        ? Border.all(
                            color: AppTheme.primary,
                            width: isCurrent ? 0 : 2,
                          )
                        : null,
                  ),
                  child: Icon(
                    steps[stepIndex]['icon'] as IconData,
                    size: 15,
                    color: isActive
                        ? (isCurrent ? Colors.white : AppTheme.primaryDark)
                        : AppTheme.textTertiary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  steps[stepIndex]['label'] as String,
                  style: GoogleFonts.inter(
                    fontSize: 9,
                    fontWeight:
                        isCurrent ? FontWeight.w700 : FontWeight.w500,
                    color: isActive
                        ? (isCurrent ? AppTheme.primary : AppTheme.primaryDark)
                        : AppTheme.textTertiary,
                  ),
                ),
              ],
            ),
          );
        } else {
          final lineIndex = i ~/ 2;
          final isActive = lineIndex < activeIndex;
          return Expanded(
            child: Container(
              height: 2,
              margin: const EdgeInsets.only(bottom: 18),
              decoration: BoxDecoration(
                color: isActive ? AppTheme.primary : AppTheme.surfaceElevated,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          );
        }
      }),
    );
  }
}
