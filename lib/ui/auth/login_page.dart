import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wisdom_pos_test/bloc/auth/login_bloc.dart';
import 'package:wisdom_pos_test/bloc/auth/login_event.dart';
import 'package:wisdom_pos_test/bloc/auth/login_state.dart';
import 'package:wisdom_pos_test/bloc/navigation/navigation_bloc.dart';
import 'package:wisdom_pos_test/core/color.dart';
import 'package:wisdom_pos_test/core/constants/constants.dart';
import 'package:wisdom_pos_test/ui/navigation/navigation_page.dart';
import 'package:wisdom_pos_test/ui/widgets/button.dart';
import 'package:wisdom_pos_test/ui/widgets/loading_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscurePassword = true;

  @override
  void initState() {
    super.initState();
    context.read<LoginBloc>().add(InitialLoginCheck());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VColor.primary,
      body: Center(
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) async {
            if (state.status == LoginStatus.success) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (_) => NavigationBloc(),
                    child: const NavigationPage(),
                  ),
                ),
              );
            } else if (state.status == LoginStatus.failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage ?? "Login Failed")),
              );
            }
          },
          builder: (context, state) {
            return LoadingOverlay(
              isLoading: state.status == LoginStatus.loading,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const SizedBox(height: 77),
                          SizedBox(
                            width: 232,
                            height: 29,
                            child: Image.asset(
                              '${imagePath}logo.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(height: 40),
                          const Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text("Login to your account", style: TextStyle(color: Colors.white70)),
                          const SizedBox(height: 30),
                          TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              hintText: "Email",
                              prefixIcon: const Icon(Icons.email, size: 20),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: passwordController,
                            obscureText: obscurePassword,
                            decoration: InputDecoration(
                              hintText: "Password",
                              prefixIcon: const Icon(Icons.lock, size: 20),
                              suffixIcon: IconButton(
                                icon: Icon(obscurePassword ? Icons.visibility : Icons.visibility_off),
                                onPressed: () {
                                  setState(() => obscurePassword = !obscurePassword);
                                },
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Material(
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                Checkbox(
                                  value: state.rememberMe,
                                  shape: const CircleBorder(),
                                  checkColor: VColor.primary,
                                  activeColor: Colors.white,
                                  fillColor: WidgetStateProperty.all(Colors.white),
                                  side: BorderSide.none,
                                  onChanged: (_) {
                                    context.read<LoginBloc>().add(ToggleRememberMe());
                                  },
                                ),
                                InkWell(
                                    onTap: () {
                                      context.read<LoginBloc>().add(ToggleRememberMe());
                                    },
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    child: const Text("Remember me", style: TextStyle(color: Colors.white))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: VButton(
                        text: "Login",
                        onPressed: state.status == LoginStatus.loading
                            ? null
                            : () {
                                final email = emailController.text.trim();
                                final password = passwordController.text;

                                if (email.isEmpty || password.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Email and password cannot be empty")),
                                  );
                                  return;
                                }

                                context.read<LoginBloc>().add(LoginSubmitted(email, password));
                              },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
