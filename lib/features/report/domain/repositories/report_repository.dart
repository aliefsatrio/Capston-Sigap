class ReportSubmission {
  final String category;
  final String description;
  final String imagePath;
  final double latitude;
  final double longitude;
  final String locationAddress;
  final DateTime timestamp;

  ReportSubmission({
    required this.category,
    required this.description,
    required this.imagePath,
    required this.latitude,
    required this.longitude,
    required this.locationAddress,
    required this.timestamp,
  });
}

abstract class ReportRepository {
  Future<bool> submitReport(ReportSubmission report);
  Future<List<Map<String, dynamic>>> getUserReports();
}

class MockReportRepository implements ReportRepository {
  @override
  Future<bool> submitReport(ReportSubmission report) async {
    // Simulasi pengiriman mock (server simulasi)
    await Future.delayed(const Duration(milliseconds: 500));
    return true;
  }

  @override
  Future<List<Map<String, dynamic>>> getUserReports() async {
    return [
      {
        'id': 'rep-01',
        'title': 'Kecelakaan di depan minimarket',
        'category': 'Kecelakaan',
        'status': 'Menunggu Verifikasi',
        'timestamp': DateTime.now().subtract(const Duration(hours: 1)),
      }
    ];
  }
}
