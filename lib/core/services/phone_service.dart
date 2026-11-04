abstract class PhoneService {
  Future<bool> makeCall(String phoneNumber);
  Future<bool> sendEmergencySms(String phoneNumber, String message);
}

class MockPhoneService implements PhoneService {
  @override
  Future<bool> makeCall(String phoneNumber) async {
    // Mode demo / simulasi: tidak membuat panggilan sungguhan
    return true;
  }

  @override
  Future<bool> sendEmergencySms(String phoneNumber, String message) async {
    // Mode demo / simulasi: tidak mengirim SMS sungguhan
    return true;
  }
}
