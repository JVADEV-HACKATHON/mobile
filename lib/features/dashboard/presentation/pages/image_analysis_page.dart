import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class ImageAnalysisPage extends StatefulWidget {
  const ImageAnalysisPage({super.key});

  @override
  State<ImageAnalysisPage> createState() => _ImageAnalysisPageState();
}

class _ImageAnalysisPageState extends State<ImageAnalysisPage> {
  List<File> _selectedImages = [];
  String? _analysisResult;
  bool _isAnalyzing = false;
  final ImagePicker _picker = ImagePicker();

  static const String _medicalContext = '''
Eres un asistente médico virtual especializado en atención primaria. Tu función es:

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

CONTEXTO MÉDICO: Enfócate en medicina general, síntomas comunes, prevención y educación sanitaria.

INSTRUCCIONES PARA ANÁLISIS DE IMAGEN:
Analiza la imagen médica proporcionada y proporciona:
1. Descripción de lo que observas en la imagen
2. Posibles condiciones médicas que podrían estar relacionadas
3. Nivel de urgencia (leve, moderado, urgente)
4. Recomendaciones generales
5. Cuándo buscar atención médica profesional

IMPORTANTE: Siempre enfatiza que este es un análisis informativo y que se requiere evaluación médica profesional para un diagnóstico definitivo.
''';

  Future<void> _pickImages({bool fromCamera = false}) async {
    try {
      if (fromCamera) {
        final XFile? pickedFile = await _picker.pickImage(
          source: ImageSource.camera,
          maxWidth: 1024,
          maxHeight: 1024,
          imageQuality: 80,
        );
        if (pickedFile != null) {
          setState(() {
            _selectedImages.add(File(pickedFile.path));
            _analysisResult = null;
          });
        }
      } else {
        final List<XFile> pickedFiles = await _picker.pickMultiImage(
          maxWidth: 1024,
          maxHeight: 1024,
          imageQuality: 80,
        );
        if (pickedFiles.isNotEmpty) {
          setState(() {
            _selectedImages.addAll(pickedFiles.map((x) => File(x.path)));
            _analysisResult = null;
          });
        }
      }
    } catch (e) {
      _showErrorDialog('Error al seleccionar imagen: $e');
    }
  }

  Future<void> _analyzeImages() async {
    if (_selectedImages.isEmpty) return;

    setState(() {
      _isAnalyzing = true;
      _analysisResult = null;
    });

    try {
      // Convertir todas las imágenes a base64
      final List<String> base64Images = [];
      for (final file in _selectedImages) {
        final bytes = await file.readAsBytes();
        base64Images.add(base64Encode(bytes));
      }

      final result = await _sendImagesToGemini(base64Images);

      setState(() {
        _analysisResult = result;
        _isAnalyzing = false;
      });
    } catch (e) {
      setState(() {
        _isAnalyzing = false;
      });
      _showErrorDialog('Error al analizar imagen: $e');
    }
  }

  Future<String> _sendImagesToGemini(List<String> base64Images) async {
    // Reemplaza con tu API key de Gemini
    const String apiKey = 'AIzaSyBu__Kd-2CcjhLLHcmaC5WgQt4qQA_ypRQ';
    const String endpoint =
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$apiKey';

    final List<Map<String, dynamic>> imageParts =
        base64Images
            .map(
              (img) => {
                'inline_data': {'mime_type': 'image/jpeg', 'data': img},
              },
            )
            .toList();

    final body = jsonEncode({
      'contents': [
        {
          'role': 'user',
          'parts': [
            {'text': _medicalContext},
            ...imageParts,
          ],
        },
      ],
      'generationConfig': {
        'temperature': 0.4,
        'topK': 32,
        'topP': 1,
        'maxOutputTokens': 2048,
      },
    });

    try {
      final response = await http.post(
        Uri.parse(endpoint),
        headers: {
          'Content-Type': 'application/json',
          'User-Agent': 'FlutterApp/1.0',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final text = data['candidates']?[0]?['content']?['parts']?[0]?['text'];

        if (text != null && text.toString().trim().isNotEmpty) {
          return text.toString();
        }
        return 'No se pudo analizar la imagen. Intenta con otra imagen.';
      } else if (response.statusCode == 401) {
        return 'Error: API key inválida o sin permisos.';
      } else if (response.statusCode == 400) {
        return 'Error: La imagen no es válida o no se pudo procesar.';
      } else if (response.statusCode == 429) {
        return 'Error: Límite de uso alcanzado. Intenta más tarde.';
      } else {
        try {
          final errorData = jsonDecode(response.body);
          if (errorData['error']?['message'] != null) {
            return 'Error: ${errorData['error']['message']}';
          }
        } catch (_) {}
        return 'Error: ${response.statusCode}';
      }
    } catch (e) {
      return 'Error de conexión: $e';
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Error'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Seleccionar imágenes'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Cámara (una por vez)'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickImages(fromCamera: true);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Galería (selección múltiple)'),
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickImages(fromCamera: false);
                  },
                ),
              ],
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.image_search_outlined, size: 26),
            const SizedBox(width: 8),
            Text(
              'Análisis de Imágenes',
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Área de imágenes
            Container(
              height: 120,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child:
                  _selectedImages.isNotEmpty
                      ? ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.all(8),
                        itemCount: _selectedImages.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 8),
                        itemBuilder:
                            (context, idx) => Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    _selectedImages[idx],
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 2,
                                  right: 2,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedImages.removeAt(idx);
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black54,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      )
                      : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image_outlined,
                            size: 60,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No hay imágenes seleccionadas',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
            ),

            const SizedBox(height: 20),

            // Botones de acción
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.add_a_photo),
                    label: const Text('Seleccionar Imágenes'),
                    onPressed: _showImageSourceDialog,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    icon:
                        _isAnalyzing
                            ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                            : const Icon(Icons.analytics),
                    label: Text(_isAnalyzing ? 'Analizando...' : 'Analizar'),
                    onPressed:
                        _selectedImages.isNotEmpty && !_isAnalyzing
                            ? _analyzeImages
                            : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Resultado del análisis
            if (_analysisResult != null) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, right: 8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.blue.shade100,
                      child: Icon(
                        Icons.medical_information,
                        color: Colors.blue.shade700,
                      ),
                      radius: 18,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.07),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                        border: Border.all(color: Colors.blue.shade100),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Análisis Médico',
                            style: GoogleFonts.poppins(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade700,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            _analysisResult!,
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: Colors.black,
                              height: 1.6,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Disclaimer
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning_amber,
                      color: Colors.orange.shade700,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Este análisis es solo informativo. Consulta con un profesional médico para un diagnóstico definitivo.',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.orange.shade800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
