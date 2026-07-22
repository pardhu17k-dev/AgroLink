import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'main_layout.dart';
import 'farmer_dashboard.dart';
import 'company_dashboard.dart';
import '../widgets/app_widgets.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String selectedRole = '';
  bool _isLoading = false;

  void _handleLogin() async {
    if (selectedRole.isEmpty) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 800));

    if (!mounted) return;
    setState(() => _isLoading = false);

    Widget nextScreen;
    if (selectedRole == 'consumer') {
      nextScreen = const MainLayout();
    } else if (selectedRole == 'farmer') {
      nextScreen = const FarmerDashboard();
    } else {
      nextScreen = const CompanyDashboard();
    }

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, animation, _) => nextScreen,
        transitionsBuilder: (_, animation, _, child) => FadeTransition(
          opacity: animation,
          child: child,
        ),
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // ── Background gradient ──
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF064E3B), // Deep emerald
                  Color(0xFF065F46),
                  Color(0xFF047857),
                ],
              ),
            ),
          ),

          // ── Decorative circles ──
          Positioned(
            top: -80,
            right: -80,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.05),
              ),
            ),
          ),
          Positioned(
            top: 60,
            right: 40,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.04),
              ),
            ),
          ),
          Positioned(
            bottom: -60,
            left: -40,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.06),
              ),
            ),
          ),

          // ── Main content ──
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: size.height - MediaQuery.of(context).padding.top),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 48),

                      // Logo + Brand
                      Column(
                        children: [
                          Container(
                            width: 88,
                            height: 88,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.2),
                                width: 1.5,
                              ),
                            ),
                            child: const Icon(
                              Icons.eco_rounded,
                              size: 48,
                              color: Colors.white,
                            ),
                          )
                              .animate()
                              .scale(duration: 600.ms, curve: Curves.easeOutBack),
                          const SizedBox(height: 20),
                          Text(
                            'Smart Food Access',
                            style: GoogleFonts.outfit(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -0.5,
                            ),
                          ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3),
                          const SizedBox(height: 8),
                          Text(
                            'Farm fresh, delivered intelligently',
                            style: GoogleFonts.inter(
                              color: Colors.white.withValues(alpha: 0.7),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ).animate().fadeIn(delay: 350.ms),
                        ],
                      ),

                      const SizedBox(height: 52),

                      // Role selection label
                      Text(
                        'How do you want to use the app?',
                        style: GoogleFonts.outfit(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ).animate().fadeIn(delay: 450.ms),

                      const SizedBox(height: 20),

                      // Role Cards
                      _RoleCard(
                        emoji: '🛒',
                        title: 'Find Food',
                        subtitle: 'Buy fresh produce or claim community donations',
                        role: 'consumer',
                        selectedRole: selectedRole,
                        onTap: () => setState(() => selectedRole = 'consumer'),
                      ).animate().fadeIn(delay: 550.ms).slideX(begin: -0.15),

                      const SizedBox(height: 14),

                      _RoleCard(
                        emoji: '🌾',
                        title: 'Provide Food',
                        subtitle: 'List your farm produce or donate surplus harvest',
                        role: 'farmer',
                        selectedRole: selectedRole,
                        onTap: () => setState(() => selectedRole = 'farmer'),
                      ).animate().fadeIn(delay: 650.ms).slideX(begin: 0.15),

                      const SizedBox(height: 14),

                      _RoleCard(
                        emoji: '📊',
                        title: 'Company Analytics',
                        subtitle: 'View system demand insights and supply chain data',
                        role: 'company',
                        selectedRole: selectedRole,
                        onTap: () => setState(() => selectedRole = 'company'),
                      ).animate().fadeIn(delay: 750.ms).slideX(begin: -0.15),

                      const SizedBox(height: 36),

                      // Continue Button
                      GradientButton(
                        label: selectedRole.isEmpty ? 'Select a role to continue' : 'Continue →',
                        onPressed: selectedRole.isEmpty ? null : _handleLogin,
                        isLoading: _isLoading,
                        gradient: selectedRole.isEmpty
                            ? LinearGradient(
                                colors: [
                                  Colors.white.withValues(alpha: 0.2),
                                  Colors.white.withValues(alpha: 0.15),
                                ],
                              )
                            : const LinearGradient(
                                colors: [Color(0xFF34D399), Color(0xFF10B981)],
                              ),
                      ).animate().fadeIn(delay: 850.ms).slideY(begin: 0.2),

                      const SizedBox(height: 32),

                      // Terms
                      Text(
                        'By continuing, you agree to our Terms of Service\nand Privacy Policy.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          color: Colors.white.withValues(alpha: 0.45),
                          fontSize: 11,
                          height: 1.5,
                        ),
                      ).animate().fadeIn(delay: 1000.ms),

                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final String role;
  final String selectedRole;
  final VoidCallback onTap;

  const _RoleCard({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.role,
    required this.selectedRole,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedRole == role;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withValues(alpha: 0.18)
              : Colors.white.withValues(alpha: 0.07),
          borderRadius: BorderRadius.circular(AppTheme.radiusXL),
          border: Border.all(
            color: isSelected
                ? Colors.white.withValues(alpha: 0.6)
                : Colors.white.withValues(alpha: 0.15),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withValues(alpha: 0.2)
                    : Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Text(emoji, style: const TextStyle(fontSize: 26)),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.65),
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? Colors.white : Colors.transparent,
                border: Border.all(
                  color: isSelected
                      ? Colors.white
                      : Colors.white.withValues(alpha: 0.3),
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 14, color: AppTheme.primaryDark)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
