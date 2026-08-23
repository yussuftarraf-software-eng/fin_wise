import 'package:fin_wise/data/model/user_model.dart';

abstract class AuthRepository {
  Future<UserModelSignUp> signUp(UserModelSignUp user);
  Future<UserModelSignIn> signIn(UserModelSignIn user);
}
