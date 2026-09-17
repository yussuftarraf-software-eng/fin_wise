import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:fin_wise/data/repository/auth_implementaion.dart';
import 'package:fin_wise/data/web_services/dio_consumer.dart';
import 'package:fin_wise/route.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../../data/model/user_model.dart';
import '../../../../domain/repository/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final AuthRepository _authRepository = AuthImplementation(DioConsumer());
  // login function
  Future<void> login(UserModelSignIn user) async {
    try {
      emit(AuthLoading());
      final response = await _authRepository.signIn(user);
      emit(AuthSuccess());
      if (state is AuthSuccess) {
        print("login success");
      }
      FocusManager.instance.primaryFocus?.unfocus();
      print("${response.firstName} ${response.password}");
    } catch (e) {
      String errorMessage = "something went wrong,please try again later";
      if (e is DioException) {
        errorMessage = e.response!.data['message'] ?? errorMessage;
      }
      emit(AuthFailure(errorMessage));
    }
  }

  //signUp function
  Future signUp(UserModelSignUp user) async {
    try {
      emit(AuthLoading());
      final response = await _authRepository.signUp(user);
      emit(AuthSuccess());
      print("${response.firstName} ${response.lastName} ${response.age}");
    } catch (e) {
      String errorMessage = "something went wrong,please try again later";
      if (e is DioException) {
        errorMessage = e.response!.data['message'] ?? errorMessage;
      }
      emit(AuthFailure(errorMessage));
    }
  }
}
