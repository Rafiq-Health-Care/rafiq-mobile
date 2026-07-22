class ApiConstants {
  static const String baseURL = "http://192.168.0.104:8030";
  static const String v1 = "/api/v1";

  static const String userVerification = "$v1/user/verification";
  static const String registerPatient = "$v1/user/register/patient";
  static const String registerDoctor = "$v1/user/register/doctor";
  static const String newOtp = "$v1/user/new-otp";

  static const String login = "$v1/auth/login";
  static const String authWithGoogle = "$v1/auth/google";
  static const String authRefresh = "$v1/auth/refresh";
  static const String authLogout = "$v1/auth/logout";

  static const String forgetPassword = "$v1/password/forget-password";
  static const String userVerify = "$v1/auth/verify";
  static const String resetPassword = "$v1/password/reset-password";

  static const String specialization = "$v1/specialization";

  static const String labTest = "$v1/lab-test";
  static const String labTestUpload = "$v1/lab-test/upload";
  static const String updateLabTest = "$v1/lab-test/update";
  static const String labTestResults = "$v1/lab-test/test-results";

  static const String drugs = "$v1/drugs";
  static const String medicine = "$v1/medicine";
  static const String bulkMedicine = "$v1/medicine/bulk";

  static const String group = "$v1/group";
  static const String addMedicinesToGroup = "$v1/group/addMedicines";
  static const String removeMedicineFromGroup = "$v1/group/removeMedicines";

  static const String doctorSearch = "$v1/doctors/search";
  static const String doctor = "$v1/doctors";
  static const String patientSeeDoctorsSlots = "$v1/slot/doctor";
  static const String consultation = "$v1/consultation";
  static const String patientConsultations = "$v1/consultation/patient";
  static String cancelConsultation(String id) => "$v1/consultation/$id/cancel";

  static String getEnterCall(String id) => "$v1/consultations/$id/call/enter";
  static String getLeaveCall(String id) => "$v1/consultations/$id/call/leave";

  static String doctorSchedule = '$v1/slot/schedule/search';
  static String slot = '$v1/slot';
  static String slotHold(String id) => '$v1/slot/$id/hold';
  static String slotRelease(String id) => '$v1/slot/$id/release';

  static const String feedback = "/feedback";
  static String feedbackByDoctor(String doctorId) =>
      "/feedback/doctor/$doctorId";

  // doctor self-profile editing (basic info / bio / price / experience)
  static const String doctorPrice = "$v1/doctors/price";
  static const String doctorBasicInfo = "$v1/doctor/basicInfo";
  static const String doctorBiography = "$v1/doctor/biography";
  static const String doctorExperience = "$v1/doctor/experience";
  static String doctorExperienceById(String expId) =>
      "$v1/doctor/experience/$expId";
}
