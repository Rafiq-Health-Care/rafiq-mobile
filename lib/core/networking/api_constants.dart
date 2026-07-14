class ApiConstants {
  static const String baseURL = "http://192.168.0.104:8030/api/v1";

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
  static const String labTestUpload = "/lab-test/upload";
  static const String updateLabTest = "/lab-test/update";
  static const String labTestResults = "/lab-test/test-results";

  static const String drugs = "/drugs";
  static const String medicine = "/medicine";
  static const String bulkMedicine = "/medicine/bulk";

  static const String group = "/group";
  static const String addMedicinesToGroup = "/group/addMedicines";
  static const String removeMedicineFromGroup = "/group/removeMedicines";

  static const String doctorSearch = "/doctors/search";
  static const String doctor = "/doctors";
  static const String patientSeeDoctorsSlots = "/slot/doctor";
  static const String consultation = "/consultation";
  static const String patientConsultations = "/consultation/patient";
  static String cancelConsultation(String id) => "/consultation/$id/cancel";

  static String getEnterCall(String id) => "/consultations/$id/call/enter";
  static String getLeaveCall(String id) => "/consultations/$id/call/leave";

  static String doctorSchedule = '/slot/schedule/search';
  static String slot = '/slot';
}
