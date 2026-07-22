import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import '../theme/app_theme.dart';
import '../widgets/app_widgets.dart';
import 'auth_screen.dart';

class FarmerDashboard extends StatefulWidget {
  const FarmerDashboard({super.key});

  @override
  State<FarmerDashboard> createState() => _FarmerDashboardState();
}

class _FarmerDashboardState extends State<FarmerDashboard> {
  int _currentIndex = 0;

  final List<Map<String, dynamic>> _inventory = [
    {'name': 'Tomatoes', 'qty': 50, 'unit': 'kg', 'stock': 0.6, 'emoji': '🍅', 'price': 299},
    {'name': 'Carrots', 'qty': 20, 'unit': 'kg', 'stock': 0.3, 'emoji': '🥕', 'price': 169},
    {'name': 'Spinach', 'qty': 15, 'unit': 'bags', 'stock': 0.85, 'emoji': '🥬', 'price': 89},
    {'name': 'Apples', 'qty': 30, 'unit': 'kg', 'stock': 0.15, 'emoji': '🍎', 'price': 89},
  ];

  final List<Map<String, dynamic>> _orders = [
    {'id': '#1001', 'buyer': 'Rajesh K.', 'item': 'Tomatoes 5kg', 'amount': 1495, 'status': 'Pending'},
    {'id': '#1002', 'buyer': 'Priya S.', 'item': 'Carrots 2kg', 'amount': 338, 'status': 'Accepted'},
    {'id': '#1003', 'buyer': 'Anand M.', 'item': 'Spinach 3 bags', 'amount': 267, 'status': 'Delivered'},
    {'id': '#1004', 'buyer': 'Kavitha R.', 'item': 'Apples 3kg', 'amount': 267, 'status': 'Pending'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: _currentIndex == 0 ? _buildDashboard() : _buildOrdersPage(),
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton.extended(
              onPressed: _showAddProductSheet,
              backgroundColor: AppTheme.primary,
              elevation: 0,
              icon: const Icon(Icons.add_rounded, color: Colors.white),
              label: Text(
                'Add Product',
                style: GoogleFonts.outfit(
                    color: Colors.white, fontWeight: FontWeight.w600),
              ),
            )
          : null,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppTheme.surface,
          border: const Border(top: BorderSide(color: AppTheme.divider)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_outlined),
              activeIcon: Icon(Icons.dashboard_rounded),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_outlined),
              activeIcon: Icon(Icons.receipt_long_rounded),
              label: 'Orders',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboard() {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // ── Header ──
        SliverToBoxAdapter(child: _buildHeader()),

        // ── Stats ──
        SliverToBoxAdapter(
          child: _buildStatsRow().animate().fadeIn(delay: 100.ms),
        ),

        // ── Weather + AI Suggestions ──
        SliverToBoxAdapter(
          child: _buildWeatherAI().animate().fadeIn(delay: 200.ms),
        ),

        // ── Revenue Chart ──
        SliverToBoxAdapter(
          child: _buildRevenueChart().animate().fadeIn(delay: 250.ms),
        ),

        // ── Low Stock Warning ──
        SliverToBoxAdapter(
          child: _buildLowStockBanner().animate().fadeIn(delay: 300.ms),
        ),

        // ── Inventory Health ──
        SliverToBoxAdapter(
          child: _buildInventory().animate().fadeIn(delay: 350.ms),
        ),

        // ── Recent Orders ──
        SliverToBoxAdapter(
          child: _buildRecentOrders().animate().fadeIn(delay: 400.ms),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 56, 20, 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppTheme.primaryDark, AppTheme.primary],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome back 🌾',
                      style: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Green Valley Farm',
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(
                            color: Color(0xFF86EFAC),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'Active',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: const Icon(Icons.logout_rounded, color: Colors.white, size: 22),
                    onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const AuthScreen()),
                      (route) => false,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: StatCard(
                  label: 'Revenue',
                  value: '₹24.8K',
                  icon: Icons.currency_rupee_rounded,
                  color: AppTheme.primary,
                  trend: '12%',
                  trendPositive: true,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: StatCard(
                  label: 'Orders',
                  value: '38',
                  icon: Icons.receipt_long_rounded,
                  color: AppTheme.info,
                  trend: '8%',
                  trendPositive: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: StatCard(
                  label: 'Avg. Price',
                  value: '₹186',
                  icon: Icons.price_change_rounded,
                  color: AppTheme.accent,
                  trend: '3%',
                  trendPositive: false,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: StatCard(
                  label: 'Listings',
                  value: '4',
                  icon: Icons.inventory_2_rounded,
                  color: const Color(0xFF8B5CF6),
                  trend: '2',
                  trendPositive: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherAI() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        children: [
          // Weather card
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(AppTheme.radiusXL),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.info.withValues(alpha: 0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '☀️ Weather',
                    style: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.8), fontSize: 12),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '28°C',
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    'Sunny • Ideal for harvest',
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.75),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 14),
          // AI Price Suggestion
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF7C3AED), Color(0xFF6D28D9)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(AppTheme.radiusXL),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF7C3AED).withValues(alpha: 0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '🤖 AI Pricing',
                    style: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.8), fontSize: 12),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '₹310/kg',
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    'Tomatoes • Set now!',
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.75),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRevenueChart() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppTheme.surface,
          borderRadius: BorderRadius.circular(AppTheme.radiusXL),
          border: Border.all(color: AppTheme.divider),
          boxShadow: AppTheme.shadowSmall,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Revenue Overview',
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    Text(
                      'Last 7 days',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
                AppBadge(
                  label: '+12% this week',
                  variant: AppBadgeVariant.success,
                  icon: Icons.trending_up_rounded,
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 160,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 2000,
                    getDrawingHorizontalLine: (_) => FlLine(
                      color: AppTheme.divider,
                      strokeWidth: 1,
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles:
                        const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles:
                        const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 26,
                        getTitlesWidget: (value, meta) {
                          const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              days[value.toInt()],
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: AppTheme.textTertiary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 38,
                        getTitlesWidget: (value, meta) => Text(
                          '₹${(value / 1000).toStringAsFixed(0)}K',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            color: AppTheme.textTertiary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: const [
                        FlSpot(0, 2800),
                        FlSpot(1, 3200),
                        FlSpot(2, 4100),
                        FlSpot(3, 3700),
                        FlSpot(4, 4800),
                        FlSpot(5, 5200),
                        FlSpot(6, 4600),
                      ],
                      isCurved: true,
                      color: AppTheme.primary,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) =>
                            FlDotCirclePainter(
                          radius: 4,
                          color: AppTheme.primary,
                          strokeWidth: 2,
                          strokeColor: AppTheme.surface,
                        ),
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppTheme.primary.withValues(alpha: 0.15),
                            AppTheme.primary.withValues(alpha: 0.0),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLowStockBanner() {
    final lowStock = _inventory.where((i) => (i['stock'] as double) < 0.25).toList();
    if (lowStock.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.warningSubtle,
          borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
          border: Border.all(color: AppTheme.warning.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            const Icon(Icons.warning_amber_rounded,
                color: AppTheme.warning, size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Low Stock Alert',
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: const Color(0xFF92400E),
                    ),
                  ),
                  Text(
                    '${lowStock.map((i) => i['name']).join(', ')} ${lowStock.length == 1 ? "is" : "are"} running low. Restock soon.',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: const Color(0xFF92400E),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInventory() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: '📦 Inventory Health',
            actionLabel: 'Manage',
            onAction: () {},
          ),
          const SizedBox(height: 12),
          ..._inventory.map((item) => Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                  border: Border.all(color: AppTheme.divider),
                  boxShadow: AppTheme.shadowSmall,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(item['emoji'] as String,
                            style: const TextStyle(fontSize: 28)),
                        const SizedBox(width: 12),
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
                                '${item['qty']} ${item['unit']} available • ₹${item['price']}/${item['unit']}',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit_outlined,
                              color: AppTheme.primary, size: 20),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: item['stock'] as double,
                              backgroundColor: AppTheme.surfaceElevated,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                (item['stock'] as double) < 0.25
                                    ? AppTheme.error
                                    : (item['stock'] as double) < 0.5
                                        ? AppTheme.warning
                                        : AppTheme.primary,
                              ),
                              minHeight: 6,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '${((item['stock'] as double) * 100).round()}%',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: (item['stock'] as double) < 0.25
                                ? AppTheme.error
                                : AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildRecentOrders() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: '🛍️ Recent Orders',
            actionLabel: 'View all',
            onAction: () => setState(() => _currentIndex = 1),
          ),
          const SizedBox(height: 12),
          ..._orders.take(3).map((order) => _buildOrderCard(order)),
        ],
      ),
    );
  }

