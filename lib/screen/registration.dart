import 'package:flutter/material.dart';

/// ---------------------------------------------------------------------------
/// Vibrant CRM - Onboarding: "Let's start with the basics" (Step 1 of 3)
///
/// Drop this file into your `lib/screens/` folder and push it like:
///   Navigator.push(context, MaterialPageRoute(builder: (_) => const CompanySetupScreen()));
///
/// No external packages required - pure Flutter/Material.
/// ---------------------------------------------------------------------------

class AppColors {
  static const topBar = Color(0xFF0A0E1A);
  static const pageBg = Color(0xFFF5F6FA);
  static const panelBg = Color(0xFF0D1224);
  static const purple = Color(0xFF6C63F5);
  static const purpleLight = Color(0xFFC9C6FB);
  static const purpleSoft = Color(0xFF2A2A55);
  static const textGrey = Color(0xFF9AA0AE);
  static const inputBorder = Color(0xFF2E3450);
  static const stepInactive = Color(0xFF23283D);
}

// ---------------------------------------------------------------------------
// SCREEN
// ---------------------------------------------------------------------------
class CompanySetupScreen extends StatefulWidget {
  const CompanySetupScreen({super.key});

  @override
  State<CompanySetupScreen> createState() => _CompanySetupScreenState();
}

class _CompanySetupScreenState extends State<CompanySetupScreen> {
  final _companyController = TextEditingController();
  final int _currentStep = 1; // 1-indexed: Company, Admin, Industry

  @override
  void dispose() {
    _companyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBg,
      body: Column(
        children: [
          _buildTopBar(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 32, 20, 24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 640),
                  child: Column(
                    children: [
                      _buildStepPanel(),
                      const SizedBox(height: 28),
                      const Text(
                        'Trusted by over 4,000 global enterprises.',
                        style: TextStyle(color: Color(0xFF9AA0AE), fontSize: 12.5),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        '© 2024 Vibrant CRM Systems Inc. All rights reserved.',
                        style: TextStyle(color: Color(0xFFB4B8C4), fontSize: 11.5),
                      ),
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

  // ---------------------------------------------------------------------
  // TOP BAR
  // ---------------------------------------------------------------------
  Widget _buildTopBar() {
    return Container(
      width: double.infinity,
      color: AppColors.topBar,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: Row(
        children: const [
          Text('🚀', style: TextStyle(fontSize: 20)),
          SizedBox(width: 10),
          Text(
            'Vibrant CRM',
            style: TextStyle(
              color: AppColors.purpleLight,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------
  // MAIN PANEL
  // ---------------------------------------------------------------------
  Widget _buildStepPanel() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppColors.panelBg,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStepper(),
          const SizedBox(height: 30),
          const Text(
            "Let's start with the\nbasics",
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.w800,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'What is the name of your organization?',
            style: TextStyle(color: AppColors.textGrey, fontSize: 14.5),
          ),
          const SizedBox(height: 26),
          const Text(
            'Company Name',
            style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          _buildCompanyInput(),
          const SizedBox(height: 18),
          _buildInfoBox(),
          const SizedBox(height: 28),
          Align(
            alignment: Alignment.centerRight,
            child: _buildContinueButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildStepper() {
    return Row(
      children: [
        _stepCircle(1, 'Company'),
        _stepLine(),
        _stepCircle(2, 'Admin'),
        _stepLine(),
        _stepCircle(3, 'Industry'),
      ],
    );
  }

  Widget _stepCircle(int number, String label) {
    final isActive = number == _currentStep;
    return Column(
      children: [
        Container(
          width: 34,
          height: 34,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActive ? AppColors.purple : AppColors.stepInactive,
            shape: BoxShape.circle,
          ),
          child: Text(
            '$number',
            style: TextStyle(
              color: isActive ? Colors.white : AppColors.textGrey,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : AppColors.textGrey,
            fontSize: 12.5,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _stepLine() {
    return Expanded(
      child: Container(
        height: 1,
        margin: const EdgeInsets.only(bottom: 24),
        color: const Color(0xFF23283D),
      ),
    );
  }

  Widget _buildCompanyInput() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.inputBorder),
      ),
      child: TextField(
        controller: _companyController,
        style: const TextStyle(color: Colors.white, fontSize: 14.5),
        decoration: const InputDecoration(
          hintText: 'e.g. Acme Corp',
          hintStyle: TextStyle(color: Color(0xFF5C6178), fontSize: 14.5),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  Widget _buildInfoBox() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: const BoxDecoration(
        color: Color(0xFF171C33),
        border: Border(left: BorderSide(color: AppColors.purple, width: 3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Icon(Icons.info_outline, color: AppColors.purple, size: 18),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Your company name will be used to generate your workspace URL and official reports.',
              style: TextStyle(color: AppColors.textGrey, fontSize: 13, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.purpleLight,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Continue',
              style: TextStyle(
                  color: Color(0xFF2A2470),
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700)),
          SizedBox(width: 8),
          Icon(Icons.arrow_forward, color: Color(0xFF2A2470), size: 18),
        ],
      ),
    );
  }
}