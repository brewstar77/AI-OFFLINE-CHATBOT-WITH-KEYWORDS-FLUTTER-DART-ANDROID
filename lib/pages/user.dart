// Example User class (ensure this matches your definition)
class User {
  final String? username;
  final String? firstName;
  final String? surname;
  final String? sex;
  final String? age;
  final String? stage;
  final String? school;

  User({
    this.username,
    this.firstName,
    this.surname,
    this.sex,
    this.age,
    this.stage,
    this.school,
  });

  String get fullName {
    if (firstName == null && surname == null) return '';
    return '${firstName ?? ''} ${surname ?? ''}'.trim();
  }
}