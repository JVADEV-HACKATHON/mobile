import 'package:flutter/material.dart';
import 'planplus_success_screen.dart';

class JumpTargetScreen extends StatelessWidget {
  const JumpTargetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF181A20),
      appBar: AppBar(
        title: const Text('Planes de Suscripción'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              const Text(
                'Elige tu plan',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Desbloquea todo el potencial de nuestra plataforma',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 36),

              // Plan Cards (responsive)
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 600;
                  if (isWide) {
                    // Horizontal layout for wider screens
                    return Row(
                      children: [
                        Expanded(
                          child: _buildPlanCard(
                            context: context,
                            title: 'Gratis',
                            price: 'Bs 0',
                            period: 'para siempre',
                            features: [
                              'Análisis de imágenes limitado',
                              'Chatbot médico básico',
                              'Mapa de calor',
                              'Soporte por email',
                            ],
                            isCurrentPlan: true,
                            isPremium: false,
                            onTap: () {},
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          child: _buildPlanCard(
                            context: context,
                            title: 'PlanPlus',
                            price: 'Bs 15',
                            period: 'por mes',
                            features: [
                              'Análisis ilimitado de imágenes',
                              'Respuestas prioritarias del chatbot',
                              'Todas las funciones del mapa',
                              'Soporte preferente 24/7',
                              'Nuevas funciones primero',
                            ],
                            isCurrentPlan: false,
                            isPremium: true,
                            onTap: () {
                              _showUpgradeDialog(context);
                            },
                          ),
                        ),
                      ],
                    );
                  } else {
                    // Vertical layout for narrower screens
                    return Column(
                      children: [
                        _buildPlanCard(
                          context: context,
                          title: 'Gratis',
                          price: 'Bs 0',
                          period: 'para siempre',
                          features: [
                            'Análisis de imágenes limitado',
                            'Chatbot médico básico',
                            'Mapa de calor',
                            'Soporte por email',
                          ],
                          isCurrentPlan: true,
                          isPremium: false,
                          onTap: () {},
                        ),
                        const SizedBox(height: 24),
                        _buildPlanCard(
                          context: context,
                          title: 'PlanPlus',
                          price: 'Bs 15',
                          period: 'por mes',
                          features: [
                            'Análisis ilimitado de imágenes',
                            'Respuestas prioritarias del chatbot',
                            'Todas las funciones del mapa',
                            'Soporte preferente 24/7',
                            'Nuevas funciones primero',
                          ],
                          isCurrentPlan: false,
                          isPremium: true,
                          onTap: () {
                            _showUpgradeDialog(context);
                          },
                        ),
                      ],
                    );
                  }
                },
              ),

              const SizedBox(height: 32),

              // Footer info
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white12),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.white70, size: 20),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Puedes cancelar tu suscripción en cualquier momento. Los cambios se aplicarán al final del período de facturación actual.',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlanCard({
    required BuildContext context,
    required String title,
    required String price,
    required String period,
    required List<String> features,
    required bool isCurrentPlan,
    required bool isPremium,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF23252B),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isPremium ? Colors.amber : Colors.white12,
          width: isPremium ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header del plan
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: isPremium ? Colors.amber : Colors.white,
                  ),
                ),
                if (isCurrentPlan)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.shade900,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Actual',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 12),

            // Precio
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: isPremium ? Colors.amber : Colors.white,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  period,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white54,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Features
            ...features.map(
              (feature) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Icon(
                      Icons.check,
                      size: 16,
                      color: isPremium ? Colors.greenAccent : Colors.white38,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        feature,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isCurrentPlan ? null : onTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isPremium ? Colors.amber : Colors.white12,
                  foregroundColor: isPremium ? Colors.black : Colors.white70,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  disabledBackgroundColor: Colors.white12,
                  disabledForegroundColor: Colors.white38,
                ),
                child: Text(
                  isCurrentPlan ? 'Plan Actual' : 'Actualizar a $title',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showUpgradeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF23252B),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Actualizar a PlanPlus',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
          ),
          content: const Text(
            '¿Estás seguro de que quieres actualizar a PlanPlus por Bs 15/mes?\n\nTendrás acceso inmediato a todas las funciones premium.',
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.white54),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Aquí iría la lógica de procesamiento del pago
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const PlanPlusSuccessScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }
}
