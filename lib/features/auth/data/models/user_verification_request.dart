class UserVerificationRequest {
  final String email;
  final String otp;

  UserVerificationRequest({required this.email, required this.otp});

  factory UserVerificationRequest.fromJson(Map<String, dynamic> json) {
    return UserVerificationRequest(
      email: json['email'] as String,
      otp: json['otp'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'otp': otp};
  }
}
