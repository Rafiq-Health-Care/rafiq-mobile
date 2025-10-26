class UserResponse {
  final List<String> roles;
  final String refreshToken;

  UserResponse({required this.roles, required this.refreshToken});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      roles: List<String>.from(json['roles']),
      refreshToken: json['refreshToken'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'roles': roles, 'refreshToken': refreshToken};
  }
}
