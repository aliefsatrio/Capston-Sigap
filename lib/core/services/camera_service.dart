abstract class CameraService {
  Future<bool> initializeCamera();
  Future<String?> takePicture();
  void dispose();
}

class MockCameraService implements CameraService {
  @override
  Future<bool> initializeCamera() async => true;

  @override
  Future<String?> takePicture() async => 'assets/images/sample_report.jpg';

  @override
  void dispose() {}
}
