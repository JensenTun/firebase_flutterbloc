import 'package:equatable/equatable.dart';
import 'package:firebase_flutterbloc/fetures/authen/model/user.dart';
import 'package:firebase_flutterbloc/fetures/authen/service/user_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepo _userRepo;
  SignUpBloc({required UserRepo userRepo})
    : _userRepo = userRepo,
      super(SignUpInitial()) {
    on<SignUpRequired>((event, emit) async {
      emit(SignUpProcess());
      try {
        UserModel user = await _userRepo.signUp(event.user, event.password);
        await _userRepo.setUserData(user);
        emit(SignUpSuccess());
      } catch (e) {
        emit(SignUpFailure());
      }
    });
  }
}
