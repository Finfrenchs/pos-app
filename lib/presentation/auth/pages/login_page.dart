import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_app/core/constants/colors.dart';
import 'package:pos_app/data/datasources/auth_local_datasource.dart';
import 'package:pos_app/presentation/auth/bloc/login/login_bloc.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/components/buttons.dart';
import '../../../core/components/custom_text_field.dart';
import '../../../core/components/spaces.dart';
import '../../home/pages/dashboard_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SpaceHeight(80.0),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80.0),
              child: Image.asset(
                Assets.images.logoPos.path,
                width: 300,
                height: 150,
              )),
          const SpaceHeight(20.0),
          // const Center(
          //   child: Text(
          //     "Selamat Datang Kembali \nSahabat SRUPUT GLEK",
          //     style: TextStyle(
          //       fontSize: 14,
          //       fontWeight: FontWeight.w700,
          //       color: Colors.black,
          //     ),
          //   ),
          // ),
          const SpaceHeight(8.0),
          Center(
            child: Text(
              "Masuk untuk kasir",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          const SpaceHeight(40.0),
          CustomTextField(
            controller: emailController,
            label: 'Email',
          ),
          const SpaceHeight(12.0),
          CustomTextField(
            controller: passwordController,
            label: 'Password',
            obscureText: true,
          ),
          const SpaceHeight(24.0),
          BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              state.maybeWhen(
                orElse: () {},
                success: (responseModel) {
                  AuthLocalDatasource().saveAuthData(responseModel);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DashboardPage(),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Login Success'),
                      backgroundColor: AppColors.green,
                    ),
                  );
                },
                error: (message) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(message),
                      backgroundColor: AppColors.red,
                    ),
                  );
                },
              );
            },
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return Button.filled(
                    onPressed: () {
                      context.read<LoginBloc>().add(
                            LoginEvent.login(
                                email: emailController.text,
                                password: passwordController.text),
                          );
                    },
                    label: 'Masuk',
                  );
                },
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
