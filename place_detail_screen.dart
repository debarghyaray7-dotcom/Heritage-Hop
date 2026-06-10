import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../themes/app_theme.dart';
import '../../utils/app_constants.dart';
import '../../data/tourism_data.dart';
import '../../models/tourism_models.dart';

class PlaceDetailScreen extends StatefulWidget {
  final String placeId;
  const PlaceDetailScreen({super.key, required this.placeId});

  @override
  State<PlaceDetailScreen> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen>
    with SingleTickerProviderStateMixin {
  bool _isFavorite = false;
  late TabController _tabController;
  final List<String> _tabs = ['Overview', 'Tips', 'Transport', 'Nearby'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    final place = TourismData.getPlaceById(widget.placeId);
    if (place != null) _isFavorite = place.isFavorite;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Color _categoryColor(String category) {
    switch (category) {
      case 'heritage':
        return const Color(0xFF6C63FF);
      case 'attraction':
        return const Color(0xFF00B4D8);
      case 'food':
        return const Color(0xFFFF6B35);
      case 'hotel':
        return const Color(0xFF2EC4B6);
      default:
        return AppTheme.primaryDeepBlue;
    }
  }

  @override
  Widget build(BuildContext context) {
    final place = TourismData.getPlaceById(widget.placeId);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (place == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.grey),
              const SizedBox(height: 16),
              const Text('Place not found'),
              const SizedBox(height: 16),
              ElevatedButton(
                  onPressed: () => context.pop(),
                  child: const Text('Go Back')),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBg : AppTheme.lightBg,
      body: Stack(
        children: [
          NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                expandedHeight: 320,
                pinned: true,
                backgroundColor: isDark
                    ? AppTheme.darkSurface
                    : AppTheme.primaryDeepBlue,
                leading: GestureDetector(
                  onTap: () => context.pop(),
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.3)),
                    child: const Icon(Icons.arrow_back_ios_new,
                        color: Colors.white, size: 16),
                  ),
                ),
                actions: [
                  GestureDetector(
                    onTap: () =>
                        setState(() => _isFavorite = !_isFavorite),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.3),
                      ),
                      child: Icon(
                        _isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color:
                        _isFavorite ? Colors.red : Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 12),
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withOpacity(0.3),
                    ),
                    child: const Icon(Icons.share_outlined,
                        color: Colors.white, size: 20),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        place.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          decoration: const BoxDecoration(
                              gradient: AppTheme.heroGradient),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.75),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                      // Place info overlaid on hero
                      Positioned(
                        bottom: 16,
                        left: 16,
                        right: 16,
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: _categoryColor(place.category),
                                borderRadius:
                                BorderRadius.circular(20),
                              ),
                              child: Text(
                                place.category.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              place.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Outfit',
                                height: 1.1,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Icon(Icons.location_on,
                                    color: AppTheme.primaryCyan,
                                    size: 13),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    place.address,
                                    style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12),
                                    maxLines: 1,
                                    overflow:
                                    TextOverflow.ellipsis,
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
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(48),
                  child: Container(
                    color: isDark
                        ? AppTheme.darkSurface
                        : Colors.white,
                    child: TabBar(
                      controller: _tabController,
                      labelColor: isDark
                          ? AppTheme.primaryCyan
                          : AppTheme.primaryDeepBlue,
                      unselectedLabelColor: isDark
                          ? AppTheme.darkTextSecondary
                          : AppTheme.lightTextSecondary,
                      indicatorColor: isDark
                          ? AppTheme.primaryCyan
                          : AppTheme.primaryDeepBlue,
                      indicatorWeight: 3,
                      labelStyle: const TextStyle(
                        fontFamily: 'Outfit',
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                      tabs: _tabs.map((t) => Tab(text: t)).toList(),
                    ),
                  ),
                ),
              ),
            ],
            body: TabBarView(
              controller: _tabController,
              children: [
                _buildOverviewTab(place, isDark),
                _buildTipsTab(place, isDark),
                _buildTransportTab(place, isDark),
                _buildNearbyTab(place, isDark),
              ],
            ),
          ),
          // Floating bottom bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomBar(context, place, isDark),
          ),
        ],
      ),
    );
  }

  // ── Overview Tab ─────────────────────────────────────────────────────────
  Widget _buildOverviewTab(TourismPlace place, bool isDark) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Quick stats row
          Row(
            children: [
              _statCard(
                isDark,
                Icons.star_rounded,
                place.rating.toStringAsFixed(1),
                '${(place.reviewCount / 1000).toStringAsFixed(1)}k reviews',
                AppTheme.accentGold,
              ),
              const SizedBox(width: 12),
              _statCard(
                isDark,
                Icons.confirmation_number_outlined,
                place.entryFee.split('/')[0].trim(),
                'Entry Fee',
                AppTheme.primaryCyan,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _statCard(
                isDark,
                Icons.access_time_outlined,
                place.timing.contains('–')
                    ? place.timing.split('–')[0].trim()
                    : 'Open',
                'Opens',
                const Color(0xFF6C63FF),
              ),
              const SizedBox(width: 12),
              _statCard(
                isDark,
                Icons.wb_sunny_outlined,
                'Oct – Feb',
                'Best Time',
                const Color(0xFFFF6B35),
              ),
            ],
          ),
          const SizedBox(height: 22),

          // About
          _sectionHeader(isDark, Icons.info_outline, 'About'),
          const SizedBox(height: 10),
          Text(
            place.fullDescription,
            style: TextStyle(
              fontSize: 14,
              color: isDark
                  ? AppTheme.darkTextSecondary
                  : AppTheme.lightTextSecondary,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 22),

          // Timing
          _sectionHeader(
              isDark, Icons.schedule_outlined, 'Timings & Entry'),
          const SizedBox(height: 10),
          _infoRow(isDark, Icons.access_time, 'Hours', place.timing),
          const SizedBox(height: 8),
          _infoRow(isDark, Icons.confirmation_number_outlined,
              'Entry Fee', place.entryFee),
          const SizedBox(height: 8),
          _infoRow(isDark, Icons.calendar_today_outlined,
              'Best Season', place.bestTimeToVisit),
          const SizedBox(height: 22),

          // Budget estimate
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.primaryDeepBlue,
                  const Color(0xFF1A3A8A),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryDeepBlue.withOpacity(0.25),
                  blurRadius: 14,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.12),
                  ),
                  child: const Icon(Icons.account_balance_wallet,
                      color: AppTheme.accentGold, size: 22),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Estimated Budget',
                      style: TextStyle(
                          color: Colors.white60,
                          fontSize: 11,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      place.estimatedBudget,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Outfit',
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

  // ── Tips Tab ─────────────────────────────────────────────────────────────
  Widget _buildTipsTab(TourismPlace place, bool isDark) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
      physics: const BouncingScrollPhysics(),
      children: [
        _sectionHeader(isDark, Icons.tips_and_updates_outlined,
            'Travel Tips'),
        const SizedBox(height: 14),
        ...place.travelTips.asMap().entries.map((entry) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isDark ? AppTheme.darkCard : Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: AppTheme.primaryCyan.withOpacity(0.15),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.primaryCyan.withOpacity(0.1),
                  ),
                  child: Center(
                    child: Text(
                      '${entry.key + 1}',
                      style: const TextStyle(
                        color: AppTheme.primaryCyan,
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    entry.value,
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark
                          ? AppTheme.darkText
                          : AppTheme.lightText,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
        const SizedBox(height: 20),
        _sectionHeader(
            isDark, Icons.info_outline, 'Things to Know'),
        const SizedBox(height: 12),
        _infoRow(isDark, Icons.location_on_outlined, 'Address',
            place.address),
        const SizedBox(height: 8),
        _infoRow(isDark, Icons.account_balance_wallet_outlined,
            'Budget', place.estimatedBudget),
      ],
    );
  }

  // ── Transport Tab ─────────────────────────────────────────────────────────
  Widget _buildTransportTab(TourismPlace place, bool isDark) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
      physics: const BouncingScrollPhysics(),
      children: [
        _sectionHeader(isDark, Icons.directions_outlined,
            'How to Get Here'),
        const SizedBox(height: 14),
        ...place.nearbyTransport.map((transport) {
          final parts = transport.split(':');
          final icon = parts[0].trim();
          final detail =
          parts.length > 1 ? parts.sublist(1).join(':').trim() : '';
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isDark ? AppTheme.darkCard : Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color:
                    AppTheme.primaryDeepBlue.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(icon,
                        style: const TextStyle(fontSize: 20)),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    detail,
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark
                          ? AppTheme.darkText
                          : AppTheme.lightText,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
        const SizedBox(height: 20),
        // Map placeholder
        Container(
          height: 180,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppTheme.primaryDeepBlue.withOpacity(0.08),
                AppTheme.primaryCyan.withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
                color: AppTheme.primaryCyan.withOpacity(0.2)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.map_outlined,
                  size: 44,
                  color: AppTheme.primaryCyan.withOpacity(0.5)),
              const SizedBox(height: 10),
              Text(
                'Map Integration',
                style: TextStyle(
                  color: AppTheme.primaryCyan.withOpacity(0.7),
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Coming soon',
                style: TextStyle(
                    color: Colors.grey.shade400, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Nearby Tab ────────────────────────────────────────────────────────────
  Widget _buildNearbyTab(TourismPlace place, bool isDark) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
      physics: const BouncingScrollPhysics(),
      children: [
        _sectionHeader(
            isDark, Icons.restaurant_outlined, 'Nearby Food'),
        const SizedBox(height: 12),
        ...place.nearbyFood.map((food) => _nearbyItem(
            isDark, Icons.restaurant, food, const Color(0xFFFF6B35))),
        const SizedBox(height: 20),
        _sectionHeader(isDark, Icons.hotel_outlined, 'Nearby Hotels'),
        const SizedBox(height: 12),
        ...place.nearbyHotels.map((hotel) => _nearbyItem(
            isDark, Icons.hotel, hotel, const Color(0xFF2EC4B6))),
      ],
    );
  }

  // ── Bottom Action Bar ─────────────────────────────────────────────────────
  Widget _buildBottomBar(
      BuildContext context, TourismPlace place, bool isDark) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          16, 12, 16, MediaQuery.of(context).padding.bottom + 12),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkSurface : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => context.push(AppConstants.plannerRoute),
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                    color: AppTheme.primaryDeepBlue.withOpacity(0.3)),
                padding: const EdgeInsets.symmetric(vertical: 13),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
              icon: const Icon(Icons.calendar_today_outlined,
                  size: 16, color: AppTheme.primaryDeepBlue),
              label: const Text(
                'Plan Visit',
                style: TextStyle(
                    color: AppTheme.primaryDeepBlue,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: ElevatedButton.icon(
              onPressed: () => context.push(AppConstants.chatRoute),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryDeepBlue,
                padding: const EdgeInsets.symmetric(vertical: 13),
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
              icon: const Icon(Icons.auto_awesome,
                  size: 16, color: Colors.white),
              label: const Text(
                'Ask AI About This Place',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Helper Widgets ────────────────────────────────────────────────────────
  Widget _sectionHeader(
      bool isDark, IconData icon, String title) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppTheme.primaryDeepBlue.withOpacity(0.08),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon,
              size: 16, color: AppTheme.primaryDeepBlue),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            fontFamily: 'Outfit',
            color: isDark ? AppTheme.darkText : AppTheme.lightText,
          ),
        ),
      ],
    );
  }

  Widget _statCard(bool isDark, IconData icon, String value,
      String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isDark ? AppTheme.darkCard : Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 18),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: isDark
                          ? AppTheme.darkText
                          : AppTheme.lightText,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    label,
                    style: TextStyle(
                        fontSize: 10,
                        color: isDark
                            ? AppTheme.darkTextSecondary
                            : AppTheme.lightTextSecondary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(
      bool isDark, IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon,
            size: 15,
            color: isDark
                ? AppTheme.darkTextSecondary
                : AppTheme.lightTextSecondary),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color:
            isDark ? AppTheme.darkText : AppTheme.lightText,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 13,
              color: isDark
                  ? AppTheme.darkTextSecondary
                  : AppTheme.lightTextSecondary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _nearbyItem(
      bool isDark, IconData icon, String name, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(
          horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: color, size: 17),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isDark
                    ? AppTheme.darkText
                    : AppTheme.lightText,
              ),
            ),
          ),
          Icon(Icons.arrow_forward_ios,
              size: 12,
              color: isDark
                  ? AppTheme.darkTextSecondary
                  : Colors.grey.shade400),
        ],
      ),
    );
  }
}