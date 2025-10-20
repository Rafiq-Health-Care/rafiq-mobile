class UserSignUpBody {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String phone;
  final int age;
  final String gender;

  UserSignUpBody({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.age,
    required this.gender,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'age': age,
      'gender': gender,
    };
  }
}