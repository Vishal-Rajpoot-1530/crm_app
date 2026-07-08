import 'package:flutter/material.dart';

/// -----------------------------------------------------------------------
/// ONBOARDING GUIDE SCREEN ("Mastering Lead Management")
/// Self-contained — run directly or import `OnboardingGuideScreen`.
/// The three hero photos (dashboard / smartwatch / meeting) are built as
/// gradient + icon placeholders so the file has zero network dependency.
/// Swap `_HeroImagePlaceholder` for `Image.network(...)` / `Image.asset(...)`
/// once you have real photography.
/// -----------------------------------------------------------------------


class CrmApp extends StatelessWidget {
  const CrmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: 'Inter',
      ),
      home: const OnboardingGuideScreen(),
    );
  }
}

/// ---------------------------- COLORS ------------------------------------
class AppColors {
  static const background = Color(0xFF0A0E17);
  static const surface = Color(0xFF12172A);
  static const border = Color(0xFF232A42);
  static const primary = Color(0xFF7C6DF2);
  static const textSecondary = Color(0xFF8A90A6);
  static const cardLight = Color(0xFFE7E8F5);
}

/// ---------------------------- SCREEN --------------------------------------
class OnboardingGuideScreen extends StatefulWidget {
  const OnboardingGuideScreen({super.key});

  @override
  State<OnboardingGuideScreen> createState() => _OnboardingGuideScreenState();
}

class _OnboardingGuideScreenState extends State<OnboardingGuideScreen> {
  final int _totalSteps = 3;
  int _currentStep = 0;

  void _next() {
    if (_currentStep < _totalSteps - 1) {
      setState(() => _currentStep++);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Vibrant CRM',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(foregroundColor: AppColors.textSecondary),
                        child: const Text('Skip Guide', style: TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  _HeroGallery(),
                  const SizedBox(height: 20),
                  _WelcomeCard(
                    currentStep: _currentStep,
                    totalSteps: _totalSteps,
                    onNext: _next,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Text(
                'Vibrant CRM © 2024. Designed for Corporate Professionalism.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textSecondary.withOpacity(0.7), fontSize: 11),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ---------------------------- HERO GALLERY --------------------------------
class _HeroGallery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 5,
            child: _HeroImagePlaceholder(
              icon: Icons.insert_chart_rounded,
              gradientColors: const [Color(0xFF1D2C4D), Color(0xFF0F1526)],
              accentIcon: Icons.trending_up_rounded,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Expanded(
                  child: _HeroImagePlaceholder(
                    icon: Icons.watch_rounded,
                    gradientColors: const [Color(0xFF2A2F3D), Color(0xFF14161E)],
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: _HeroImagePlaceholder(
                    icon: Icons.groups_rounded,
                    gradientColors: const [Color(0xFF1E2A3D), Color(0xFF10151F)],
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

class _HeroImagePlaceholder extends StatelessWidget {
  final IconData icon;
  final IconData? accentIcon;
  final List<Color> gradientColors;

  const _HeroImagePlaceholder({
    required this.icon,
    required this.gradientColors,
    this.accentIcon,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradientColors,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(icon, size: 46, color: Colors.white.withOpacity(0.35)),
            if (accentIcon != null)
              Positioned(
                bottom: 14,
                right: 14,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(accentIcon, size: 16, color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// ---------------------------- WELCOME CARD --------------------------------
class _WelcomeCard extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final VoidCallback onNext;

  const _WelcomeCard({
    required this.currentStep,
    required this.totalSteps,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 26, 24, 24),
      decoration: BoxDecoration(
        color: AppColors.cardLight,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Welcome',
              style: TextStyle(color: Colors.white, fontSize: 12.5, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Mastering Lead\nManagement',
            style: TextStyle(
              color: Color(0xFF1A1D2E),
              fontSize: 30,
              height: 1.15,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Transform your pipeline with AI-driven lead scoring. Vibrant CRM identifies high-priority opportunities automatically, so your team focuses on where growth happens.',
            style: TextStyle(color: Color(0xFF5B5F72), fontSize: 14, height: 1.5),
          ),
          const SizedBox(height: 22),
          const Divider(color: Color(0xFFC7C9DE), height: 1),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _StepDots(currentStep: currentStep, totalSteps: totalSteps),
              ElevatedButton(
                onPressed: onNext,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text('Next Step', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward_rounded, size: 17),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StepDots extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  const _StepDots({required this.currentStep, required this.totalSteps});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalSteps, (i) {
        final active = i == currentStep;
        return Padding(
          padding: const EdgeInsets.only(right: 6),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: active ? 26 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: active ? AppColors.primary : const Color(0xFFB6B8CC),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        );
      }),
    );
  }
}