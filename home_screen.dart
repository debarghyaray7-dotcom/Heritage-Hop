import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../themes/app_theme.dart';
import '../../utils/app_constants.dart';
import '../../data/tourism_data.dart';
import '../../models/tourism_models.dart';
import '../../providers/theme_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _currentNavIndex = 0;
  final _searchController = TextEditingController();
  late AnimationController _greetingAnim;
  late Animation<double> _greetingFade;
  late Animation<Offset> _greetingSlide;

  @override
  void initState() {
    super.initState();
    _greetingAnim = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _greetingFade = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _greetingAnim, curve: Curves.easeIn));
    _greetingSlide =
        Tween<Offset>(begin: const Offset(0, 0.12), end: Offset.zero).animate(
            CurvedAnimation(
                parent: _greetingAnim, curve: Curves.easeOutCubic));
    _greetingAnim.forward();
  }

  @override
  void dispose() {
    _greetingAnim.dispose();
    _searchController.dispose();
    super.dispose();
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  void _showComingSoonToast(String cityName) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.15),
              ),
              child: const Icon(Icons.location_city,
                  color: Colors.white, size: 16),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$cityName — Coming Soon!',
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: Colors.white),
                  ),
                  const Text(
                    'We\'re adding this city soon. Stay tuned! 🚀',
                    style: TextStyle(fontSize: 11, color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: AppTheme.primaryDeepBlue,
        behavior: SnackBarBehavior.floating,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        duration: const Duration(seconds: 3),
        elevation: 8,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeNotifier = ref.read(themeModeProvider.notifier);

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBg : AppTheme.lightBg,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(isDark, themeNotifier),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildGreetingSection(isDark),
                    const SizedBox(height: 24),
                    _buildHeroBanner(context, isDark),
                    const SizedBox(height: 28),
                    _buildSectionTitle(context, 'Explore by Category'),
                    const SizedBox(height: 14),
                    _buildCategoryRow(context, isDark),
                    const SizedBox(height: 28),
                    _buildSectionTitle(context, 'Popular Cities',
                        onSeeAll: () {}),
                    const SizedBox(height: 14),
                    _buildCityCards(context, isDark),
                    const SizedBox(height: 28),
                    _buildSectionTitle(context, 'Featured in Kolkata',
                        onSeeAll: () =>
                            context.push('${AppConstants.cityRoute}/kolkata')),
                    const SizedBox(height: 14),
                    _buildFeaturedPlaces(context),
                    const SizedBox(height: 28),
                    _buildAiBanner(context),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context, isDark),
    );
  }

  // ── Top Bar ──────────────────────────────────────────────────────────────
  Widget _buildTopBar(bool isDark, ThemeModeNotifier themeNotifier) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
      child: Row(
        children: [
          // Logo
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryDeepBlue.withOpacity(0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/logo.JPG',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(
                  Icons.temple_hindu_rounded,
                  color: AppTheme.primaryDeepBlue,
                  size: 20,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'HeritageHop',
            style: TextStyle(
              fontFamily: 'Outfit',
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: isDark ? AppTheme.darkText : AppTheme.lightText,
            ),
          ),
          // Kolkata active badge
          const SizedBox(width: 8),
          Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: AppTheme.primaryCyan.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: AppTheme.primaryCyan.withOpacity(0.35), width: 1),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.location_on,
                    color: AppTheme.primaryCyan, size: 10),
                SizedBox(width: 3),
                Text(
                  'Kolkata',
                  style: TextStyle(
                    color: AppTheme.primaryCyan,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          // Theme toggle
          GestureDetector(
            onTap: () => themeNotifier.toggleTheme(),
            child: Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDark ? AppTheme.darkCard : Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 8)
                ],
              ),
              child: Icon(
                isDark
                    ? Icons.light_mode_outlined
                    : Icons.dark_mode_outlined,
                size: 18,
                color: isDark
                    ? AppTheme.primaryCyan
                    : AppTheme.primaryDeepBlue,
              ),
            ),
          ),
          const SizedBox(width: 10),
          // Profile avatar
          GestureDetector(
            onTap: () => context.push(AppConstants.profileRoute),
            child: Container(
              width: 38,
              height: 38,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [AppTheme.primaryCyan, AppTheme.primaryDeepBlue],
                ),
              ),
              child:
              const Icon(Icons.person, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  // ── Greeting + Search ────────────────────────────────────────────────────
  Widget _buildGreetingSection(bool isDark) {
    return FadeTransition(
      opacity: _greetingFade,
      child: SlideTransition(
        position: _greetingSlide,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${_getGreeting()}, Traveller! 🙏',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Outfit',
                  color: isDark ? AppTheme.darkText : AppTheme.lightText,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Discover the best of Kolkata',
                style: TextStyle(
                  fontSize: 14,
                  color: isDark
                      ? AppTheme.darkTextSecondary
                      : AppTheme.lightTextSecondary,
                ),
              ),
              const SizedBox(height: 16),
              // Search bar
              Container(
                decoration: BoxDecoration(
                  color: isDark ? AppTheme.darkCard : Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 12,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search places, heritage, food...',
                    hintStyle: TextStyle(
                        color: isDark
                            ? AppTheme.darkTextSecondary
                            : Colors.grey.shade400,
                        fontSize: 14),
                    prefixIcon: const Icon(Icons.search,
                        color: AppTheme.primaryCyan, size: 22),
                    suffixIcon: Container(
                      margin: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            AppTheme.primaryDeepBlue,
                            AppTheme.primaryCyan
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.tune,
                          color: Colors.white, size: 16),
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Hero Banner ──────────────────────────────────────────────────────────
  Widget _buildHeroBanner(BuildContext context, bool isDark) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          colors: [AppTheme.primaryDeepBlue, Color(0xFF0A4D8C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryDeepBlue.withOpacity(0.35),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Stack(
          children: [
            // Decorative background circle
            Positioned(
              right: -20,
              top: -20,
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.primaryCyan.withOpacity(0.07),
                ),
              ),
            ),
            Positioned(
              right: 30,
              bottom: -30,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.accentGold.withOpacity(0.07),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(22),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppTheme.accentGold.withOpacity(0.18),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            '✨ AI-Powered Travel',
                            style: TextStyle(
                              color: AppTheme.accentGold,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Explore Kolkata\'s\nHidden Gems',
                          style: TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '10 curated experiences',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.65),
                          ),
                        ),
                        const SizedBox(height: 14),
                        GestureDetector(
                          onTap: () => context
                              .push('${AppConstants.cityRoute}/kolkata'),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 9),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryCyan,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                  AppTheme.primaryCyan.withOpacity(0.4),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.explore,
                                    color: Colors.white, size: 14),
                                SizedBox(width: 6),
                                Text(
                                  'Explore Now',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.temple_hindu_rounded,
                    size: 90,
                    color: Colors.white10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Section Title ────────────────────────────────────────────────────────
  Widget _buildSectionTitle(BuildContext context, String title,
      {VoidCallback? onSeeAll}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              fontFamily: 'Outfit',
              color: isDark ? AppTheme.darkText : AppTheme.lightText,
            ),
          ),
          if (onSeeAll != null)
            GestureDetector(
              onTap: onSeeAll,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.primaryCyan.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'See all',
                  style: TextStyle(
                    color: AppTheme.primaryCyan,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ── Category Row ─────────────────────────────────────────────────────────
  Widget _buildCategoryRow(BuildContext context, bool isDark) {
    final categories = [
      {
        'icon': Icons.account_balance,
        'label': 'Heritage',
        'color': const Color(0xFF6C63FF)
      },
      {
        'icon': Icons.landscape,
        'label': 'Attractions',
        'color': const Color(0xFF00B4D8)
      },
      {
        'icon': Icons.restaurant,
        'label': 'Food',
        'color': const Color(0xFFFF6B35)
      },
      {
        'icon': Icons.hotel,
        'label': 'Hotels',
        'color': const Color(0xFF2EC4B6)
      },
      {
        'icon': Icons.map,
        'label': 'Planner',
        'color': AppTheme.accentGold
      },
    ];

    return SizedBox(
      height: 96,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        itemBuilder: (context, i) {
          final cat = categories[i];
          final color = cat['color'] as Color;
          return GestureDetector(
            onTap: () {
              if (i == 4) {
                context.push(AppConstants.plannerRoute);
              } else {
                context.push('${AppConstants.cityRoute}/kolkata');
              }
            },
            child: Container(
              width: 72,
              margin: const EdgeInsets.only(right: 14),
              child: Column(
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                          color: color.withOpacity(0.2), width: 1),
                    ),
                    child: Icon(cat['icon'] as IconData,
                        color: color, size: 26),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    cat['label'] as String,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? AppTheme.darkTextSecondary
                          : AppTheme.lightTextSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ── City Cards ───────────────────────────────────────────────────────────
  Widget _buildCityCards(BuildContext context, bool isDark) {
    final cities = TourismData.cities;
    return SizedBox(
      height: 168,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        physics: const BouncingScrollPhysics(),
        itemCount: cities.length,
        itemBuilder: (context, i) {
          final city = cities[i];
          final isActive = TourismData.isCityActive(city.id);
          return GestureDetector(
            onTap: () {
              if (isActive) {
                context.push('${AppConstants.cityRoute}/${city.id}');
              } else {
                _showComingSoonToast(city.name);
              }
            },
            child: Container(
              width: 148,
              margin: const EdgeInsets.only(right: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withOpacity(isActive ? 0.12 : 0.06),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // City image
                    Image.asset(
                      city.imageUrl,
                      fit: BoxFit.cover,
                      color: isActive ? null : Colors.black,
                      colorBlendMode:
                      isActive ? null : BlendMode.saturation,
                      errorBuilder: (_, __, ___) => Container(
                        decoration: const BoxDecoration(
                            gradient: AppTheme.heroGradient),
                      ),
                    ),
                    // Gradient overlay
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.black
                                .withOpacity(isActive ? 0.65 : 0.75),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    // Content
                    Positioned(
                      bottom: 12,
                      left: 12,
                      right: 12,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            city.name,
                            style: TextStyle(
                              color: Colors.white
                                  .withOpacity(isActive ? 1.0 : 0.6),
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            city.state,
                            style: TextStyle(
                                color: Colors.white
                                    .withOpacity(isActive ? 0.75 : 0.4),
                                fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                    // Active indicator
                    if (isActive)
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryCyan,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Active',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                    // Coming soon badge
                    if (!isActive)
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.55),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: Colors.white24, width: 0.5),
                          ),
                          child: const Text(
                            'Soon',
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ── Featured Places ──────────────────────────────────────────────────────
  Widget _buildFeaturedPlaces(BuildContext context) {
    final places = TourismData.getFeaturedPlaces();
    return SizedBox(
      height: 228,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        physics: const BouncingScrollPhysics(),
        itemCount: places.length,
        itemBuilder: (context, i) => _PlaceCard(place: places[i]),
      ),
    );
  }

  // ── AI Banner ────────────────────────────────────────────────────────────
  Widget _buildAiBanner(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(AppConstants.plannerRoute),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF6C63FF), Color(0xFF3B82F6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6C63FF).withOpacity(0.35),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      '🤖 NEW FEATURE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'AI Budget\nTrip Planner',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      height: 1.2,
                      fontFamily: 'Outfit',
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Personalised itinerary in seconds',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Plan My Trip →',
                      style: TextStyle(
                        color: Color(0xFF6C63FF),
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.15),
              ),
              child: const Icon(Icons.auto_awesome,
                  color: Colors.white, size: 30),
            ),
          ],
        ),
      ),
    );
  }

  // ── Bottom Nav ───────────────────────────────────────────────────────────
  Widget _buildBottomNav(BuildContext context, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkSurface : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(context, 0, Icons.home_rounded, 'Home', isDark),
              _navItem(
                  context, 1, Icons.explore_rounded, 'Explore', isDark),
              _navItem(context, 2, Icons.auto_awesome_rounded, 'AI Chat',
                  isDark),
              _navItem(
                  context, 3, Icons.map_rounded, 'Planner', isDark),
              _navItem(
                  context, 4, Icons.person_rounded, 'Profile', isDark),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(BuildContext context, int index, IconData icon,
      String label, bool isDark) {
    final isActive = _currentNavIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() => _currentNavIndex = index);
        switch (index) {
          case 0:
            break;
          case 1:
            context.push('${AppConstants.cityRoute}/kolkata');
            break;
          case 2:
            context.push(AppConstants.chatRoute);
            break;
          case 3:
            context.push(AppConstants.plannerRoute);
            break;
          case 4:
            context.push(AppConstants.profileRoute);
            break;
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding:
        const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isActive
              ? AppTheme.primaryDeepBlue.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 22,
              color: isActive
                  ? AppTheme.primaryDeepBlue
                  : (isDark
                  ? AppTheme.darkTextSecondary
                  : AppTheme.lightTextSecondary),
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight:
                isActive ? FontWeight.w700 : FontWeight.w400,
                color: isActive
                    ? AppTheme.primaryDeepBlue
                    : (isDark
                    ? AppTheme.darkTextSecondary
                    : AppTheme.lightTextSecondary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Place Card Widget ────────────────────────────────────────────────────────
class _PlaceCard extends StatelessWidget {
  final TourismPlace place;
  const _PlaceCard({required this.place});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () =>
          context.push('${AppConstants.placeDetailRoute}/${place.id}'),
      child: Container(
        width: 188,
        margin: const EdgeInsets.only(right: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isDark ? AppTheme.darkCard : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius:
              const BorderRadius.vertical(top: Radius.circular(20)),
              child: SizedBox(
                height: 136,
                width: double.infinity,
                child: Image.asset(
                  place.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    decoration: const BoxDecoration(
                        gradient: AppTheme.heroGradient),
                    child: const Icon(Icons.image_outlined,
                        color: Colors.white54, size: 40),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place.name,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color:
                      isDark ? AppTheme.darkText : AppTheme.lightText,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded,
                          color: AppTheme.accentGold, size: 13),
                      const SizedBox(width: 3),
                      Text(
                        place.rating.toStringAsFixed(1),
                        style: const TextStyle(
                            fontSize: 11, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(width: 6),
                      Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          place.entryFee.split('/')[0].trim(),
                          style: const TextStyle(
                              fontSize: 10,
                              color: AppTheme.primaryCyan,
                              fontWeight: FontWeight.w600),
                          overflow: TextOverflow.ellipsis,
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