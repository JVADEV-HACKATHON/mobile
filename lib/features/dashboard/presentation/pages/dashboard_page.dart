import 'package:flutter/material.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/stats_grid.dart';
import '../widgets/chart_section.dart';
// ...existing code...
import '../../../../core/constants/app_constants.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.mediumSpacing),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DashboardHeader(),
              const SizedBox(height: AppConstants.largeSpacing),
              const StatsGrid(),
              const SizedBox(height: AppConstants.largeSpacing),
              const ChartSection(),
              const SizedBox(height: AppConstants.largeSpacing),
              // ...existing code...
            ],
          ),
        ),
      ),
    );
  }
}
