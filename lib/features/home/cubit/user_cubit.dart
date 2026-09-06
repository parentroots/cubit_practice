import 'dart:convert';

import 'package:cubit_practice/features/home/cubit/user_state.dart';
import 'package:cubit_practice/features/home/data/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserState()) {
    fetchAllUsers();
  }

  Future<void> fetchAllUsers() async {
    emit(state.copyWith(isLoading: true));

    try {
      final url = Uri.parse('https://jsonplaceholder.typicode.com/users');
      final response = await http.get(url);

      if (response.statusCode != 200) {
        throw Exception('Failed to fetch users');
      }

      debugPrint(response.body);
      final List<dynamic> usersJson = json.decode(response.body);

      final List<UserModel> users = usersJson
          .map((json) => UserModel.fromJson(json))
          .toList();

      emit(state.copyWith(users: users, isLoading: false));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }


}
