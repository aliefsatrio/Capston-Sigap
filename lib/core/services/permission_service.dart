enum SigapPermissionStatus { granted, denied, permanentlyDenied, restricted }

abstract class PermissionService {
  Future<SigapPermissionStatus> requestLocationPermission();
  Future<SigapPermissionStatus> requestCameraPermission();
  Future<SigapPermissionStatus> requestMicrophonePermission();
  Future<bool> openAppSettings();
}

class MockPermissionService implements PermissionService {
  @override
  Future<SigapPermissionStatus> requestLocationPermission() async =>
      SigapPermissionStatus.granted;

  @override
  Future<SigapPermissionStatus> requestCameraPermission() async =>
      SigapPermissionStatus.granted;

  @override
  Future<SigapPermissionStatus> requestMicrophonePermission() async =>
      SigapPermissionStatus.granted;

  @override
  Future<bool> openAppSettings() async => true;
}
