import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:fin_wise/data/repository/auth_implementaion.dart';
import 'package:fin_wise/data/web_services/dio_consumer.dart';
import 'package:fin_wise/route.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '../../../../data/model/user_model.dart';
import '../../../../domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  //sign in with google function
  Future<void> signInWithGoogle() async {
    try {
      emit(AuthLoading());

      final googleUser = await GoogleSignIn.instance.authenticate();
      final googleAuth = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(AuthSuccess());
    } on GoogleSignInException catch (e) {
      print('Google sign-in error: ${e.code} - ${e.description}');
      emit(
        AuthFailure('Google sign-in failed: ${e.description ?? e.code.name}'),
      );
    } catch (e) {
      print('Google sign-in error: $e');
      emit(AuthFailure('Google sign-in failed, please try again'));
    }
  }

  // //sign in with facebook function
  // Future<void> signInWithFacebook() async {
  //   try {
  //     emit(AuthLoading());
  //
  //     // Trigger the sign-in flow
  //     final LoginResult loginResult = await FacebookAuth.instance.login();
  //
  //     // User closed the Facebook dialog
  //     if (loginResult.status == LoginStatus.cancelled) {
  //       emit(AuthInitial());
  //       return;
  //     }
  //
  //     // Any other non-success result
  //     if (loginResult.status != LoginStatus.success ||
  //         loginResult.accessToken == null) {
  //       emit(AuthFailure(loginResult.message ?? 'Facebook sign-in failed'));
  //       return;
  //     }
  //
  //     // Create a credential from the access token
  //     final OAuthCredential facebookAuthCredential =
  //         FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);
  //
  //     // Once signed in, authenticate with Firebase
  //     await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  //     emit(AuthSuccess());
  //   } on FirebaseAuthException catch (e) {
  //     print('Facebook sign-in error: ${e.code} - ${e.message}');
  //     emit(AuthFailure(e.message ?? 'Facebook sign-in failed'));
  //   } catch (e) {
  //     print('Facebook sign-in error: $e');
  //     emit(AuthFailure('Facebook sign-in failed, please try again'));
  //   }
  // }
}
