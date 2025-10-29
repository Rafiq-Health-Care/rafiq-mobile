class ChangePasswordRequest {
  final String accessToken;
  final String newPassword;

  ChangePasswordRequest({required this.accessToken, required this.newPassword});

  Map<String, dynamic> toJson() {
    return {'accessToken': accessToken, 'newPassword': newPassword};
  }
}
