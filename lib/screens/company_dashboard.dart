import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import '../theme/app_theme.dart';
import '../widgets/app_widgets.dart';
import 'auth_screen.dart';

class CompanyDashboard extends StatefulWidget {
  const CompanyDashboard({super.key});

  @override
  State<CompanyDashboard> createState() => _CompanyDashboardState();
}

class _CompanyDashboardState extends State<CompanyDashboard> {
  String _selectedPeriod = 'Weekly';
  final List<String> _periods = ['Weekly', 'Monthly', 'Yearly'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── Header ──
          SliverToBoxAdapter(child: _buildHeader()),

          // ── KPI Cards ──
          SliverToBoxAdapter(
            child: _buildKPICards().animate().fadeIn(delay: 100.ms),
          ),

          // ── Period Filter ──
          SliverToBoxAdapter(
            child: _buildPeriodFilter().animate().fadeIn(delay: 150.ms),
          ),

          // ── Revenue Trend Chart ──
          SliverToBoxAdapter(
            child: _buildRevenueChart().animate().fadeIn(delay: 200.ms),
          ),

          // ── Demand Bar Chart ──
          SliverToBoxAdapter(
            child: _buildDemandChart().animate().fadeIn(delay: 250.ms),
          ),

          // ── Top Products ──
          SliverToBoxAdapter(
            child: _buildTopProducts().animate().fadeIn(delay: 300.ms),
          ),

          // ── User Growth ──
          SliverToBoxAdapter(
            child: _buildUserGrowth().animate().fadeIn(delay: 350.ms),
          ),

          // ── Regional Insights ──
          SliverToBoxAdapter(
            child: _buildRegionalInsights().animate().fadeIn(delay: 400.ms),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 56, 20, 24),
      color: AppTheme.surface,
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: AppTheme.gradientPrimary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.insights_rounded,
                color: Colors.white, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Analytics Dashboard',
                  style: GoogleFonts.outfit(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.textPrimary,
                  ),
                ),
                Text(
                  'Smart Food Access Platform',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout_rounded,
                color: AppTheme.textSecondary),
            onPressed: () => Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const AuthScreen()),
              (route) => false,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKPICards() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: StatCard(
                  label: 'Total Users',
                  value: '1,245',
                  icon: Icons.group_rounded,
                  color: AppTheme.primary,
                  trend: '18%',
                  trendPositive: true,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: StatCard(
                  label: 'Total Revenue',
                  value: '₹4.8L',
                  icon: Icons.currency_rupee_rounded,
                  color: AppTheme.success,
                  trend: '24%',
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
                  label: 'Food Listings',
                  value: '342',
                  icon: Icons.eco_rounded,
                  color: AppTheme.info,
                  trend: '11%',
                  trendPositive: true,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: StatCard(
                  label: 'Orders Done',
                  value: '856',
                  icon: Icons.check_circle_outline_rounded,
                  color: AppTheme.accent,
                  trend: '7%',
                  trendPositive: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodFilter() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Row(
        children: [
          Text(
            'Overview',
            style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimary,
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppTheme.surfaceElevated,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.border),
            ),
            child: Row(
              children: _periods
                  .map((p) => GestureDetector(
                        onTap: () => setState(() => _selectedPeriod = p),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 7),
                          decoration: BoxDecoration(
                            color: _selectedPeriod == p
                                ? AppTheme.primary
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            p,
                            style: GoogleFonts.inter(
                              color: _selectedPeriod == p
                                  ? Colors.white
                                  : AppTheme.textSecondary,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRevenueChart() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
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
                Text(
                  'Revenue Trend',
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: AppTheme.textPrimary,
                  ),
                ),
                AppBadge(
                  label: '₹4.8L total',
                  variant: AppBadgeVariant.success,
                  icon: Icons.trending_up_rounded,
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              _selectedPeriod == 'Weekly'
                  ? 'This week vs last week'
                  : _selectedPeriod == 'Monthly'
                      ? 'Month over month'
                      : 'Year on year',
              style: GoogleFonts.inter(
                  fontSize: 12, color: AppTheme.textSecondary),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 160,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (_) => FlLine(
                      color: AppTheme.divider,
                      strokeWidth: 1,
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 26,
                        getTitlesWidget: (value, meta) {
                          final labels = _selectedPeriod == 'Weekly'
                              ? ['M', 'T', 'W', 'T', 'F', 'S', 'S']
                              : _selectedPeriod == 'Monthly'
                                  ? ['W1', 'W2', 'W3', 'W4']
                                  : ['Q1', 'Q2', 'Q3', 'Q4'];
                          final idx = value.toInt();
                          if (idx >= labels.length) return const SizedBox();
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              labels[idx],
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                color: AppTheme.textTertiary,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 42,
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
                      spots: _selectedPeriod == 'Weekly'
                          ? const [
                              FlSpot(0, 18000),
                              FlSpot(1, 22000),
                              FlSpot(2, 31000),
                              FlSpot(3, 28000),
                              FlSpot(4, 35000),
                              FlSpot(5, 42000),
                              FlSpot(6, 38000),
                            ]
                          : _selectedPeriod == 'Monthly'
                              ? const [
                                  FlSpot(0, 85000),
                                  FlSpot(1, 102000),
                                  FlSpot(2, 98000),
                                  FlSpot(3, 125000),
                                ]
                              : const [
                                  FlSpot(0, 320000),
                                  FlSpot(1, 380000),
                                  FlSpot(2, 440000),
                                  FlSpot(3, 480000),
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
                            AppTheme.primary.withValues(alpha: 0.18),
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

  Widget _buildDemandChart() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
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
                Text(
                  'Demand Trends',
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: AppTheme.textPrimary,
                  ),
                ),
                AppBadge(
                  label: 'AI Predicted',
                  variant: AppBadgeVariant.info,
                  icon: Icons.auto_awesome_rounded,
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 180,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 20,
                  barTouchData: BarTouchData(
                    enabled: true,
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipColor: (_) =>
                          AppTheme.textPrimary.withValues(alpha: 0.9),
                      getTooltipItem: (group, groupIndex, rod, rodIndex) {
                        const days = [
                          'Mon',
                          'Tue',
                          'Wed',
                          'Thu',
                          'Fri',
                          'Sat',
                          'Sun'
                        ];
                        return BarTooltipItem(
                          '${days[group.x]}\n${rod.toY.round()} units',
                          GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        );
                      },
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const titles = [
                            'Mon',
                            'Tue',
                            'Wed',
                            'Thu',
                            'Fri',
                            'Sat',
                            'Sun'
                          ];
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              titles[value.toInt()],
                              style: GoogleFonts.inter(
                                  fontSize: 11,
                                  color: AppTheme.textTertiary,
                                  fontWeight: FontWeight.w500),
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (_) =>
                        FlLine(color: AppTheme.divider, strokeWidth: 1),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: [
                    _barGroup(0, 8, false),
                    _barGroup(1, 10, false),
                    _barGroup(2, 14, false),
                    _barGroup(3, 15, true),
                    _barGroup(4, 13, false),
                    _barGroup(5, 10, false),
                    _barGroup(6, 16, true),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _barGroup(int x, double y, bool isHighlight) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: isHighlight
                ? [AppTheme.accent, const Color(0xFFD97706)]
                : [AppTheme.primary.withValues(alpha: 0.8), AppTheme.primaryDark],
          ),
          width: 22,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
        ),
      ],
    );
  }

  Widget _buildTopProducts() {
    final products = [
      {'name': 'Tomatoes', 'emoji': '🍅', 'orders': 234, 'pct': 0.78, 'revenue': '₹69.2K'},
      {'name': 'Carrots', 'emoji': '🥕', 'orders': 187, 'pct': 0.62, 'revenue': '₹31.6K'},
      {'name': 'Spinach', 'emoji': '🥬', 'orders': 142, 'pct': 0.47, 'revenue': '₹12.6K'},
      {'name': 'Apples', 'emoji': '🍎', 'orders': 98, 'pct': 0.33, 'revenue': '₹8.7K'},
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
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
            Text(
              '🏆 Top Products',
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 20),
            ...products.asMap().entries.map((entry) {
              final i = entry.key;
              final p = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: i == 0
                            ? const Color(0xFFFEF3C7)
                            : i == 1
                                ? AppTheme.surfaceElevated
                                : AppTheme.surfaceElevated,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${i + 1}',
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.w800,
                            fontSize: 13,
                            color: i == 0
                                ? AppTheme.accent
                                : AppTheme.textSecondary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(p['emoji'] as String,
                        style: const TextStyle(fontSize: 22)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                p['name'] as String,
                                style: GoogleFonts.outfit(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                              Text(
                                p['revenue'] as String,
                                style: GoogleFonts.outfit(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                  color: AppTheme.primary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: p['pct'] as double,
                              backgroundColor: AppTheme.surfaceElevated,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                i == 0
                                    ? AppTheme.accent
                                    : AppTheme.primary,
                              ),
                              minHeight: 5,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            '${p['orders']} orders',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              color: AppTheme.textTertiary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildUserGrowth() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF7C3AED), Color(0xFF5B21B6)],
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
                  const Text('👥', style: TextStyle(fontSize: 28)),
                  const SizedBox(height: 12),
                  Text(
                    '1,245',
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    'Active Users',
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.75),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '↑ 18% this month',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF0EA5E9), Color(0xFF0284C7)],
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
                  const Text('🌾', style: TextStyle(fontSize: 28)),
                  const SizedBox(height: 12),
                  Text(
                    '342',
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    'Active Listings',
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.75),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '↑ 11% this month',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
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

  Widget _buildRegionalInsights() {
    final regions = [
      {'region': 'Hyderabad', 'orders': 342, 'pct': 0.40},
      {'region': 'Warangal', 'orders': 187, 'pct': 0.22},
      {'region': 'Nizamabad', 'orders': 124, 'pct': 0.14},
      {'region': 'Karimnagar', 'orders': 98, 'pct': 0.11},
      {'region': 'Others', 'orders': 105, 'pct': 0.13},
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
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
                Text(
                  '📍 Regional Demand',
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: AppTheme.textPrimary,
                  ),
                ),
                AppBadge(
                  label: '856 total',
                  variant: AppBadgeVariant.neutral,
                ),
              ],
            ),
            const SizedBox(height: 18),
            ...regions.map((r) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 90,
                        child: Text(
                          r['region'] as String,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: r['pct'] as double,
                            backgroundColor: AppTheme.surfaceElevated,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                AppTheme.primary),
                            minHeight: 8,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 36,
                        child: Text(
                          '${((r['pct'] as double) * 100).round()}%',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textSecondary,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
