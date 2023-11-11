import 'package:chat_app/constants.dart';
import 'package:chat_app/cubits/auth_cubit/auth_cubit.dart';
import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/widgets/custom_buttom.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helper/snack_bar.dart';

class registerPage extends StatelessWidget {
  static const String id = "registerPage";

  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  registerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterLoadingState) {
          isLoading = true;
        } else if (state is RegisterSuccessState) {
          emailController.clear();
          passController.clear();
          BlocProvider.of<ChatCubit>(context).getMessages();

          Navigator.pushNamed(context, ChatPage.id,
              arguments: FirebaseAuth.instance.currentUser!.uid);
          isLoading = false;
        } else if (state is RegisterFailureState) {
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
                      image: AssetImage("assets/images/scholar.png"),
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
                        "REGISTER",
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
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButtom(
                      text: "Register",
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          await BlocProvider.of<AuthCubit>(context)
                              .Register(email: email!, password: password!);
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "have already an account ? ",
                          style: TextStyle(color: kSecondryColor, fontSize: 14),
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Login",
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
