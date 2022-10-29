class SignUp {
  String pharamceyName;
  String doctorName;
  String phoneNumber;
  String address;
  String email;
  String password;
  SignUp(
      {required this.pharamceyName,
      required this.doctorName,
      required this.address,
      required this.email,
      required this.password,
      required this.phoneNumber});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data["pharamceyName"] = this.pharamceyName;
    data["doctorName"] = this.doctorName;
    data["address"] = this.address;
    data["email"] = this.email;
    data["password"] = this.password;
    data["phoneNumber"] = this.phoneNumber;
    return data;
  }
}
