import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:google_fonts/google_fonts.dart";
import "package:skf_project/core/common/loader/loader.dart";
import "package:skf_project/core/common/widgets/indications/snackbar.dart";
import "package:skf_project/core/themes/constant_colors.dart";
import "package:skf_project/features/auth/bloc/auth_bloc.dart";
import "package:skf_project/features/auth/widgets/custom_login_button.dart";
import "package:skf_project/features/auth/widgets/custom_text_field.dart";

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
        if (state is AuthFailedState) {
          Snackbar.showSnackbar(
            message: state.message,
            leadingIcon: Icons.error,
            context: context,
          );
        } else if (state is AuthSuccessState){
          Navigator.pushReplacementNamed(context, "/drier");
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.lightBlue,
        body: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Welcome",
                  style: GoogleFonts.nunito(
                    color: AppColors.whiteColor,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20,),
                Center(
                  child: Image.asset(
                    "assets/logo.png",
                    width: 320,
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                Container(
                  padding: const EdgeInsets.only(
                    top: 20,
                    bottom: 20,
                    left: 30,
                    right: 30,
                  ),
                  width: MediaQuery.of(context).size.width,
                  height: 400,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                    color: AppColors.whiteColor,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          isObscure: true,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomLoginButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              BlocProvider.of<AuthBloc>(context).add(
                                AuthLoginEvent(
                                  email: emailController.text,
                                  password: passwordController.text,
                                ),
                              );
                            }
                          },
                          child: BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              if(state is AuthLoadingState){
                                return Container(
                                  width: 20,
                                  height: 20,
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeCap: StrokeCap.round,
                                  ),
                                );
                              }
                              return Text(
                                "Login",
                                style: GoogleFonts.nunito(
                                  color: AppColors.whiteColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
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
