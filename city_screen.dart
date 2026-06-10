import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../themes/app_theme.dart';
import '../../utils/app_constants.dart';
import '../../data/tourism_data.dart';
import '../../models/tourism_models.dart';

class CityScreen extends StatefulWidget {
  final String cityId;
  const CityScreen({super.key, required this.cityId});

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _tabs = [
    'All',
    'Heritage',
    'Attractions',
    'Food',
    'Hotels'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<TourismPlace> _getFilteredPlaces(String tab) {
    final all = TourismData.getPlacesByCity(widget.cityId);
    if (tab == 'All') return all;
    final map = {
      'Heritage': 'heritage',
      'Attractions': 'attraction',
      'Food': 'food',
      'Hotels': 'hotel',
    };
    return all.where((p) => p.category == map[tab]).toList();
  }

  @override
  Widget build(BuildContext context) {
    final city = TourismData.getCityById(widget.cityId);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (city == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.grey),
              const SizedBox(height: 16),
              const Text('City not found'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.pop(),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            expandedHeight: 260,
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
                  color: Colors.black.withOpacity(0.3),
                ),
                child: const Icon(Icons.arrow_back_ios_new,
                    color: Colors.white, size: 16),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () => context.push(AppConstants.chatRoute),
                child: Container(
                  margin: const EdgeInsets.only(
                      right: 12, top: 8, bottom: 8),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryCyan,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryCyan.withOpacity(0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.auto_awesome,
                          color: Colors.white, size: 13),
                      SizedBox(width: 5),
                      Text('Ask AI',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                city.name,
                style: const TextStyle(
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    city.imageUrl,
                    fit: BoxFit.cover,
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
                          Colors.black.withOpacity(0.7),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  // Info badges
                  Positioned(
                    bottom: 56,
                    left: 16,
                    child: Row(
                      children: [
                        _infoBadge(
                            Icons.wb_sunny_outlined, city.bestSeason),
                        const SizedBox(width: 8),
                        _infoBadge(Icons.translate,
                            city.language.split(',')[0]),
                        const SizedBox(width: 8),
                        _infoBadge(
                          Icons.place_outlined,
                          '${TourismData.getPlacesByCity(widget.cityId).length} places',
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
                color: isDark ? AppTheme.darkSurface : Colors.white,
                child: TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
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
                  unselectedLabelStyle: const TextStyle(
                    fontFamily: 'Outfit',
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                  tabs: _tabs.map((t) {
                    final count = t == 'All'
                        ? TourismData.getPlacesByCity(widget.cityId).length
                        : _getFilteredPlaces(t).length;
                    return Tab(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(t),
                          if (count > 0) ...[
                            const SizedBox(width: 5),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 1),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryCyan
                                    .withOpacity(0.15),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '$count',
                                style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.primaryCyan),
                              ),
                            ),
                          ],
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: _tabs.map((tab) {
            final places = _getFilteredPlaces(tab);
            if (places.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search_off,
                        size: 64, color: Colors.grey.shade300),
                    const SizedBox(height: 12),
                    Text(
                      'No places in this category yet',
                      style: TextStyle(color: Colors.grey.shade500),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'More coming soon!',
                      style: TextStyle(
                          color: Colors.grey.shade400, fontSize: 12),
                    ),
                  ],
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              physics: const BouncingScrollPhysics(),
              itemCount: places.length,
              itemBuilder: (context, i) =>
                  _PlaceListCard(place: places[i]),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _infoBadge(IconData icon, String text) => Container(
    padding:
    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      color: Colors.black.withOpacity(0.4),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.white12, width: 0.5),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white70, size: 11),
        const SizedBox(width: 4),
        Text(text,
            style: const TextStyle(
                color: Colors.white70, fontSize: 10)),
      ],
    ),
  );
}

// ─── Place List Card ──────────────────────────────────────────────────────────
class _PlaceListCard extends StatefulWidget {
  final TourismPlace place;
  const _PlaceListCard({required this.place});

  @override
  State<_PlaceListCard> createState() => _PlaceListCardState();
}

class _PlaceListCardState extends State<_PlaceListCard> {
  bool _isFav = false;

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

  IconData _categoryIcon(String category) {
    switch (category) {
      case 'heritage':
        return Icons.account_balance;
      case 'attraction':
        return Icons.landscape;
      case 'food':
        return Icons.restaurant;
      case 'hotel':
        return Icons.hotel;
      default:
        return Icons.place;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final catColor = _categoryColor(widget.place.category);

    return GestureDetector(
      onTap: () => context
          .push('${AppConstants.placeDetailRoute}/${widget.place.id}'),
      child: Container(
        margin: const EdgeInsets.only(bottom: 18),
        decoration: BoxDecoration(
          color: isDark ? AppTheme.darkCard : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20)),
                  child: SizedBox(
                    height: 192,
                    width: double.infinity,
                    child: Image.asset(
                      widget.place.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        decoration: const BoxDecoration(
                            gradient: AppTheme.heroGradient),
                        child: const Icon(Icons.image,
                            color: Colors.white38, size: 48),
                      ),
                    ),
                  ),
                ),
                // Category badge
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: catColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: catColor.withOpacity(0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(_categoryIcon(widget.place.category),
                            color: Colors.white, size: 11),
                        const SizedBox(width: 4),
                        Text(
                          widget.place.category.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Favorite
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () =>
                        setState(() => _isFav = !_isFav),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _isFav
                            ? Colors.red.withOpacity(0.15)
                            : Colors.white.withOpacity(0.9),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Icon(
                        _isFav
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: _isFav ? Colors.red : Colors.grey,
                        size: 18,
                      ),
                    ),
                  ),
                ),
                // Rating badge on image
                Positioned(
                  bottom: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.55),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star_rounded,
                            color: AppTheme.accentGold, size: 13),
                        const SizedBox(width: 3),
                        Text(
                          widget.place.rating.toStringAsFixed(1),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Text(
                    widget.place.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Outfit',
                      color: isDark
                          ? AppTheme.darkText
                          : AppTheme.lightText,
                    ),
                  ),
                  const SizedBox(height: 5),
                  // Description
                  Text(
                    widget.place.description,
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark
                          ? AppTheme.darkTextSecondary
                          : AppTheme.lightTextSecondary,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  // Info row
                  Row(
                    children: [
                      _infoChip(
                        isDark,
                        Icons.access_time_outlined,
                        widget.place.timing.split('(')[0].trim(),
                        AppTheme.primaryCyan.withOpacity(0.1),
                        AppTheme.primaryCyan,
                      ),
                      const SizedBox(width: 8),
                      _infoChip(
                        isDark,
                        Icons.confirmation_number_outlined,
                        widget.place.entryFee.split('/')[0].trim(),
                        AppTheme.accentGold.withOpacity(0.1),
                        AppTheme.accentGold,
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => context.push(
                              '${AppConstants.placeDetailRoute}/${widget.place.id}'),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                                color: isDark
                                    ? AppTheme.darkTextSecondary
                                    .withOpacity(0.3)
                                    : Colors.grey.shade300),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10),
                          ),
                          icon: Icon(Icons.info_outline,
                              size: 15,
                              color: isDark
                                  ? AppTheme.darkTextSecondary
                                  : AppTheme.lightTextSecondary),
                          label: Text(
                            'Details',
                            style: TextStyle(
                              color: isDark
                                  ? AppTheme.darkTextSecondary
                                  : AppTheme.lightTextSecondary,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () =>
                              context.push(AppConstants.chatRoute),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryCyan,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10),
                          ),
                          icon: const Icon(Icons.auto_awesome,
                              size: 15, color: Colors.white),
                          label: const Text(
                            'Ask AI',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w700),
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
      ),
    );
  }

  Widget _infoChip(bool isDark, IconData icon, String text,
      Color bgColor, Color iconColor) {
    return Container(
      padding:
      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: iconColor),
          const SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(
                fontSize: 11,
                color: iconColor,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}