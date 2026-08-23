import 'package:fin_wise/data/model/user_model.dart';
import 'package:fin_wise/data/web_services/api_consumer.dart';
import 'package:fin_wise/data/web_services/dio_consumer.dart';
import 'package:fin_wise/domain/repository/auth_repository.dart';

import '../web_services/endpoints_and_apikeys.dart';

class AuthImplementation implements AuthRepository {
  final DioConsumer _dioConsumer;
  AuthImplementation(this._dioConsumer);
  @override
  Future<UserModelSignIn> signIn(UserModelSignIn user) async {
    final response = await _dioConsumer.post(Endpoints().loginPath, {
      "username": user.userName,
      "password": user.password,
    });
    return UserModelSignIn.fromJson(response);
  }

  @override
  Future<UserModelSignUp> signUp(UserModelSignUp user) async {
    final response = await _dioConsumer.post(Endpoints().signUpPath, {
      "firstName": user.firstName,
      "lastName": user.lastName,
      "age": user.age,
    });
    return UserModelSignUp.fromJson(response);
  }
}

Future<void> main() async {
  final response = await AuthImplementation(
    DioConsumer(),
  ).signIn(UserModelSignIn(userName: "emilys", password: "emilyspass"));
  print(
    "first name:${response.firstName}, last name:${response.lastName},and his age is ${response.image}",
  );
}
