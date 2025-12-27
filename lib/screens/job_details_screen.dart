import 'package:flutter/material.dart';
import 'active_job_map_screen.dart';

class JobDetailsScreen extends StatelessWidget {
  const JobDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              _buildAppBar(context),
              const SizedBox(height: 30),
              _buildTimerSection(),
              const SizedBox(height: 30),
              _buildJobAlertCard(),
              const SizedBox(height: 30),
              _buildEarningsSection(),
              const SizedBox(height: 30),
              _buildActionButtons(context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF22C55E).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.local_shipping, color: Color(0xFF22C55E)),
        ),
        const SizedBox(width: 12),
        const Text(
          'TradeFlow Driver',
          style: TextStyle(
            color: Color(0xFF1E293B),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        const CircleAvatar(
          radius: 18,
          backgroundColor: Color(0xFFE2E8F0),
          child: Icon(Icons.lightbulb_outline, color: Color(0xFF22C55E), size: 20),
        ),
      ],
    );
  }

  Widget _buildTimerSection() {
    return Center(
      child: Column(
        children: [
          const Text(
            'OFFER EXPIRES IN',
            style: TextStyle(color: Color(0xFF64748B), fontSize: 12, letterSpacing: 1, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTimerBox('02', 'MIN'),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(':', style: TextStyle(color: Color(0xFF22C55E), fontSize: 30, fontWeight: FontWeight.bold)),
              ),
              _buildTimerBox('30', 'SEC'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimerBox(String value, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF22C55E).withOpacity(0.2)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            value,
            style: const TextStyle(
              color: Color(0xFF22C55E),
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Color(0xFF64748B), fontSize: 10, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildJobAlertCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'New Transport Job',
                    style: TextStyle(
                      color: Color(0xFF1E293B),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Shipment ID: SHP-2034',
                    style: TextStyle(color: Color(0xFF64748B), fontSize: 13),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFDCFCE7),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'NEW',
                  style: TextStyle(color: Color(0xFF166534), fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildJobInfoItem(Icons.crop_free, 'Container', '40ft'),
              _buildJobInfoItem(Icons.inventory_2_outlined, 'Cargo', 'FMCG'),
              _buildJobInfoItem(Icons.scale_outlined, 'Weight', '12 Tons'),
            ],
          ),
          const SizedBox(height: 32),
          _buildRouteLine(),
          const SizedBox(height: 24),
          // Map Placeholder
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color(0xFFE2E8F0),
              image: const DecorationImage(
                image: NetworkImage('https://placeholder.com/map_alert_light'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobInfoItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF22C55E), size: 20),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Color(0xFF64748B), fontSize: 11)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(color: Color(0xFF1E293B), fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildRouteLine() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(color: const Color(0xFFDCFCE7), shape: BoxShape.circle),
              child: const Icon(Icons.radio_button_checked, color: Color(0xFF22C55E), size: 16),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('PICKUP', style: TextStyle(color: Color(0xFF64748B), fontSize: 10, fontWeight: FontWeight.bold)),
                  const Text('Chennai Port - Gate 3', style: TextStyle(color: Color(0xFF1E293B), fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Row(
                    children: const [
                      Icon(Icons.location_on, color: Color(0xFF94A3B8), size: 12),
                      SizedBox(width: 4),
                      Text('345 km', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 14),
          child: Container(width: 1, height: 30, color: const Color(0xFFE2E8F0)),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(color: const Color(0xFFFEE2E2), shape: BoxShape.circle),
              child: const Icon(Icons.location_on, color: Colors.red, size: 16),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('DROP OFF', style: TextStyle(color: Color(0xFF64748B), fontSize: 10, fontWeight: FontWeight.bold)),
                  const Text('Bangalore Warehouse', style: TextStyle(color: Color(0xFF1E293B), fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Row(
                    children: const [
                      Icon(Icons.access_time, color: Color(0xFF94A3B8), size: 12),
                      SizedBox(width: 4),
                      Text('ETA: 6 hrs 45 mins', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEarningsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Total Earnings', style: TextStyle(color: Color(0xFF64748B), fontSize: 14)),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '₹ 18,000',
              style: TextStyle(color: Color(0xFF166534), fontSize: 32, fontWeight: FontWeight.bold),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildChip(Icons.local_gas_station, 'Fuel Incl.'),
                const SizedBox(height: 6),
                _buildChip(Icons.phone_android, 'Toll Incl.'),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: const Color(0xFF64748B), size: 12),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(color: Color(0xFF64748B), fontSize: 10)),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: TextButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close, color: Color(0xFF64748B), size: 18),
            label: const Text('Decline', style: TextStyle(color: Color(0xFF64748B), fontSize: 16)),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 18),
              backgroundColor: const Color(0xFFF1F5F9),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ActiveJobMapScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF22C55E),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Accept Job', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
