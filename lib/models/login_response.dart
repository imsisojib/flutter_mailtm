class LoginResponse {
  int? code;
  String? message;
  String? id;
  String? token;

  LoginResponse({this.code, this.message, this.id, this.token});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    id = json['id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['id'] = this.id;
    data['token'] = this.token;
    return data;
  }
}