import 'dart:async';
import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thebasiclook/constants.dart';
import 'package:thebasiclook/services/auth.dart';
import 'package:thebasiclook/services/savingUserData.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>(loginEvent);
    on<RegisterEvent>(registerEvent);
    on<SignOutEvent>(signOutEvent);
  }

  FutureOr<void> loginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(LoginLoadingState());

    final url = Uri.parse(baseUrl + 'auth/login');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'email': event.email,
        'password': event.password,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      print('token is ' + responseData.toString());
      final token = responseData['token'];
      final role = responseData['role'];
      final userId = responseData['userId'];

      print('role' + role);
      UserData().saveData(token: token, role: role, userId: userId);
      emit(LoginSuccessState());
    } else {
      final errorMessage = response.body;
      emit(LoginFailureState(err: errorMessage));
    }
  }

  FutureOr<void> registerEvent(
      RegisterEvent event, Emitter<AuthState> emit) async {
    emit(RegisterLoadingState());
    final url = Uri.parse(baseUrl + 'auth/register');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'name': event.name,
        'email': event.email,
        'password': event.password,
      }),
    );

    if (response.statusCode == 201) {
      emit(RegisterSuccessState());
    } else {
      final errorMessage = response.body;
      emit(RegisterFailureState(err: errorMessage));
    }
  }

  FutureOr<void> signOutEvent(
      SignOutEvent event, Emitter<AuthState> emit) async {
    emit(SignOutLoadingState());
    await GetStorage().remove('token');
    await GetStorage().remove('role');
    await GetStorage().remove('userId');
    emit(SignOutSuccessState());
  }
}
