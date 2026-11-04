abstract class AuthRepository {
  Future<bool> register({
    required String fullName,
    required String phoneNumber,
    required String email,
    required String password,
    required String emergencyContactName,
    required String emergencyContactPhone,
    required String emergencyRelation,
  });

  Future<bool> login({
    required String identifier,
    required String password,
    required bool rememberMe,
  });

  Future<bool> verifyOtp({
    required String phoneNumber,
    required String otpCode,
  });

  Future<bool> resendOtp({
    required String phoneNumber,
    required String channel, // 'whatsapp' | 'sms'
  });

  Future<void> logout();
}

class MockAuthRepository implements AuthRepository {
  @override
  Future<bool> register({
    required String fullName,
    required String phoneNumber,
    required String email,
    required String password,
    required String emergencyContactName,
    required String emergencyContactPhone,
    required String emergencyRelation,
  }) async {
    // Simulasi server response berhasil
    await Future.delayed(const Duration(milliseconds: 300));
    return true;
  }

  @override
  Future<bool> login({
    required String identifier,
    required String password,
    required bool rememberMe,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return true;
  }

  @override
  Future<bool> verifyOtp({
    required String phoneNumber,
    required String otpCode,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // Validasi simulasi: 6 digit kode
    return otpCode.length == 6;
  }

  @override
  Future<bool> resendOtp({
    required String phoneNumber,
    required String channel,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return true;
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 200));
  }
}
