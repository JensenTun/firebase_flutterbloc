// Mocks generated by Mockito 5.4.5 from annotations
// in firebase_flutterbloc/test/sign_in_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:firebase_auth/firebase_auth.dart' as _i5;
import 'package:firebase_flutterbloc/fetures/authen/model/user.dart' as _i2;
import 'package:firebase_flutterbloc/fetures/authen/service/user_repo.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeUserModel_0 extends _i1.SmartFake implements _i2.UserModel {
  _FakeUserModel_0(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

/// A class which mocks [UserRepo].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserRepo extends _i1.Mock implements _i3.UserRepo {
  MockUserRepo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Stream<_i5.User?> get user =>
      (super.noSuchMethod(
            Invocation.getter(#user),
            returnValue: _i4.Stream<_i5.User?>.empty(),
          )
          as _i4.Stream<_i5.User?>);

  @override
  _i4.Future<_i2.UserModel> signUp(_i2.UserModel? user, String? password) =>
      (super.noSuchMethod(
            Invocation.method(#signUp, [user, password]),
            returnValue: _i4.Future<_i2.UserModel>.value(
              _FakeUserModel_0(
                this,
                Invocation.method(#signUp, [user, password]),
              ),
            ),
          )
          as _i4.Future<_i2.UserModel>);

  @override
  _i4.Future<void> setUserData(_i2.UserModel? user) =>
      (super.noSuchMethod(
            Invocation.method(#setUserData, [user]),
            returnValue: _i4.Future<void>.value(),
            returnValueForMissingStub: _i4.Future<void>.value(),
          )
          as _i4.Future<void>);

  @override
  _i4.Future<void> signIn(String? email, String? password) =>
      (super.noSuchMethod(
            Invocation.method(#signIn, [email, password]),
            returnValue: _i4.Future<void>.value(),
            returnValueForMissingStub: _i4.Future<void>.value(),
          )
          as _i4.Future<void>);

  @override
  _i4.Future<void> sigOut() =>
      (super.noSuchMethod(
            Invocation.method(#sigOut, []),
            returnValue: _i4.Future<void>.value(),
            returnValueForMissingStub: _i4.Future<void>.value(),
          )
          as _i4.Future<void>);
}
