import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';
import '../models/models.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ApiService _apiService = ApiService();
  final AuthService _authService = AuthService();
  Driver? _driver;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final driver = await _apiService.getMyProfile();
      setState(() {
        _driver = driver;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        // Clean up error message
        String errorMsg = e.toString();
        if (errorMsg.contains('401') || errorMsg.contains('Unauthorized')) {
          errorMsg = 'Please login to view your profile';
        } else {
          errorMsg = errorMsg.replaceAll('Exception: ', '');
        }
        _error = errorMsg;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryGreen = Color(0xFF22C55E);
    const Color textSlate = Color(0xFF1E293B);
    const Color subTextSlate = Color(0xFF64748B);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              _buildProfileHeader(primaryGreen, textSlate, subTextSlate),
              const SizedBox(height: 30),
              _buildStatsRow(primaryGreen, textSlate),
              const SizedBox(height: 30),
              _buildMenuSection(textSlate, subTextSlate),
              const SizedBox(height: 30),
              _buildLogoutButton(primaryGreen),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(Color primary, Color text, Color subText) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    
    if (_error != null) {
      return Center(
        child: Column(
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'Error: $_error',
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: _loadProfile,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: primary, width: 3),
              ),
              child: CircleAvatar(
                radius: 60,
                backgroundColor: const Color(0xFFE2E8F0),
                child: Text(
                  _driver?.username.substring(0, 1).toUpperCase() ?? 'D',
                  style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                ),
                child: Icon(Icons.edit, color: primary, size: 20),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          _driver?.username ?? 'Driver',
          style: TextStyle(color: text, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          _driver?.email ?? '',
          style: TextStyle(color: subText, fontSize: 14),
        ),
        if (_driver?.phone != null && _driver!.phone!.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            _driver!.phone!,
            style: TextStyle(color: subText, fontSize: 14),
          ),
        ],
      ],
    );
  }

  Widget _buildStatsRow(Color primary, Color text) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('Ratings', '4.9', Icons.star, Colors.orange),
          _buildSeparator(),
          _buildStatItem('Total Jobs', '1,240', Icons.local_shipping, primary),
          _buildSeparator(),
          _buildStatItem('Exp.', '5 Yrs', Icons.timer, Colors.blue),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 8),
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  Widget _buildSeparator() {
    return Container(height: 30, width: 1, color: const Color(0xFFE2E8F0));
  }

  Widget _buildMenuSection(Color text, Color subText) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Column(
        children: [
          _buildMenuItem(Icons.person_outline, 'Personal Information', text),
          _buildDivider(),
          _buildMenuItem(Icons.account_balance_wallet_outlined, 'Earnings History', text),
          _buildDivider(),
          _buildMenuItem(Icons.article_outlined, 'Documents & License', text),
          _buildDivider(),
          _buildMenuItem(Icons.settings_outlined, 'Settings', text),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, Color text) {
    return ListTile(
      leading: Icon(icon, color: text, size: 22),
      title: Text(title, style: TextStyle(color: text, fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
    );
  }

  Widget _buildDivider() {
    return const Divider(height: 1, color: Color(0xFFF1F5F9), indent: 20, endIndent: 20);
  }

  Widget _buildLogoutButton(Color primary) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextButton(
        onPressed: () async {
          await _authService.logout();
          if (mounted) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false,
            );
          }
        },
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          minimumSize: const Size(double.infinity, 50),
          foregroundColor: Colors.red,
        ),
        child: const Text('Sign Out', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
