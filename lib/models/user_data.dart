import 'package:todo/core/enums/auth_type.dart';

class UserData {
  final String? uid;
  final String? name;
  final String? email;
  final AuthType? authType;
  final DateTime? createdAt;

  UserData({
    this.uid,
    this.name,
    this.email,
    this.authType,
    this.createdAt,
  });

  UserData copyWith({
    String? uid,
    String? name,
    String? email,
    AuthType? authType,
    DateTime? createdAt,
  }) {
    return UserData(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      authType: authType ?? this.authType,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'email': email,
      'authType': authType?.index,
      'createdAt': createdAt?.millisecondsSinceEpoch,
    };
  }

  factory UserData.fromMap(map) {
    return UserData(
      uid: map['uid'] != null ? map['uid'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      authType: authTypeMap[map['authType']],
      createdAt: map['createdAt'] != null ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int) : null,
    );
  }
}
