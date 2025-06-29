import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<_ChatMessage> _messages = [];
  bool _isLoading = false;

  static const String _medicalContext =
      '''Eres un asistente médico virtual especializado en atención primaria. Tu función es:

RESPONSABILIDADES:
- Proporcionar información médica general basada en evidencia científica
- Realizar triaje básico de síntomas (leve, moderado, urgente)
- Explicar condiciones médicas comunes en términos comprensibles
- Orientar sobre primeros auxilios básicos
- Informar sobre medicamentos de venta libre
- Identificar cuándo es necesaria atención médica profesional

LIMITACIONES IMPORTANTES:
- NO diagnosticas enfermedades
- NO prescribes medicamentos
- NO reemplazas la consulta médica profesional
- NO manejas emergencias médicas (deriva a servicios de emergencia)

ESTILO DE COMUNICACIÓN:
- Empático y comprensivo
- Lenguaje claro y accesible
- Preguntas de seguimiento para clarificar síntomas
- Siempre recomienda consulta profesional para casos complejos

CONTEXTO MÉDICO: Enfócate en medicina general, síntomas comunes, prevención y educación sanitaria.''';

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(_ChatMessage(text: text, isUser: true));
      _isLoading = true;
      _controller.clear();
    });
    await _scrollToBottom();
    final response = await _fetchGeminiResponse(text);
    setState(() {
      _messages.add(_ChatMessage(text: response, isUser: false));
      _isLoading = false;
    });
    await _scrollToBottom();
  }

  Future<void> _scrollToBottom() async {
    await Future.delayed(const Duration(milliseconds: 100));
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<String> _fetchGeminiResponse(String userMessage) async {
    // API key y endpoint de Gemini 2.0 Pro
    const String apiKey = 'AIzaSyBu__Kd-2CcjhLLHcmaC5WgQt4qQA_ypRQ';
    const String endpoint =
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$apiKey';

    final body = jsonEncode({
      'contents': [
        {
          'role': 'user',
          'parts': [
            {'text': '$_medicalContext\n\nUsuario: $userMessage'},
          ],
        },
      ],
    });

    try {
      final res = await http.post(
        Uri.parse(endpoint),
        headers: {
          'Content-Type': 'application/json',
          'User-Agent': 'FlutterApp/1.0',
        },
        body: body,
      );
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        // Gemini puede responder con diferentes estructuras, intentamos extraer el texto principal
        final text = data['candidates']?[0]?['content']?['parts']?[0]?['text'];
        if (text != null && text.toString().trim().isNotEmpty) {
          return text.toString();
        }
        return 'Sin respuesta del asistente.';
      } else if (res.statusCode == 401) {
        return 'Error: API key inválida o sin permisos.';
      } else if (res.statusCode == 404) {
        return 'Error: Endpoint o modelo no encontrado. Verifica el modelo y la URL.';
      } else if (res.statusCode == 429) {
        return 'Error: Límite de uso alcanzado. Intenta más tarde.';
      } else {
        // Intenta mostrar el mensaje de error de la API si existe
        try {
          final errorData = jsonDecode(res.body);
          if (errorData['error']?['message'] != null) {
            return 'Error: ${errorData['error']['message']}';
          }
        } catch (_) {}
        return 'Error: ${res.statusCode}';
      }
    } catch (e) {
      return 'Error de conexión: $e';
    }
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.smart_toy_outlined, size: 26),
            const SizedBox(width: 8),
            Text(
              'Chat Médico',
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isUser = msg.isUser;
                final bubbleColor =
                    isUser
                        ? const Color(0xFF1565C0) // Azul fuerte para usuario
                        : const Color(0xFF263238); // Gris oscuro para bot
                final textColor = Colors.white;
                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: bubbleColor,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft:
                            isUser
                                ? const Radius.circular(16)
                                : const Radius.circular(4),
                        bottomRight:
                            isUser
                                ? const Radius.circular(4)
                                : const Radius.circular(16),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      msg.text,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: textColor,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_isLoading)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'El asistente está escribiendo...',
                    style: GoogleFonts.poppins(),
                  ),
                ],
              ),
            ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      minLines: 1,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: 'Escribe tu consulta médica...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.send_rounded),
                    color: Colors.blue,
                    onPressed: _isLoading ? null : _sendMessage,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatMessage {
  final String text;
  final bool isUser;
  _ChatMessage({required this.text, required this.isUser});
}
