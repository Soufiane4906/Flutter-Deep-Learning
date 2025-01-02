import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class AnnPage extends StatefulWidget {
  @override
  AnnPageState createState() => AnnPageState();
}

class AnnPageState extends State<AnnPage> with SingleTickerProviderStateMixin {
  Uint8List? _imageBytes;
  String _classificationResult = 'No result yet';
  final ImagePicker _picker = ImagePicker();
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageBytes = bytes;
        _controller.forward().then((_) => _controller.reverse());
      });
    }
  }

  Future<void> _uploadAndClassify() async {
    if (_imageBytes == null) {
      setState(() {
        _classificationResult = 'Please select an image first!';
      });
      return;
    }

    final Uri uri = Uri.parse('http://20.30.0.212:5000/classify_ann');
    try {
      final request = http.MultipartRequest('POST', uri);
      request.files.add(http.MultipartFile.fromBytes(
        'image',
        _imageBytes!,
        filename: 'image.jpg',
        contentType: MediaType('image', 'jpeg'),
      ));

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final Map<String, dynamic> result = jsonDecode(responseData);

        setState(() {
          if (result.containsKey('label')) {
            _classificationResult = 'Classification with ANN: ${result['label']}';
          } else {
            _classificationResult = 'Error: ${result['error']}';
          }
        });
      } else {
        setState(() {
          _classificationResult = 'Failed to classify the image.';
        });
      }
    } catch (e) {
      setState(() {
        _classificationResult = 'Error occurred: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ANN Image Classification'),
        backgroundColor: Colors.deepPurple.shade300,
        elevation: 5,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.deepPurpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _scaleAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: _imageBytes != null
                          ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.memory(
                          _imageBytes!,
                          width: 250,
                          height: 250,
                          fit: BoxFit.cover,
                        ),
                      )
                          : const Icon(Icons.image, size: 200, color: Colors.grey),
                    );
                  },
                ),

                const SizedBox(height: 20),

                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    key: ValueKey<String>(_classificationResult),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple.shade50,
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(blurRadius: 6, color: Colors.black26)],
                    ),
                    child: Text(
                      _classificationResult,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _pickImage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink.shade100,
                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 30),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Pick Image', style: TextStyle(fontSize: 16)),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: _uploadAndClassify,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple.shade200,
                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 30),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text('Classify Image', style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
