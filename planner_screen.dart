import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../themes/app_theme.dart';
import '../../utils/app_constants.dart';
import '../../data/tourism_data.dart';
import '../../services/gemini_services.dart';

class PlannerScreen extends StatefulWidget {
  const PlannerScreen({super.key});

  @override
  State<PlannerScreen> createState() => _PlannerScreenState();
}

class _PlannerScreenState extends State<PlannerScreen>
    with SingleTickerProviderStateMixin {
  // Form state
  String _selectedCityId = 'kolkata';
  int _days = 2;
  double _budget = 3000;
  final List<String> _selectedInterests = [];
  bool _isGenerating = false;
  String? _generatedItinerary;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnim;

  final List<Map<String, dynamic>> _interests = [
    {'label': 'Heritage', 'icon': Icons.account_balance},
    {'label': 'Nature', 'icon': Icons.park},
    {'label': 'Food', 'icon': Icons.restaurant},
    {'label': 'Shopping', 'icon': Icons.shopping_bag},
    {'label': 'Museums', 'icon': Icons.museum},
    {'label': 'Photography', 'icon': Icons.camera_alt},
    {'label': 'Temples', 'icon': Icons.temple_hindu},
    {'label': 'Nightlife', 'icon': Icons.nightlife},
    {'label': 'Budget', 'icon': Icons.savings},
    {'label': 'Adventure', 'icon': Icons.hiking},
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500));
    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _fadeController, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  Future<void> _generatePlan() async {
    setState(() {
      _isGenerating = true;
      _generatedItinerary = null;
    });

    final city =
        TourismData.getCityById(_selectedCityId)?.name ?? 'Kolkata';
    final result = await GeminiService.generateItinerary(
      city: city,
      days: _days,
      budget: _budget,
      interests: _selectedInterests.isEmpty
          ? ['Heritage', 'Food', 'Culture']
          : _selectedInterests,
    );

    setState(() {
      _isGenerating = false;
      _generatedItinerary = result;
    });
    _fadeController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBg : AppTheme.lightBg,
      appBar: AppBar(
        backgroundColor:
        isDark ? AppTheme.darkSurface : Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDark ? AppTheme.darkCard : AppTheme.lightBg,
            ),
            child: Icon(Icons.arrow_back_ios_new,
                size: 16,
                color: isDark
                    ? AppTheme.darkText
                    : AppTheme.lightText),
          ),
        ),
        title: Column(
          children: [
            Text(
              'Trip Planner',
              style: TextStyle(
                fontFamily: 'Outfit',
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color:
                isDark ? AppTheme.darkText : AppTheme.lightText,
              ),
            ),
            Text(
              'AI-powered itinerary generator',
              style: TextStyle(
                fontSize: 11,
                color: isDark
                    ? AppTheme.darkTextSecondary
                    : AppTheme.lightTextSecondary,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () => context.push(AppConstants.chatRoute),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(
                  horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.primaryCyan.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.chat_bubble_outline,
                      size: 14, color: AppTheme.primaryCyan),
                  SizedBox(width: 5),
                  Text(
                    'Chat',
                    style: TextStyle(
                      color: AppTheme.primaryCyan,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeroBanner(isDark),
            const SizedBox(height: 24),
            _buildCitySelector(isDark),
            const SizedBox(height: 20),
            _buildDaysSelector(isDark),
            const SizedBox(height: 20),
            _buildBudgetSelector(isDark),
            const SizedBox(height: 20),
            _buildInterestsGrid(isDark),
            const SizedBox(height: 24),
            _buildGenerateButton(),
            if (_isGenerating) ...[
              const SizedBox(height: 28),
              _buildLoadingState(isDark),
            ],
            if (_generatedItinerary != null && !_isGenerating) ...[
              const SizedBox(height: 28),
              _buildItineraryResult(isDark),
            ],
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  // ── Hero Banner ──────────────────────────────────────────────────────────
  Widget _buildHeroBanner(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6C63FF), Color(0xFF3B82F6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6C63FF).withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Plan Your Perfect\nKolkata Trip 🗺️',
                  style: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Set your budget & days, choose your interests — our AI builds the perfect itinerary.',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.75),
                      fontSize: 12,
                      height: 1.4),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.15),
            ),
            child: const Icon(Icons.auto_awesome,
                color: Colors.white, size: 28),
          ),
        ],
      ),
    );
  }

  // ── City Selector ────────────────────────────────────────────────────────
  Widget _buildCitySelector(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(isDark, Icons.location_city, 'Select City'),
        const SizedBox(height: 12),
        Row(
          children: TourismData.cities.map((city) {
            final isActive = TourismData.isCityActive(city.id);
            final isSelected = _selectedCityId == city.id;
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  if (isActive) {
                    setState(() => _selectedCityId = city.id);
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(
                      content: Text('${city.name} coming soon!'),
                      backgroundColor:
                      AppTheme.primaryDeepBlue,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(12)),
                    ));
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10),
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? const LinearGradient(
                      colors: [
                        AppTheme.primaryDeepBlue,
                        Color(0xFF1A3A8A)
                      ],
                    )
                        : null,
                    color: isSelected
                        ? null
                        : (isDark
                        ? AppTheme.darkCard
                        : Colors.white),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isSelected
                          ? Colors.transparent
                          : (isDark
                          ? Colors.white12
                          : Colors.grey.shade200),
                    ),
                    boxShadow: isSelected
                        ? [
                      BoxShadow(
                        color: AppTheme.primaryDeepBlue
                            .withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ]
                        : null,
                  ),
                  child: Column(
                    children: [
                      Text(
                        city.name,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: isSelected
                              ? Colors.white
                              : (isActive
                              ? (isDark
                              ? AppTheme.darkText
                              : AppTheme.lightText)
                              : Colors.grey),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      if (isActive && !isSelected)
                        Container(
                          margin: const EdgeInsets.only(top: 3),
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppTheme.primaryCyan,
                          ),
                        ),
                      if (!isActive)
                        const Text(
                          'soon',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 9),
                        ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // ── Days Selector ────────────────────────────────────────────────────────
  Widget _buildDaysSelector(bool isDark) {
    return _card(
      isDark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _label(isDark, Icons.calendar_today_outlined,
                  'Number of Days'),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      AppTheme.primaryDeepBlue,
                      AppTheme.primaryCyan
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$_days ${_days == 1 ? 'day' : 'days'}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: AppTheme.primaryDeepBlue,
              inactiveTrackColor:
              AppTheme.primaryDeepBlue.withOpacity(0.15),
              thumbColor: AppTheme.primaryDeepBlue,
              overlayColor:
              AppTheme.primaryDeepBlue.withOpacity(0.1),
              trackHeight: 4,
            ),
            child: Slider(
              value: _days.toDouble(),
              min: 1,
              max: 7,
              divisions: 6,
              onChanged: (v) =>
                  setState(() => _days = v.round()),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (i) {
              final d = i + 1;
              final isSelected = _days == d;
              return GestureDetector(
                onTap: () => setState(() => _days = d),
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? AppTheme.primaryDeepBlue
                        : (isDark
                        ? AppTheme.darkBg
                        : AppTheme.lightBg),
                  ),
                  child: Center(
                    child: Text(
                      '$d',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: isSelected
                            ? Colors.white
                            : (isDark
                            ? AppTheme.darkTextSecondary
                            : AppTheme.lightTextSecondary),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  // ── Budget Selector ──────────────────────────────────────────────────────
  Widget _buildBudgetSelector(bool isDark) {
    return _card(
      isDark,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _label(isDark, Icons.savings_outlined, 'Budget (₹)'),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.accentGold.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: AppTheme.accentGold.withOpacity(0.3)),
                ),
                child: Text(
                  '₹${_budget.toStringAsFixed(0)}',
                  style: const TextStyle(
                    color: AppTheme.accentGold,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: AppTheme.accentGold,
              inactiveTrackColor:
              AppTheme.accentGold.withOpacity(0.15),
              thumbColor: AppTheme.accentGold,
              overlayColor:
              AppTheme.accentGold.withOpacity(0.12),
              trackHeight: 4,
            ),
            child: Slider(
              value: _budget,
              min: 500,
              max: 20000,
              divisions: 39,
              onChanged: (v) => setState(() => _budget = v),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('₹500',
                  style: TextStyle(
                      color: isDark
                          ? AppTheme.darkTextSecondary
                          : AppTheme.lightTextSecondary,
                      fontSize: 11)),
              Text('₹20,000',
                  style: TextStyle(
                      color: isDark
                          ? AppTheme.darkTextSecondary
                          : AppTheme.lightTextSecondary,
                      fontSize: 11)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              {'label': 'Budget\n< ₹2k', 'value': 1500.0},
              {'label': 'Mid\n₹3–5k', 'value': 4000.0},
              {'label': 'Premium\n₹10k+', 'value': 10000.0},
            ].map((preset) {
              final val = preset['value'] as double;
              final isSelected = _budget == val;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _budget = val),
                  child: AnimatedContainer(
                    duration:
                    const Duration(milliseconds: 200),
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(
                        vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppTheme.accentGold
                          .withOpacity(0.15)
                          : (isDark
                          ? AppTheme.darkBg
                          : AppTheme.lightBg),
                      borderRadius:
                      BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected
                            ? AppTheme.accentGold
                            .withOpacity(0.5)
                            : Colors.transparent,
                      ),
                    ),
                    child: Text(
                      preset['label'] as String,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: isSelected
                            ? FontWeight.w700
                            : FontWeight.w500,
                        color: isSelected
                            ? AppTheme.accentGold
                            : (isDark
                            ? AppTheme.darkTextSecondary
                            : AppTheme.lightTextSecondary),
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // ── Interests Grid ───────────────────────────────────────────────────────
  Widget _buildInterestsGrid(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _label(isDark, Icons.favorite_outline, 'Your Interests'),
        const SizedBox(height: 4),
        Text(
          'Select what you enjoy (optional)',
          style: TextStyle(
              color: isDark
                  ? AppTheme.darkTextSecondary
                  : AppTheme.lightTextSecondary,
              fontSize: 12),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: _interests.map((interest) {
            final label = interest['label'] as String;
            final isSelected =
            _selectedInterests.contains(label);
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedInterests.remove(label);
                  } else {
                    _selectedInterests.add(label);
                  }
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? const LinearGradient(
                    colors: [
                      AppTheme.primaryDeepBlue,
                      AppTheme.primaryCyan
                    ],
                  )
                      : null,
                  color: isSelected
                      ? null
                      : (isDark
                      ? AppTheme.darkCard
                      : Colors.white),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? Colors.transparent
                        : (isDark
                        ? Colors.white12
                        : Colors.grey.shade200),
                  ),
                  boxShadow: isSelected
                      ? [
                    BoxShadow(
                      color: AppTheme.primaryDeepBlue
                          .withOpacity(0.25),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    )
                  ]
                      : null,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      interest['icon'] as IconData,
                      size: 14,
                      color: isSelected
                          ? Colors.white
                          : (isDark
                          ? AppTheme.darkTextSecondary
                          : AppTheme.lightTextSecondary),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isSelected
                            ? FontWeight.w700
                            : FontWeight.w500,
                        color: isSelected
                            ? Colors.white
                            : (isDark
                            ? AppTheme.darkText
                            : AppTheme.lightText),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // ── Generate Button ──────────────────────────────────────────────────────
  Widget _buildGenerateButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _isGenerating ? null : _generatePlan,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryDeepBlue,
          disabledBackgroundColor:
          AppTheme.primaryDeepBlue.withOpacity(0.5),
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)),
        ),
        child: _isGenerating
            ? const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                  strokeWidth: 2, color: Colors.white),
            ),
            SizedBox(width: 12),
            Text('Generating your plan...',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 15)),
          ],
        )
            : const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.auto_awesome,
                color: Colors.white, size: 20),
            SizedBox(width: 10),
            Text(
              'Generate AI Itinerary',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 16,
                fontFamily: 'Outfit',
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Loading State ─────────────────────────────────────────────────────────
  Widget _buildLoadingState(bool isDark) {
    return _card(
      isDark,
      child: Column(
        children: [
          const SizedBox(height: 8),
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFF6C63FF), AppTheme.primaryCyan],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF6C63FF).withOpacity(0.3),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(Icons.auto_awesome,
                color: Colors.white, size: 26),
          ),
          const SizedBox(height: 16),
          Text(
            'Building your itinerary...',
            style: TextStyle(
              fontFamily: 'Outfit',
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: isDark ? AppTheme.darkText : AppTheme.lightText,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Our AI is crafting the perfect plan\nfor your ${_days}-day Kolkata trip',
            style: TextStyle(
              fontSize: 13,
              color: isDark
                  ? AppTheme.darkTextSecondary
                  : AppTheme.lightTextSecondary,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          const LinearProgressIndicator(
            backgroundColor: Color(0x1A6C63FF),
            valueColor:
            AlwaysStoppedAnimation<Color>(Color(0xFF6C63FF)),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  // ── Itinerary Result ─────────────────────────────────────────────────────
  Widget _buildItineraryResult(bool isDark) {
    return FadeTransition(
      opacity: _fadeAnim,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  AppTheme.primaryDeepBlue,
                  Color(0xFF1A3A8A)
                ],
              ),
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20)),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.15),
                  ),
                  child: const Icon(Icons.auto_awesome,
                      color: Colors.white, size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Your AI Itinerary',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                          fontFamily: 'Outfit',
                        ),
                      ),
                      Text(
                        '$_days days • ₹${_budget.toStringAsFixed(0)} budget',
                        style: const TextStyle(
                            color: Colors.white60,
                            fontSize: 12),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: _generatePlan,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.refresh,
                        color: Colors.white, size: 16),
                  ),
                ),
              ],
            ),
          ),
          // Content
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? AppTheme.darkCard : Colors.white,
              borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(20)),
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
                Text(
                  _generatedItinerary!,
                  style: TextStyle(
                    fontSize: 13,
                    color: isDark
                        ? AppTheme.darkText
                        : AppTheme.lightText,
                    height: 1.7,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () =>
                        context.push(AppConstants.chatRoute),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryCyan,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(12)),
                    ),
                    icon: const Icon(Icons.chat_bubble_outline,
                        color: Colors.white, size: 16),
                    label: const Text(
                      'Refine with AI Chat',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Helpers ───────────────────────────────────────────────────────────────
  Widget _label(bool isDark, IconData icon, String text) {
    return Row(
      children: [
        Icon(icon,
            size: 16,
            color: isDark
                ? AppTheme.darkTextSecondary
                : AppTheme.lightTextSecondary),
        const SizedBox(width: 7),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            fontFamily: 'Outfit',
            color:
            isDark ? AppTheme.darkText : AppTheme.lightText,
          ),
        ),
      ],
    );
  }

  Widget _card(bool isDark, {required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }
}