  Widget _buildOrdersPage() {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Orders'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            onPressed: () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const AuthScreen()),
              (route) => false,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: _orders.length,
        itemBuilder: (ctx, i) => _buildOrderCard(_orders[i]),
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    final status = order['status'] as String;
    Color statusColor;
    AppBadgeVariant badgeVariant;

    switch (status) {
      case 'Delivered':
        statusColor = AppTheme.success;
        badgeVariant = AppBadgeVariant.success;
        break;
      case 'Accepted':
        statusColor = AppTheme.info;
        badgeVariant = AppBadgeVariant.info;
        break;
      default:
        statusColor = AppTheme.warning;
        badgeVariant = AppBadgeVariant.warning;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        border: Border.all(color: AppTheme.divider),
        boxShadow: AppTheme.shadowSmall,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                order['id'] as String,
                style: GoogleFonts.outfit(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: AppTheme.textPrimary),
              ),
              AppBadge(label: status, variant: badgeVariant),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.person_outline_rounded,
                  size: 14, color: AppTheme.textSecondary),
              const SizedBox(width: 6),
              Text(
                order['buyer'] as String,
                style: GoogleFonts.inter(
                    fontSize: 13, color: AppTheme.textSecondary),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.inventory_2_outlined,
                  size: 14, color: AppTheme.textSecondary),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  order['item'] as String,
                  style: GoogleFonts.inter(
                      fontSize: 13, color: AppTheme.textSecondary),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '₹${order['amount']}',
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                  color: AppTheme.primary,
                ),
              ),
              if (status == 'Pending')
                Row(
                  children: [
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.error,
                        side: const BorderSide(color: AppTheme.error),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text('Reject',
                          style: GoogleFonts.outfit(
                              fontWeight: FontWeight.w600, fontSize: 13)),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text('Accept',
                          style: GoogleFonts.outfit(
                              fontWeight: FontWeight.w600, fontSize: 13)),
                    ),
                  ],
                ),
              if (status == 'Accepted')
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.info,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text('Mark Packed',
                      style: GoogleFonts.outfit(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: Colors.white)),
                ),
            ],
          ),
        ],
      ),
    );
  }

  void _showAddProductSheet() {
    final nameCtrl = TextEditingController();
    final qtyCtrl = TextEditingController();
    final priceCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    String selectedCategory = 'Vegetables';
    bool isOrganic = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) => Container(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
              left: 24,
              right: 24,
              top: 8),
          decoration: const BoxDecoration(
            color: AppTheme.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Handle
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(top: 8, bottom: 20),
                    decoration: BoxDecoration(
                      color: AppTheme.border,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Text(
                  'Add New Product',
                  style: GoogleFonts.outfit(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Fill in the details to list your produce',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AppTheme.textSecondary,
                  ),
                ),
                const SizedBox(height: 24),

                // Image placeholder
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppTheme.primarySubtle,
                      borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                      border: Border.all(
                          color: AppTheme.primary.withValues(alpha: 0.3),
                          style: BorderStyle.solid),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.add_photo_alternate_rounded,
                            color: AppTheme.primary, size: 32),
                        const SizedBox(height: 8),
                        Text(
                          'Tap to add product photo',
                          style: GoogleFonts.inter(
                            color: AppTheme.primary,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                TextField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Product Name',
                    prefixIcon: Icon(Icons.eco_rounded),
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: descCtrl,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    prefixIcon: Icon(Icons.notes_rounded),
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: qtyCtrl,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Quantity',
                          prefixIcon: Icon(Icons.scale_rounded),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: TextField(
                        controller: priceCtrl,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Price (₹)',
                          prefixIcon: Icon(Icons.currency_rupee_rounded),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Category selector
                Text(
                  'Category',
                  style: GoogleFonts.inter(
                      color: AppTheme.textSecondary,
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: ['Vegetables', 'Fruits', 'Grains', 'Dairy', 'Greens']
                      .map((cat) => GestureDetector(
                            onTap: () =>
                                setModalState(() => selectedCategory = cat),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 7),
                              decoration: BoxDecoration(
                                gradient: selectedCategory == cat
                                    ? AppTheme.gradientPrimary
                                    : null,
                                color: selectedCategory == cat
                                    ? null
                                    : AppTheme.surfaceElevated,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: selectedCategory == cat
                                      ? Colors.transparent
                                      : AppTheme.border,
                                ),
                              ),
                              child: Text(
                                cat,
                                style: GoogleFonts.inter(
                                  color: selectedCategory == cat
                                      ? Colors.white
                                      : AppTheme.textSecondary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
                const SizedBox(height: 16),

                // Organic toggle
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceElevated,
                    borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                    border: Border.all(color: AppTheme.border),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.eco_rounded, color: AppTheme.primary, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Certified Organic',
                              style: GoogleFonts.outfit(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                            Text(
                              'Grown without chemical pesticides',
                              style: GoogleFonts.inter(
                                  fontSize: 11, color: AppTheme.textSecondary),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: isOrganic,
                        onChanged: (v) => setModalState(() => isOrganic = v),
                        activeColor: AppTheme.primary,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // AI Suggestion
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDE9FE),
                    borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                  ),
                  child: Row(
                    children: [
                      const Text('🤖', style: TextStyle(fontSize: 22)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'AI suggests ₹310/kg for tomatoes based on current market demand.',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: const Color(0xFF5B21B6),
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                GradientButton(
                  label: 'Publish Listing',
                  icon: Icons.rocket_launch_rounded,
                  onPressed: () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '✅  Product listed successfully!',
                          style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                        ),
                        backgroundColor: AppTheme.primary,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
