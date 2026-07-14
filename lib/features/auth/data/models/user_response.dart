class UserResponse {
  final String roles;

  UserResponse({required this.roles});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(roles: json['role'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'role': roles};
  }
}
