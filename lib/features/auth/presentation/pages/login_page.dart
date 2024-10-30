import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:google_fonts/google_fonts.dart";
import "package:skf_project/core/common/loader/loader.dart";
import "package:skf_project/core/themes/constant_colors.dart";
import "package:skf_project/features/auth/presentation/bloc/auth_bloc.dart";
import "package:skf_project/features/auth/presentation/widgets/custom_login_button.dart";
import "package:skf_project/features/auth/presentation/widgets/custom_text_field.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Creating Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // Disposing Controllers
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Main widget Tree
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoginFailedState) {}
      },
      child: Scaffold(
        backgroundColor: AppColors.lightBlue,
        body: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Welcome to",
                  style: GoogleFonts.nunito(
                    color: AppColors.whiteColor,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Image.asset(
                  "assets/logo.png",
                  width: 320,
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  padding: const EdgeInsets.only(
                    top: 20,
                    bottom: 20,
                    left: 30,
                    right: 30,
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: 350,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                    color: AppColors.whiteColor,
                  ),
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is AuthLoadingState) {
                        return const Center(
                          child: Loader(),
                        );
                      }
                      return Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Text(
                              "Login",
                              style: GoogleFonts.nunito(
                                color: AppColors.darkGrey,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            CustomTextField(
                              controller: emailController,
                              hintText: "Email",
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            CustomTextField(
                              controller: passwordController,
                              hintText: "Password",
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomLoginButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  context.read<AuthBloc>().add(
                                        AuthLogin(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        ),
                                      );
                                }
                              },
                              text: "Login",
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
