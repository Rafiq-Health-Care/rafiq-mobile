class ApiConstants {
  static const String baseURL = "http://192.168.0.104:8030";

  static const String userVerification = "/user/verification";
  static const String registerPatient = "/user/register/patient";
  static const String registerDoctor = "/user/register/doctor";
  static const String newOtp = "/user/new-otp";

  static const String login = "/auth/login";
  static const String authWithGoogle = "/auth/google";

  static const String forgetPassword = "/auth/forget-password";
  static const String userVerify = "/auth/verify";
  static const String changePassword = "/auth/change-password";

  static const String specialization = "/specialization";

  static const String labTest = "/lab-test";
  static const String extractLabTestFile = "/file/extract-lab-test";
  static const String getLabTestFile = "/file";
  static const String labTestResults = "/lab-test/test-results";
  static const String updateLabTest = "/lab-test/update";
}
