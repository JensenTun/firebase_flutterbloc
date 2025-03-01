import 'package:equatable/equatable.dart';
import 'package:firebase_flutterbloc/fetures/authen/entities/user_entity.dart';

class UserModel extends Equatable {
  final String userId;
  final String name;
  final String email;

  const UserModel({
    required this.userId,
    required this.name,
    required this.email,
  });

  static const empty = UserModel(userId: '', name: '', email: '');

  UserModel copyWith({String? userId, String? name, String? email}) {
    return UserModel(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  UserEntity toEntity() {
    return UserEntity(userId: userId, name: name, email: email);
  }

  static UserModel fromEntity(UserEntity entity) {
    return UserModel(
      userId: entity.userId,
      name: entity.name,
      email: entity.email,
    );
  }

  @override
  List<Object?> get props => [userId, name, email];
}
