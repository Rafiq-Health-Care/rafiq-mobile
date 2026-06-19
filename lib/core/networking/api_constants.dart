class ApiConstants {
  static const String baseURL = "http://192.168.0.104:8030";

  static const String userVerification = "/user/verification";
  static const String registerPatient = "/user/register/patient";
  static const String registerDoctor = "/user/register/doctor";
  static const String newOtp = "/user/new-otp";

  static const String login = "/auth/login";
  static const String authWithGoogle = "/auth/google";
  static const String authRefresh = "/auth/refresh";
  static const String authLogout = "/auth/logout";

  static const String forgetPassword = "/password/forget-password";
  static const String userVerify = "/auth/verify";
  static const String resetPassword = "/password/reset-password";

  static const String specialization = "/specialization";

  static const String labTest = "/lab-test";
  static const String extractLabTestFile = "/file/extract-lab-test";
  static const String getLabTestFile = "/file";
  static const String labTestResults = "/lab-test/test-results";
  static const String updateLabTest = "/lab-test/update";

  static const String drugs = "/drugs";
  static const String medicines = "/medicines";
  static const String addMedicines = "/medicines/add";
  static const String bulkMedicines = "/medicines/bulk";

  static const String group = "/group";
  static const String addGroup = "/group/add";
  static const String addMedicinesToGroup = "/group/addMedicines";
  static const String removeMedicineFromGroup = "/group/removeMedicines";

  static const String doctorSearch = "/doctors/search";
  static const String doctor = "/doctors";
}
