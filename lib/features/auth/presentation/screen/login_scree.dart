import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../service/local_storage/local_storage_service.dart';
import '../../../home/presentation/view/home_screen.dart';
import '../../cubit/login_cubit.dart';
import '../../cubit/login_state.dart';
import '../../repo/auth_repository.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(AuthRepository(TokenStorageService())),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailTEController = TextEditingController();
  final TextEditingController passwordTEController = TextEditingController();

  @override
  void dispose() {
    emailTEController.dispose();
    passwordTEController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.success) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomeScreen()),
          );
        } else if (state.status == LoginStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? "Login failed")),
          );
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Login",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 40),

              TextField(
                controller: emailTEController,
                decoration: const InputDecoration(hintText: "Email"),
              ),

              const SizedBox(height: 12),

              TextField(
                controller: passwordTEController,
                obscureText: true,
                decoration: const InputDecoration(hintText: "Password"),
              ),

              const SizedBox(height: 30),

              BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  final isLoading = state.status == LoginStatus.loading;

                  return ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            context.read<LoginCubit>().login(
                              emailTEController.text.trim(),
                              passwordTEController.text.trim(),
                            );
                          },
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text("Login"),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
