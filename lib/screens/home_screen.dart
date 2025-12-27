import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback? onNavigate;
  const HomeScreen({super.key, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              _buildHeader(),
              const SizedBox(height: 24),
              
              // Online Status
              _buildStatusCard(),
              const SizedBox(height: 24),
              
              // Stats Row
              Row(
                children: [
                   Expanded(
                    child: _buildStatCard(
                      icon: Icons.account_balance_wallet_outlined,
                      iconColor: const Color(0xFF22C55E),
                      label: 'WEEKLY EARNINGS',
                      value: '\$1,250',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.local_shipping_outlined,
                      iconColor: const Color(0xFF22C55E),
                      label: 'JOBS TODAY',
                      value: '5',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              
              // Current Job Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Current Job',
                    style: TextStyle(
                      color: Color(0xFF1E293B),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDCFCE7),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'IN PROGRESS',
                      style: TextStyle(
                        color: Color(0xFF166534),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Current Job Card
              _buildCurrentJobCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 20,
          backgroundColor: Color(0xFFE2E8F0),
          backgroundImage: NetworkImage('https://placeholder.com/150'),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Good Morning,',
              style: TextStyle(color: Color(0xFF64748B), fontSize: 12),
            ),
            const Text(
              'Alex Johnson',
              style: TextStyle(
                color: Color(0xFF1E293B),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Stack(
            children: [
              Icon(Icons.notifications_outlined, color: Color(0xFF1E293B), size: 24),
              Positioned(
                right: 0,
                top: 0,
                child: CircleAvatar(
                  radius: 4,
                  backgroundColor: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: const BoxDecoration(
              color: Color(0xFF22C55E),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'You are Online',
                style: TextStyle(
                  color: Color(0xFF1E293B),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Ready to receive new jobs',
                style: TextStyle(color: const Color(0xFF64748B), fontSize: 12),
              ),
            ],
          ),
          const Spacer(),
          Switch(
            value: true,
            onChanged: (val) {},
            activeColor: Colors.white,
            activeTrackColor: const Color(0xFF22C55E),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(height: 16),
          Text(
            label,
            style: const TextStyle(color: Color(0xFF64748B), fontSize: 10),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF1E293B),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentJobCard() {
    return Container(
      clipBehavior: Clip.antiAlias,
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
      ),
      child: Column(
        children: [
          // Map Section (Mockup)
          Container(
            height: 180,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFFE2E8F0),
              image: DecorationImage(
                image: NetworkImage('https://placeholder.com/map_light'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0.0),
                    Colors.white.withOpacity(0.8),
                  ],
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Job #88291',
                    style: TextStyle(color: Color(0xFF64748B), fontSize: 12),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Distribution Center B',
                        style: TextStyle(
                          color: Color(0xFF1E293B),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: const [
                          Text(
                            '45',
                            style: TextStyle(
                              color: Color(0xFF22C55E),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 4),
                          Text(
                            'min\nETA',
                            style: TextStyle(color: Color(0xFF22C55E), fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Info Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildRouteLine(
                  label: 'PICKUP • 10:30 AM',
                  address: 'Warehouse A, 123 Industrial Blvd',
                  isFirst: true,
                ),
                const SizedBox(height: 16),
                _buildRouteLine(
                  label: 'DROP-OFF • EST. 11:15 AM',
                  address: 'Distribution Center B, 456 Logistics Way',
                  isLast: true,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: onNavigate,
                    icon: const Icon(Icons.navigation),
                    label: const Text('Navigate to Destination'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF22C55E),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRouteLine({
    required String label,
    required String address,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: isLast ? const Color(0xFF22C55E) : const Color(0xFFCBD5E1), width: 2),
                color: isLast ? const Color(0xFF22C55E) : Colors.transparent,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 30,
                color: const Color(0xFFE2E8F0),
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: isLast ? const Color(0xFF22C55E) : const Color(0xFF64748B),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                address,
                style: const TextStyle(color: Color(0xFF1E293B), fontSize: 13),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
