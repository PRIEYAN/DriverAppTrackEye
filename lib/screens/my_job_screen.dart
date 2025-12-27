import 'package:flutter/material.dart';
import 'job_details_screen.dart';

class MyJobScreen extends StatelessWidget {
  const MyJobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildHeader(),
              const SizedBox(height: 20),
              _buildTabSection(),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    _buildJobCard(
                      context,
                      shipmentId: '#SHP-1234',
                      status: 'IN TRANSIT',
                      statusColor: const Color(0xFF22C55E),
                      pickup: '123 Industrial Park, NY',
                      pickupTime: '10:30 AM • Today',
                      dropoff: '456 Main St, Newark, NJ',
                      dropoffTime: 'Est. Arrival: 2:45 PM',
                      earnings: '\$450.00',
                      isActive: true,
                    ),
                    const SizedBox(height: 16),
                    _buildJobCard(
                      context,
                      shipmentId: '#SHP-8829',
                      status: 'PENDING',
                      statusColor: Colors.orange,
                      pickup: '789 Warehouse Blvd, PA',
                      pickupTime: 'Scheduled: Tomorrow, 8:00 AM',
                      dropoff: '101 Retail Row, Scranton, PA',
                      dropoffTime: '',
                      earnings: '\$120.00',
                      isActive: false,
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

  Widget _buildHeader() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 20,
          backgroundColor: Color(0xFFE2E8F0),
          backgroundImage: NetworkImage('https://placeholder.com/150'),
        ),
        const SizedBox(width: 12),
        const Text(
          'My Jobs',
          style: TextStyle(
            color: Color(0xFF1E293B),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        Container(
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
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings_outlined, color: Color(0xFF1E293B)),
          ),
        ),
      ],
    );
  }

  Widget _buildTabSection() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFE2E8F0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF22C55E),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  'Active Jobs',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: const Center(
                child: Text(
                  'Completed',
                  style: TextStyle(
                    color: Color(0xFF64748B),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobCard(
    BuildContext context, {
    required String shipmentId,
    required String status,
    required Color statusColor,
    required String pickup,
    required String pickupTime,
    required String dropoff,
    required String dropoffTime,
    required String earnings,
    required bool isActive,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Shipment ID',
                    style: TextStyle(color: Color(0xFF64748B), fontSize: 12),
                  ),
                  Text(
                    shipmentId,
                    style: const TextStyle(
                      color: Color(0xFF1E293B),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: statusColor.withOpacity(0.2), width: 1),
                ),
                child: Row(
                  children: [
                    Icon(Icons.circle, color: statusColor, size: 8),
                    const SizedBox(width: 6),
                    Text(
                      status,
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    _buildRouteItem(
                      icon: Icons.radio_button_checked,
                      color: const Color(0xFF22C55E),
                      label: 'Picked up from',
                      address: pickup,
                      time: pickupTime,
                    ),
                    const SizedBox(height: 10),
                    _buildRouteItem(
                      icon: Icons.location_on,
                      color: Colors.redAccent,
                      label: 'Drop-off at',
                      address: dropoff,
                      time: dropoffTime,
                      isLast: true,
                    ),
                  ],
                ),
              ),
              if (isActive)
                Container(
                  width: 80,
                  height: 100,
                  margin: const EdgeInsets.only(left: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color(0xFFE2E8F0),
                    image: const DecorationImage(
                      image: NetworkImage('https://placeholder.com/map_thumb_light'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
            ],
          ),
          const Divider(color: Color(0xFFF1F5F9), height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Est. Earnings',
                    style: TextStyle(color: Color(0xFF64748B), fontSize: 12),
                  ),
                  Text(
                    earnings,
                    style: const TextStyle(
                      color: Color(0xFF166534),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const JobDetailsScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isActive ? const Color(0xFF22C55E) : const Color(0xFFF1F5F9),
                  foregroundColor: isActive ? Colors.white : const Color(0xFF64748B),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: const Size(130, 48),
                ),
                child: Row(
                  children: [
                    Text(isActive ? 'View Details' : 'Details'),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward, size: 16),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRouteItem({
    required IconData icon,
    required Color color,
    required String label,
    required String address,
    required String time,
    bool isLast = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(icon, color: color, size: 16),
            if (!isLast)
              Container(
                width: 1,
                height: 40,
                color: const Color(0xFFE2E8F0),
              ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(color: Color(0xFF64748B), fontSize: 11),
              ),
              Text(
                address,
                style: const TextStyle(
                  color: Color(0xFF1E293B),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (time.isNotEmpty)
                Text(
                  time,
                  style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 11),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
