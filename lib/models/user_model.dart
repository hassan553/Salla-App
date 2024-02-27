// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  bool? status;
  String? message;
  Data? data;
  UserModel({this.status, this.message, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? name;
  String? phone;
  String? email;
  int? id;
  String? image;
  String? token;

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    id = json['id'];
    image = json['image'];
    token = json['token'];
  }
}
