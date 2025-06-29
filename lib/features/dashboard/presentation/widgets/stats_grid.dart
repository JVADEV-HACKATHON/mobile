import 'package:flutter/material.dart';
import 'stat_card.dart';
import '../pages/image_analysis_page.dart';
import '../../../../core/constants/app_constants.dart';
import '../pages/chatbot_page.dart';

class StatsGrid extends StatelessWidget {
  const StatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: AppConstants.mediumSpacing,
      mainAxisSpacing: AppConstants.mediumSpacing,
      childAspectRatio: 1.2,
      children: [
        StatCard(
          title: 'Chatbot',
          value: '',
          icon: Icons.smart_toy_outlined,
          color: Colors.blueGrey,
          percentage: '',
          onTap: () {
            // Aquí va la navegación al ChatbotPage
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => ChatbotPage()));
          },
        ),
        StatCard(
          title: 'Análisis de Imágenes',
          value: '',
          icon: Icons.insert_photo_outlined,
          color: Colors.blueGrey,
          percentage: '',
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const ImageAnalysisPage()),
            );
          },
        ),
      ],
    );
  }
}
