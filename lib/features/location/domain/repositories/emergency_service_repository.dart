class EmergencyServiceItem {
  final String id;
  final String name;
  final String distance;
  final String category;
  final String phoneNumber;
  final double latitude;
  final double longitude;

  const EmergencyServiceItem({
    required this.id,
    required this.name,
    required this.distance,
    required this.category,
    required this.phoneNumber,
    required this.latitude,
    required this.longitude,
  });
}

abstract class EmergencyServiceRepository {
  Future<List<EmergencyServiceItem>> getNearbyServices();
}

class MockEmergencyServiceRepository implements EmergencyServiceRepository {
  @override
  Future<List<EmergencyServiceItem>> getNearbyServices() async {
    // Sesuai data Figma (Layar Nomor Layanan Terdekat)
    return const [
      EmergencyServiceItem(
        id: '1',
        name: 'Polisi',
        distance: '1,2 km',
        category: 'police',
        phoneNumber: '110',
        latitude: -6.8790,
        longitude: 109.1230,
      ),
      EmergencyServiceItem(
        id: '2',
        name: 'Damkar',
        distance: '2,4 km',
        category: 'fire',
        phoneNumber: '113',
        latitude: -6.8820,
        longitude: 109.1280,
      ),
      EmergencyServiceItem(
        id: '3',
        name: 'Rumah Sakit',
        distance: '1,5 km',
        category: 'hospital',
        phoneNumber: '118',
        latitude: -6.8750,
        longitude: 109.1210,
      ),
      EmergencyServiceItem(
        id: '4',
        name: 'PMI',
        distance: '2,8 km',
        category: 'ambulance',
        phoneNumber: '0283-356123',
        latitude: -6.8840,
        longitude: 109.1300,
      ),
    ];
  }
}
