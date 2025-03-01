import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String userId;
  final String name;
  final String email;

  const UserEntity({
    required this.userId,
    required this.name,
    required this.email,
  });

  Map<String, Object?> toDocument() {
    return {'userId': userId, 'name': name, 'email': email};
  }

  static UserEntity fromDocument(Map<String, dynamic> doc) {
    return UserEntity(
      userId: doc['userId'],
      name: doc['name'],
      email: doc['email'],
    );
  }

  @override
  List<Object?> get props => [userId, name, email];
}
