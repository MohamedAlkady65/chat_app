import 'package:chat_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:chat_app/blocs/auth_bloc/auth_events.dart';
import 'package:chat_app/blocs/auth_bloc/auth_state.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/helper/snack_bar.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/widgets/custom_buttom.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:chat_app/pages/register_page.dart';





class loginPage extends StatelessWidget {
  loginPage({super.key});

  static const String id = "loginPage";

  String? email;
  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginLoadingState) {
          isLoading = true;
        } else if (state is LoginSuccessState) {
          emailController.clear();
          passController.clear();
          BlocProvider.of<ChatCubit>(context).getMessages();
          Navigator.pushNamed(context, ChatPage.id,
              arguments: FirebaseAuth.instance.currentUser!.uid);
          isLoading = false;
        } else if (state is LoginFailureState) {
          ShowSnackBar(context, state.message);
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: kPrimaryColor,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    const Image(
                      image: AssetImage(kLogo),
                      height: 100,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Scolar Chat",
                          style: TextStyle(
                              color: kSecondryColor,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              fontFamily: "pacifico",
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "LOGIN",
                        style: TextStyle(color: kSecondryColor, fontSize: 25),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomFormTextField(
                      controller: emailController,
                      hintText: "Email",
                      onChanged: (value) {
                        email = value;
                      },
                      errorText: "Please Enter Email",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomFormTextField(
                      controller: passController,
                      hintText: "Password",
                      obscure: true,
                      onChanged: (value) {
                        password = value;
                      },
                      errorText: "Please Enter Password",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButtom(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<AuthBloc>(context).add(AuthLoginEvent(
                              email: email!, Password: password!));
                        }
                      },
                      text: "Login",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "dont't you have an account ? ",
                          style: TextStyle(color: kSecondryColor, fontSize: 14),
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, registerPage.id);
                            },
                            child: const Text("Register",
                                style: TextStyle(
                                    color: Color(0xffC7EDE6), fontSize: 16)))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

bool pass = true;
