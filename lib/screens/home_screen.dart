import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/models.dart';
import '../core/auth_storage.dart';
import '../widgets/shipment_map_widget.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback? onNavigate;
  const HomeScreen({super.key, this.onNavigate});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _apiService = ApiService();
  Driver? _driver;
  Shipment? _currentShipment;
  bool _isLoading = true;
  bool _isOnline = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Load driver profile
      final driver = await _apiService.getMyProfile();
      
      // Load current shipment
      final shipment = await _apiService.getMyShipments();
      
      setState(() {
        _driver = driver;
        _currentShipment = shipment;
        _isLoading = false;
      });
    } catch (e) {
      // If error, still show the screen but with limited data
      setState(() {
        _isLoading = false;
      });
    }
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  String _getWeeklyEarnings() {
    // For now, calculate from current shipment quote amount
    // In future, this can come from a dedicated earnings endpoint
    if (_currentShipment?.quoteAmount != null) {
      return '\$${_currentShipment!.quoteAmount!.toStringAsFixed(2)}';
    }
    return '\$0.00';
  }

  String _getJobsToday() {
    // For now, show 1 if there's a current shipment, 0 otherwise
    // In future, this can come from a jobs count endpoint
    return _currentShipment != null ? '1' : '0';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _loadData,
          color: const Color(0xFF22C55E),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: _isLoading
                ? const SizedBox(
                    height: 400,
                    child: Center(child: CircularProgressIndicator()),
                  )
                : Column(
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
                              value: _getWeeklyEarnings(),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _buildStatCard(
                              icon: Icons.local_shipping_outlined,
                              iconColor: const Color(0xFF22C55E),
                              label: 'JOBS TODAY',
                              value: _getJobsToday(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      
                      // Current Job Title
                      if (_currentShipment != null) ...[
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
                                color: _getStatusColor(_currentShipment!.status),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                _getStatusText(_currentShipment!.status),
                                style: const TextStyle(
                                  color: Colors.white,
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
                      ] else ...[
                        Container(
                          padding: const EdgeInsets.all(24),
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
                            children: [
                              Icon(Icons.inbox_outlined, size: 64, color: Colors.grey[400]),
                              const SizedBox(height: 16),
                              const Text(
                                'No Active Job',
                                style: TextStyle(
                                  color: Color(0xFF1E293B),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'You don\'t have any active shipments assigned',
                                style: TextStyle(color: Colors.grey[600], fontSize: 14),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String? status) {
    if (status == null) return const Color(0xFFDCFCE7);
    switch (status.toLowerCase()) {
      case 'in_transit':
      case 'booked':
        return const Color(0xFFDCFCE7); // Green
      case 'pending':
      case 'quoted':
        return Colors.orange.withOpacity(0.2);
      default:
        return const Color(0xFFDCFCE7);
    }
  }

  String _getStatusText(String? status) {
    if (status == null) return 'ASSIGNED';
    switch (status.toLowerCase()) {
      case 'in_transit':
        return 'IN TRANSIT';
      case 'booked':
        return 'IN PROGRESS';
      case 'pending':
        return 'PENDING';
      case 'quoted':
        return 'QUOTED';
      default:
        return status.toUpperCase();
    }
  }

  Widget _buildHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: const Color(0xFFE2E8F0),
          child: Text(
            _driver?.username.substring(0, 1).toUpperCase() ?? 'D',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${_getGreeting()},',
              style: const TextStyle(color: Color(0xFF64748B), fontSize: 12),
            ),
            Text(
              _driver?.username ?? 'Driver',
              style: const TextStyle(
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
            value: _isOnline,
            onChanged: (val) {
              setState(() {
                _isOnline = val;
              });
            },
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
    if (_currentShipment == null) {
      return const SizedBox.shrink();
    }

    final shipment = _currentShipment!;
    
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
          // Map Section
          ShipmentMapWidget(
            pickupLocation: shipment.originPort ?? 'Origin',
            dropLocation: shipment.destinationPort ?? 'Destination',
            pickupLatitude: shipment.originLatitude,
            pickupLongitude: shipment.originLongitude,
            dropLatitude: shipment.destinationLatitude,
            dropLongitude: shipment.destinationLongitude,
          ),
          // Info Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        shipment.destinationPort ?? 'Destination',
                        style: const TextStyle(
                          color: Color(0xFF1E293B),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (shipment.quoteAmount != null)
                        Row(
                          children: [
                            Text(
                              '\$${shipment.quoteAmount!.toStringAsFixed(0)}',
                              style: const TextStyle(
                                color: Color(0xFF22C55E),
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              '\nEarnings',
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
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildRouteLine(
                  label: 'PICKUP',
                  address: shipment.originPort ?? 'Origin Port',
                  isFirst: true,
                ),
                const SizedBox(height: 16),
                _buildRouteLine(
                  label: 'DROP-OFF',
                  address: shipment.destinationPort ?? 'Destination Port',
                  isLast: true,
                ),
                if (shipment.grossWeightKg != null || shipment.volumeCbm != null) ...[
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      if (shipment.grossWeightKg != null)
                        Expanded(
                          child: _buildInfoChip(
                            Icons.scale,
                            'Weight: ${shipment.grossWeightKg!.toStringAsFixed(1)} kg',
                          ),
                        ),
                      if (shipment.volumeCbm != null) ...[
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildInfoChip(
                            Icons.inventory_2,
                            'Volume: ${shipment.volumeCbm!.toStringAsFixed(1)} CBM',
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: widget.onNavigate,
                    icon: const Icon(Icons.navigation),
                    label: const Text('View Job Details'),
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

  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: const Color(0xFF64748B)),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF64748B),
              fontWeight: FontWeight.w500,
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
