import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../themes/app_theme.dart';
import '../../utils/app_constants.dart';
import '../../providers/theme_provider.dart';
import '../../data/tourism_data.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() =>
      _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  // Prototype user data
  final String _userName = 'Heritage Explorer';
  final String _userEmail = 'explorer@heritagehop.in';
  final int _placesVisited = 4;
  final int _citiesExplored = 1;
  final int _tripsPlanned = 2;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 700));
    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
            parent: _animController, curve: Curves.easeIn));
    _slideAnim =
        Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero)
            .animate(CurvedAnimation(
            parent: _animController,
            curve: Curves.easeOutCubic));
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeNotifier =
    ref.read(themeModeProvider.notifier);
    final isDarkMode = ref.watch(themeModeProvider) ==
        ThemeMode.dark;

    return Scaffold(
      backgroundColor:
      isDark ? AppTheme.darkBg : AppTheme.lightBg,
      body: FadeTransition(
        opacity: _fadeAnim,
        child: SlideTransition(
          position: _slideAnim,
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // ── App Bar ──────────────────────────────────────────
              SliverAppBar(
                pinned: true,
                backgroundColor: isDark
                    ? AppTheme.darkSurface
                    : Colors.white,
                elevation: 0,
                leading: GestureDetector(
                  onTap: () => context.pop(),
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isDark
                          ? AppTheme.darkCard
                          : AppTheme.lightBg,
                    ),
                    child: Icon(Icons.arrow_back_ios_new,
                        size: 16,
                        color: isDark
                            ? AppTheme.darkText
                            : AppTheme.lightText),
                  ),
                ),
                title: Text(
                  'Profile',
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: isDark
                        ? AppTheme.darkText
                        : AppTheme.lightText,
                  ),
                ),
                actions: [
                  Container(
                    margin: const EdgeInsets.only(
                        right: 12, top: 8, bottom: 8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryDeepBlue
                          .withOpacity(0.08),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.verified,
                            size: 13,
                            color: AppTheme.primaryCyan),
                        SizedBox(width: 4),
                        Text(
                          'Prototype',
                          style: TextStyle(
                            color: AppTheme.primaryCyan,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      // ── Profile Header Card ───────────────────────
                      _buildProfileCard(isDark),
                      const SizedBox(height: 20),

                      // ── Stats Row ─────────────────────────────────
                      _buildStatsRow(isDark),
                      const SizedBox(height: 24),

                      // ── Saved City ────────────────────────────────
                      _buildSectionTitle(isDark,
                          'Your Active City'),
                      const SizedBox(height: 12),
                      _buildKolkataCard(context, isDark),
                      const SizedBox(height: 24),

                      // ── Settings ──────────────────────────────────
                      _buildSectionTitle(isDark, 'Preferences'),
                      const SizedBox(height: 12),
                      _buildPreferencesCard(
                          isDark, isDarkMode, themeNotifier),
                      const SizedBox(height: 24),

                      // ── App Section ───────────────────────────────
                      _buildSectionTitle(isDark, 'App'),
                      const SizedBox(height: 12),
                      _buildMenuCard(isDark, context),
                      const SizedBox(height: 24),

                      // ── Logout Button ─────────────────────────────
                      _buildLogoutButton(context),
                      const SizedBox(height: 12),

                      // ── Version tag ───────────────────────────────
                      Center(
                        child: Text(
                          'HeritageHop v1.0.0 · Kolkata Edition',
                          style: TextStyle(
                            fontSize: 11,
                            color: isDark
                                ? AppTheme.darkTextSecondary
                                : AppTheme.lightTextSecondary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Profile Card ──────────────────────────────────────────────────────────
  Widget _buildProfileCard(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppTheme.primaryDeepBlue,
            Color(0xFF0A4D8C)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryDeepBlue.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative circles
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),
          Row(
            children: [
              // Avatar
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [
                      AppTheme.primaryCyan,
                      Color(0xFF0099A8)
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color:
                      AppTheme.primaryCyan.withOpacity(0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(Icons.person,
                    color: Colors.white, size: 36),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      _userName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Outfit',
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      _userEmail,
                      style: const TextStyle(
                          color: Colors.white60,
                          fontSize: 12),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color:
                        AppTheme.accentGold.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: AppTheme.accentGold
                                .withOpacity(0.4)),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.emoji_events,
                              color: AppTheme.accentGold,
                              size: 12),
                          SizedBox(width: 5),
                          Text(
                            'Heritage Explorer',
                            style: TextStyle(
                              color: AppTheme.accentGold,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Edit button
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.12),
                ),
                child: const Icon(Icons.edit_outlined,
                    color: Colors.white, size: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ── Stats Row ─────────────────────────────────────────────────────────────
  Widget _buildStatsRow(bool isDark) {
    return Row(
      children: [
        _statItem(isDark, Icons.place_outlined,
            '$_placesVisited', 'Places\nVisited',
            AppTheme.primaryCyan),
        const SizedBox(width: 12),
        _statItem(isDark, Icons.location_city_outlined,
            '$_citiesExplored', 'City\nExplored',
            const Color(0xFF6C63FF)),
        const SizedBox(width: 12),
        _statItem(isDark, Icons.map_outlined,
            '$_tripsPlanned', 'Trips\nPlanned',
            AppTheme.accentGold),
      ],
    );
  }

  Widget _statItem(bool isDark, IconData icon, String value,
      String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: isDark ? AppTheme.darkCard : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 18),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                fontFamily: 'Outfit',
                color: isDark
                    ? AppTheme.darkText
                    : AppTheme.lightText,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: isDark
                    ? AppTheme.darkTextSecondary
                    : AppTheme.lightTextSecondary,
                height: 1.3,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // ── Kolkata Card ──────────────────────────────────────────────────────────
  Widget _buildKolkataCard(BuildContext context, bool isDark) {
    final kolkata = TourismData.getCityById('kolkata')!;
    final placeCount =
        TourismData.getPlacesByCity('kolkata').length;
    return GestureDetector(
      onTap: () =>
          context.push('${AppConstants.cityRoute}/kolkata'),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? AppTheme.darkCard : Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 64,
                height: 64,
                child: Image.asset(
                  kolkata.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    decoration: const BoxDecoration(
                        gradient: AppTheme.heroGradient),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        kolkata.name,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'Outfit',
                          color: isDark
                              ? AppTheme.darkText
                              : AppTheme.lightText,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryCyan,
                          borderRadius:
                          BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Active',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    kolkata.state,
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark
                          ? AppTheme.darkTextSecondary
                          : AppTheme.lightTextSecondary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.place_outlined,
                          size: 12, color: AppTheme.primaryCyan),
                      const SizedBox(width: 3),
                      Text(
                        '$placeCount places available',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppTheme.primaryCyan,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios,
                size: 14, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  // ── Preferences Card ──────────────────────────────────────────────────────
  Widget _buildPreferencesCard(bool isDark, bool isDarkMode,
      ThemeModeNotifier themeNotifier) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          _settingsTile(
            isDark,
            Icons.dark_mode_outlined,
            'Dark Mode',
            'Switch appearance',
            trailing: Switch(
              value: isDarkMode,
              onChanged: (_) => themeNotifier.toggleTheme(),
              activeColor: AppTheme.primaryCyan,
            ),
            isFirst: true,
          ),
          _divider(isDark),
          _settingsTile(
            isDark,
            Icons.notifications_outlined,
            'Notifications',
            'Coming soon',
            trailing: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: AppTheme.accentGold.withOpacity(0.12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Soon',
                style: TextStyle(
                  color: AppTheme.accentGold,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          _divider(isDark),
          _settingsTile(
            isDark,
            Icons.language_outlined,
            'Language',
            'English',
            trailing: const Icon(Icons.arrow_forward_ios,
                size: 14, color: Colors.grey),
            isLast: true,
          ),
        ],
      ),
    );
  }

  // ── Menu Card ─────────────────────────────────────────────────────────────
  Widget _buildMenuCard(bool isDark, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          _settingsTile(
            isDark,
            Icons.help_outline,
            'Help & Support',
            'FAQs and contact',
            trailing: const Icon(Icons.arrow_forward_ios,
                size: 14, color: Colors.grey),
            isFirst: true,
          ),
          _divider(isDark),
          _settingsTile(
            isDark,
            Icons.star_outline,
            'Rate the App',
            'Tell us what you think',
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                5,
                    (i) => const Icon(Icons.star_rounded,
                    color: AppTheme.accentGold, size: 14),
              ),
            ),
          ),
          _divider(isDark),
          _settingsTile(
            isDark,
            Icons.info_outline,
            'About HeritageHop',
            'Version 1.0.0 · Kolkata Edition',
            trailing: const Icon(Icons.arrow_forward_ios,
                size: 14, color: Colors.grey),
            isLast: true,
          ),
        ],
      ),
    );
  }

  // ── Logout Button ─────────────────────────────────────────────────────────
  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: const Text('Sign Out?',
                  style: TextStyle(fontFamily: 'Outfit')),
              content: const Text(
                  'Are you sure you want to sign out?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                    context.go(AppConstants.loginRoute);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(10)),
                  ),
                  child: const Text('Sign Out',
                      style:
                      TextStyle(color: Colors.white)),
                ),
              ],
            ),
          );
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.red, width: 1),
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)),
        ),
        icon: const Icon(Icons.logout, color: Colors.red,
            size: 18),
        label: const Text(
          'Sign Out',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  // ── Helpers ───────────────────────────────────────────────────────────────
  Widget _buildSectionTitle(bool isDark, String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w800,
        fontFamily: 'Outfit',
        color: isDark ? AppTheme.darkText : AppTheme.lightText,
      ),
    );
  }

  Widget _settingsTile(
      bool isDark,
      IconData icon,
      String title,
      String subtitle, {
        Widget? trailing,
        bool isFirst = false,
        bool isLast = false,
      }) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 16, vertical: 13),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppTheme.primaryDeepBlue.withOpacity(0.07),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon,
                size: 18,
                color: AppTheme.primaryDeepBlue),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: isDark
                        ? AppTheme.darkText
                        : AppTheme.lightText,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11,
                    color: isDark
                        ? AppTheme.darkTextSecondary
                        : AppTheme.lightTextSecondary,
                  ),
                ),
              ],
            ),
          ),
          if (trailing != null) trailing,
        ],
      ),
    );
  }

  Widget _divider(bool isDark) => Divider(
    height: 1,
    indent: 68,
    endIndent: 16,
    color: isDark ? Colors.white10 : Colors.grey.shade100,
  );
}