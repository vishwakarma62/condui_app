class AuthModel {
  String? email;
  String? username;
  String? password;
  String? bio;
  String? image;
  String? token;

  AuthModel(
      {this.email,
      this.username,
      this.password,
      this.bio,
      this.image,
      this.token});

  AuthModel.fromJson(Map<String, dynamic> json) {
    this.email = json['email'];
    this.username = json['username'];
    this.password = json['password'];
    this.bio = json['bio'];
    this.image = json['image'];
    this.token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['username'] = this.username;
    data['password'] = this.password;
    data['bio'] = this.bio;
    data['image'] = this.image;
    data['token'] = this.token;
    return data;
  }
}
