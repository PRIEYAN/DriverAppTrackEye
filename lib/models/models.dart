class Driver {
  final String id;
  final String username;
  final String email;
  final String? phone;
  final bool isActive;

  Driver({
    required this.id,
    required this.username,
    required this.email,
    this.phone,
    required this.isActive,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json['id']?.toString() ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      isActive: json['is_active'] ?? true,
    );
  }
}

class Shipment {
  final String id;
  final String shipmentNumber;
  final String? originPort;
  final String? destinationPort;
  final double? originLatitude;
  final double? originLongitude;
  final double? destinationLatitude;
  final double? destinationLongitude;
  final double? quoteAmount;
  final String? status;
  final String? cargoType;
  final String? containerType;
  final int? containerQty;
  final double? grossWeightKg;
  final double? volumeCbm;

  Shipment({
    required this.id,
    required this.shipmentNumber,
    this.originPort,
    this.destinationPort,
    this.originLatitude,
    this.originLongitude,
    this.destinationLatitude,
    this.destinationLongitude,
    this.quoteAmount,
    this.status,
    this.cargoType,
    this.containerType,
    this.containerQty,
    this.grossWeightKg,
    this.volumeCbm,
  });

  factory Shipment.fromJson(Map<String, dynamic> json) {
    return Shipment(
      id: json['id']?.toString() ?? '',
      shipmentNumber: json['shipment_number'] ?? '',
      originPort: json['origin_port'],
      destinationPort: json['destination_port'],
      originLatitude: json['origin_latitude']?.toDouble(),
      originLongitude: json['origin_longitude']?.toDouble(),
      destinationLatitude: json['destination_latitude']?.toDouble(),
      destinationLongitude: json['destination_longitude']?.toDouble(),
      quoteAmount: json['quote_amount'] != null 
          ? (json['quote_amount'] is num ? json['quote_amount'].toDouble() : double.tryParse(json['quote_amount'].toString()))
          : null,
      status: json['status'],
      cargoType: json['cargo_type'],
      containerType: json['container_type'],
      containerQty: json['container_qty'],
      grossWeightKg: json['gross_weight_kg'] != null
          ? (json['gross_weight_kg'] is num ? json['gross_weight_kg'].toDouble() : double.tryParse(json['gross_weight_kg'].toString()))
          : null,
      volumeCbm: json['volume_cbm'] != null
          ? (json['volume_cbm'] is num ? json['volume_cbm'].toDouble() : double.tryParse(json['volume_cbm'].toString()))
          : null,
    );
  }
}

