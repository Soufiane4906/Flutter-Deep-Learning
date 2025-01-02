import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import '../widgets/app_drawer.dart';
import '../pages/voice_recognition_page.dart';
import '../pages/stock.dart';
import '../pages/cnn_page.dart';
import '../pages/ann_page.dart';
import '../pages/profile_page.dart';

class HomePage extends StatelessWidget {
  final String name;
  final String email;

  const HomePage({super.key, required this.name, required this.email});

  void _openPdfViewer(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PDFViewerPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text("AI Hub", style: TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white,
        )),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple.shade400, Colors.purple.shade200],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      drawer: AppDrawer(name: name, email: email),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurple.shade50, Colors.white],
          ),
        ),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Welcome back,', style: TextStyle(fontSize: 16, color: Colors.grey.shade600)),
                      const SizedBox(height: 8),
                      Text(name.isNotEmpty ? name : 'Guest User', style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87,
                      )),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => _openPdfViewer(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('View Tutorial', style: TextStyle(fontSize: 16, color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.85,
                  ),
                  delegate: SliverChildListDelegate([
                    _buildFeatureCard(context, "Profile", "Manage account", Icons.person, Colors.blue,
                            () => _navigateTo(context, ProfilePage(name: name, email: email))),
                    _buildFeatureCard(context, "Voice Recognition", "Speech to text", Icons.mic, Colors.purple,
                            () => _navigateTo(context, VoiceRecognitionPage())),
                    _buildFeatureCard(context, "Stock Prediction", "Market analysis", Icons.trending_up, Colors.green,
                            () => _navigateTo(context, StockPredictionPage())),
                    _buildFeatureCard(context, "ANN", "Neural network", Icons.image, Colors.orange,
                            () => _navigateTo(context, AnnPage())),
                    _buildFeatureCard(context, "CNN", "Image classification", Icons.image_search, Colors.red,
                            () => _navigateTo(context, CnnPage())),
                  ]),
                ),
              ),
              const SliverPadding(padding: EdgeInsets.only(bottom: 20)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, String title, String description,
      IconData icon, Color color, VoidCallback onTap) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool isHovered = false;

        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: isHovered ? color.withOpacity(0.2) : Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onTap,
                  splashColor: color.withOpacity(0.1),
                  highlightColor: color.withOpacity(0.05),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Icon(icon, size: 30, color: color),
                        ),
                        const SizedBox(height: 12),
                        Text(title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center),
                        const SizedBox(height: 6),
                        Text(description,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
}

class PDFViewerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tutorial PDF'),
        backgroundColor: Colors.deepPurple.shade300,
      ),
      body: FutureBuilder<String>(
        future: _loadPdfFromAssets(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading PDF: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return PDFView(
              filePath: snapshot.data!,
            );
          } else {
            return const Center(child: Text('No PDF found.'));
          }
        },
      ),
    );
  }

  Future<String> _loadPdfFromAssets() async {
    final ByteData bytes = await rootBundle.load('assets/tuto.pdf');
    final String dir = (await getTemporaryDirectory()).path;
    final String filePath = '$dir/tuto.pdf';
    final File file = File(filePath);
    await file.writeAsBytes(bytes.buffer.asUint8List());
    return filePath;
  }
}
