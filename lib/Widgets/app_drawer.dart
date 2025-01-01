import 'package:flutter/material.dart';
import '../pages/profile_page.dart';
import '../pages/stock.dart';
import '../pages/voice_recognition_page.dart';
import '../pages/cnn_page.dart';
import '../pages/ann_page.dart';
import '../pages/settings_page.dart';

class AppDrawer extends StatelessWidget {
  final String name;
  final String email;

  const AppDrawer({super.key, required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple.shade50,
              Colors.white,
            ],
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 50, bottom: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple.shade400, Colors.purple.shade200],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurple.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, size: 50, color: Colors.deepPurple.shade400),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    name.isNotEmpty ? name : 'Guest User',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [Shadow(color: Colors.black26, blurRadius: 2, offset: Offset(0, 2))],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    email.isNotEmpty ? email : 'guest@example.com',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                      shadows: [Shadow(color: Colors.black26, blurRadius: 2, offset: Offset(0, 1))],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 10),
                children: [
                  _buildListTile(
                    context,
                    icon: Icons.person,
                    title: "Profile",
                    color: Colors.blue,
                    onTap: () => _navigateTo(context, ProfilePage(name: name, email: email)),
                  ),
                  _buildExpansionTile(
                    context,
                    icon: Icons.image,
                    title: "Image Classification",
                    subtitle: "Fashion MNIST",
                    color: Colors.deepPurple,
                    children: [
                      _buildSubListTile(
                        context,
                        title: "ANN",
                        onTap: () => _navigateTo(context, AnnPage()),
                      ),
                      _buildSubListTile(
                        context,
                        title: "CNN",
                        onTap: () => _navigateTo(context, CnnPage()),
                      ),
                    ],
                  ),
                  _buildListTile(
                    context,
                    icon: Icons.trending_up,
                    title: "Stock Price Prediction",
                    color: Colors.green,
                    onTap: () => _navigateTo(context, StockPredictionPage()),
                  ),
                  _buildListTile(
                    context,
                    icon: Icons.mic,
                    title: "Voice Recognition",
                    color: Colors.purple,
                    onTap: () => _navigateTo(context, VoiceRecognitionPage()),
                  ),
                  _buildListTile(
                    context,
                    icon: Icons.lightbulb,
                    title: "Rag",
                    color: Colors.orange,
                    onTap: () {
                      Navigator.pop(context);
                      // TODO: Navigate to Rag screen
                    },
                  ),
                  const Divider(height: 1),
                  _buildListTile(
                    context,
                    icon: Icons.settings,
                    title: "Settings",
                    color: Colors.grey,
                    onTap: () => _navigateTo(context, SettingsPage()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey.shade600),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Widget _buildExpansionTile(BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required List<Widget> children,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ExpansionTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
        ),
        children: children,
      ),
    );
  }

  Widget _buildSubListTile(BuildContext context, {
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 72, right: 16),
      title: Text(
        title,
        style: const TextStyle(fontSize: 15),
      ),
      onTap: onTap,
    );
  }

  void _navigateTo(BuildContext context, Widget page) {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
}