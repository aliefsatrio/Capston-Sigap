abstract class LocationService {
  Future<Map<String, dynamic>> getCurrentCoordinates();
  Future<String> getCurrentAddress();
  Future<bool> isGpsEnabled();
}

class MockLocationService implements LocationService {
  @override
  Future<Map<String, dynamic>> getCurrentCoordinates() async {
    // Deterministic fixture coordinates from Figma
    return {
      'latitude': -6.8797,
      'longitude': 109.1256,
      'accuracy': '± 3m (Tinggi)',
    };
  }

  @override
  Future<String> getCurrentAddress() async {
    return 'Jl. Pemuda No. 42, Tegal';
  }

  @override
  Future<bool> isGpsEnabled() async {
    return true;
  }
}
