class UserSignUpBody {
  String? email;
  String? password;
  String? firstName;
  String? lastName;
  String? phone;
  String? birthDate;
  String? gender;

  UserSignUpBody({
    this.email,
    this.password,
    this.firstName,
    this.lastName,
    this.phone,
    this.birthDate,
    this.gender,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'birthDate': birthDate,
      'gender': gender,
    };
  }
}
