import 'package:cubit_practice/features/home/data/user_model.dart';
import 'package:equatable/equatable.dart';

class UserState extends Equatable {
  final List<UserModel> users;
  final bool isLoading;
  final String? errorMessage;

  const UserState({
    this.users = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  UserState copyWith({
    List<UserModel>? users,
    bool? isLoading,
    String? errorMessage,
  }) => UserState(
    users: users ?? this.users,
    isLoading: isLoading ?? this.isLoading,
    errorMessage: errorMessage ?? this.errorMessage,
  );

  @override
  // TODO: implement props
  List<Object?> get props => [
    users,
    isLoading,
    errorMessage,
  ];


}
