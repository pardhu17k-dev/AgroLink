import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/app_widgets.dart';
import 'auth_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notificationsEnabled = true;
  bool _isDarkMode = false;

  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusXL),
        ),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppTheme.errorSubtle,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.logout_rounded,
                    color: AppTheme.error, size: 32),
              ),
              const SizedBox(height: 16),
              Text(
                'Log Out?',
                style: GoogleFonts.outfit(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'You will need to select your role again to re-enter the app.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: AppTheme.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: Text('Cancel',
                          style: GoogleFonts.outfit(fontWeight: FontWeight.w600)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => const AuthScreen()),
                          (route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.error,
                      ),
                      child: Text('Log Out',
                          style: GoogleFonts.outfit(
                              fontWeight: FontWeight.w600, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── Hero Header ──
          SliverToBoxAdapter(
            child: _buildHeroHeader().animate().fadeIn(duration: 400.ms),
          ),

          // ── Stats Row ──
          SliverToBoxAdapter(
            child: _buildStatsRow().animate().fadeIn(delay: 100.ms),
          ),

          // ── Account Settings ──
          SliverToBoxAdapter(
            child: _buildSection(
              title: 'Account',
              tiles: [
                _SettingsTileData(
                  icon: Icons.person_outline_rounded,
                  label: 'Edit Profile',
                  onTap: () {},
                ),
                _SettingsTileData(
                  icon: Icons.location_on_outlined,
                  label: 'Saved Addresses',
                  onTap: () {},
                ),
                _SettingsTileData(
                  icon: Icons.payment_outlined,
                  label: 'Payment Methods',
                  onTap: () {},
                  trailing: AppBadge(label: '1 card', variant: AppBadgeVariant.primary),
                ),
                _SettingsTileData(
                  icon: Icons.favorite_border_rounded,
                  label: 'Wishlist',
                  onTap: () {},
                  trailing: AppBadge(label: '5', variant: AppBadgeVariant.error),
                ),
              ],
            ).animate().fadeIn(delay: 150.ms),
          ),

          // ── Preferences ──
          SliverToBoxAdapter(
            child: _buildPreferencesSection().animate().fadeIn(delay: 200.ms),
          ),

          // ── Support ──
          SliverToBoxAdapter(
            child: _buildSection(
              title: 'Support',
              tiles: [
                _SettingsTileData(
                  icon: Icons.help_outline_rounded,
                  label: 'Help & FAQ',
                  onTap: () {},
                ),
                _SettingsTileData(
                  icon: Icons.chat_bubble_outline_rounded,
                  label: 'Contact Support',
                  onTap: () {},
                ),
                _SettingsTileData(
                  icon: Icons.privacy_tip_outlined,
                  label: 'Privacy Policy',
                  onTap: () {},
                ),
                _SettingsTileData(
                  icon: Icons.description_outlined,
                  label: 'Terms of Service',
                  onTap: () {},
                ),
              ],
            ).animate().fadeIn(delay: 250.ms),
          ),

          // ── Logout ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: OutlinedButton.icon(
                onPressed: () => _logout(context),
                icon: const Icon(Icons.logout_rounded, size: 18),
                label: Text(
                  'Log Out',
                  style: GoogleFonts.outfit(fontWeight: FontWeight.w700, fontSize: 15),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.error,
                  side: const BorderSide(color: AppTheme.error, width: 1.5),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ).animate().fadeIn(delay: 300.ms),
          ),

          // ── App Version ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.eco_rounded,
                          size: 14, color: AppTheme.primary),
                      const SizedBox(width: 6),
                      Text(
                        'Smart Food Access',
                        style: GoogleFonts.outfit(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Version 1.0.0 • Made with ❤️ in India',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: AppTheme.textTertiary,
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 350.ms),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 64, 24, 32),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppTheme.primaryDark, AppTheme.primary, AppTheme.primaryLight],
        ),
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Colors.white.withValues(alpha: 0.4), width: 2),
                ),
                child: const Icon(Icons.person_rounded,
                    size: 48, color: Colors.white),
              ),
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  shape: BoxShape.circle,
                  boxShadow: AppTheme.shadowSmall,
                ),
                child: const Icon(Icons.camera_alt_rounded,
                    size: 16, color: AppTheme.primary),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Pardhu',
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'pardhu@email.com',
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: Colors.white.withValues(alpha: 0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.verified_rounded,
                    size: 14, color: Colors.white),
                const SizedBox(width: 6),
                Text(
                  'Verified Consumer',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Container(
      color: AppTheme.surface,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: Row(
        children: [
          _statCard('12', 'Orders'),
          _divider(),
          _statCard('5', 'Wishlist'),
          _divider(),
          _statCard('8', 'Reviews'),
          _divider(),
          _statCard('3', 'Donations'),
        ],
      ),
    );
  }

  Widget _statCard(String value, String label) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.outfit(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppTheme.primary,
            ),
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
      ),
    );
  }

  Widget _divider() {
    return Container(
      width: 1,
      height: 32,
      color: AppTheme.divider,
    );
  }

  Widget _buildSection({
    required String title,
    required List<_SettingsTileData> tiles,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: AppTheme.textTertiary,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(AppTheme.radiusXL),
              border: Border.all(color: AppTheme.divider),
              boxShadow: AppTheme.shadowSmall,
            ),
            child: Column(
              children: tiles.asMap().entries.map((entry) {
                final i = entry.key;
                final tile = entry.value;
                return Column(
                  children: [
                    ListTile(
                      onTap: tile.onTap,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      leading: Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: AppTheme.primary.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(tile.icon,
                            color: AppTheme.primary, size: 20),
                      ),
                      title: Text(
                        tile.label,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      trailing: tile.trailing ??
                          const Icon(Icons.chevron_right_rounded,
                              color: AppTheme.textTertiary, size: 22),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: i == 0
                              ? const Radius.circular(AppTheme.radiusXL)
                              : Radius.zero,
                          bottom: i == tiles.length - 1
                              ? const Radius.circular(AppTheme.radiusXL)
                              : Radius.zero,
                        ),
                      ),
                    ),
                    if (i < tiles.length - 1)
                      Padding(
                        padding: const EdgeInsets.only(left: 70),
                        child: const Divider(height: 1, color: AppTheme.divider),
                      ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreferencesSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PREFERENCES',
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: AppTheme.textTertiary,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(AppTheme.radiusXL),
              border: Border.all(color: AppTheme.divider),
              boxShadow: AppTheme.shadowSmall,
            ),
            child: Column(
              children: [
                // Notifications toggle
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 4),
                  leading: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: AppTheme.primary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.notifications_outlined,
                        color: AppTheme.primary, size: 20),
                  ),
                  title: Text(
                    'Notifications',
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  subtitle: Text(
                    'Order updates, deals & alerts',
                    style: GoogleFonts.inter(
                        fontSize: 11, color: AppTheme.textTertiary),
                  ),
                  trailing: Switch(
                    value: _notificationsEnabled,
                    onChanged: (v) =>
                        setState(() => _notificationsEnabled = v),
                    activeThumbColor: AppTheme.primary,
                  ),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(AppTheme.radiusXL)),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 70),
                  child: Divider(height: 1, color: AppTheme.divider),
                ),
                // Dark mode toggle
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 4),
                  leading: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: AppTheme.primary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.dark_mode_outlined,
                        color: AppTheme.primary, size: 20),
                  ),
                  title: Text(
                    'Dark Mode',
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                  subtitle: Text(
                    'Easier on the eyes at night',
                    style: GoogleFonts.inter(
                        fontSize: 11, color: AppTheme.textTertiary),
                  ),
                  trailing: Switch(
                    value: _isDarkMode,
                    onChanged: (v) => setState(() => _isDarkMode = v),
                    activeThumbColor: AppTheme.primary,
                  ),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(AppTheme.radiusXL)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsTileData {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Widget? trailing;

  _SettingsTileData({
    required this.icon,
    required this.label,
    required this.onTap,
    this.trailing,
  });
}
