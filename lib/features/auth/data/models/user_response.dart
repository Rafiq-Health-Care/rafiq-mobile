class UserResponse {
  final String userId;
  final String role;

  UserResponse({required this.userId, required this.role});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(userId: json['userId'], role: json['role']);
  }
}
