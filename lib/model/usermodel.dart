import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String name;
  String email;
  String uId;
  String? role;
  UserModel({
    required this.name,
    required this.email,
    required this.uId,
    this.role,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? uId,
    String? role,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      uId: uId ?? this.uId,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'uId': uId,
      'role': role,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      uId: map['uId'] ?? '',
      role: map['role'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'UserModel(name: $name, email: $email, uId: $uId, role: $role)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.name == name &&
        other.email == email &&
        other.uId == uId &&
        other.role == role;
  }

  @override
  int get hashCode =>
      name.hashCode ^ email.hashCode ^ uId.hashCode ^ role.hashCode;

  static UserModel? fromFirebaseUser(User user) {}
}
