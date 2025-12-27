import 'package:flutter/material.dart';

class ActiveJobMapScreen extends StatelessWidget {
  const ActiveJobMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Stack(
        children: [
          // Background Map (Placeholder)
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://placeholder.com/full_map_light'), 
                fit: BoxFit.cover,
                opacity: 0.8,
              ),
            ),
          ),
          
          // Top Buttons
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildCircleButton(Icons.arrow_back, () => Navigator.pop(context)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          border: Border.all(color: const Color(0xFF22C55E).withOpacity(0.2)),
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.circle, color: Color(0xFF22C55E), size: 8),
                            SizedBox(width: 8),
                            Text(
                              'LIVE JOB',
                              style: TextStyle(color: Color(0xFF1E293B), fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      _buildCircleButton(Icons.menu, () {}),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Bottom Sheet
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 20,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE2E8F0),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'SHP-2034',
                            style: TextStyle(
                              color: Color(0xFF1E293B),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Chennai → Bangalore',
                            style: TextStyle(color: Color(0xFF64748B), fontSize: 14),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          Text(
                            'ETA',
                            style: TextStyle(color: Color(0xFF64748B), fontSize: 12),
                          ),
                          Text(
                            '6h 45m',
                            style: TextStyle(
                              color: Color(0xFF22C55E),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.navigation, size: 20),
                          label: const Text('Start Nav', style: TextStyle(fontWeight: FontWeight.bold)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF22C55E),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      _buildSquareActionIconButton(Icons.chat_bubble_outline),
                      const SizedBox(width: 12),
                      _buildSquareActionIconButton(Icons.phone_outlined),
                    ],
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'STATUS PROGRESS',
                    style: TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildStatusItem('Job Accepted', '08:00 AM', true),
                  _buildStatusItem('Reached Pickup', '09:30 AM', true),
                  _buildStatusItem('Cargo Loaded', '10:45 AM', false),
                ],
              ),
            ),
          ),
          
          // GPS Center Button
          Positioned(
            bottom: 380, // Positioned above the bottom sheet
            right: 16,
            child: _buildCircleButton(Icons.my_location, () {}, size: 50, iconColor: const Color(0xFF22C55E)),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleButton(IconData icon, VoidCallback onPressed, {double size = 40, Color? iconColor}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, color: iconColor ?? const Color(0xFF1E293B), size: size * 0.5),
        onPressed: onPressed,
        padding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildSquareActionIconButton(IconData icon) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Icon(icon, color: const Color(0xFF22C55E)),
    );
  }

  Widget _buildStatusItem(String title, String time, bool isCompleted) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: isCompleted ? const Color(0xFF22C55E) : Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(color: isCompleted ? const Color(0xFF22C55E) : const Color(0xFFCBD5E1)),
            ),
            child: isCompleted ? const Icon(Icons.check, color: Colors.white, size: 12) : null,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: isCompleted ? const Color(0xFF1E293B) : const Color(0xFF64748B), 
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  time,
                  style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
