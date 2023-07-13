import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../domain/repositories/auth_repository.dart';
import '../../domain/use_cases/sign_in_use_case.dart';
import '../blocs/form_status.dart';
import '../blocs/password_status.dart';
import '../blocs/sign_in/sign_in_cubit.dart';
import '../blocs/username_status.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(
          signInUseCase: SignInUseCase(
        authRepository: context.read<AuthRepository>(),
      )),
      child: const SignInView(),
    );
  }
}

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  Timer? debounce;

  bool obscurePassword = true;

  

  @override
  void dispose() {
    debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    // final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Sign In')),
        ),
        body:
            BlocConsumer<SignInCubit, SignInState>(listener: (context, state) {
          listener(context, state);
        }, builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.2),
                TextFormField(
      key: const Key('signIn_username'),
      decoration: InputDecoration(
        labelText: 'Usuario',
        errorText: state.usernameStatus == UsernameStatus.invalid
            ? 'Usuario invalido'
            : null,
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')), // Permite solo letras
      ],
      onChanged: (String value) {
        if (debounce?.isActive ?? false) debounce?.cancel();
        debounce = Timer(const Duration(milliseconds: 500), () {
          context.read<SignInCubit>().usernameChanged(value);
        });
      },
    ),
                TextFormField(
      key: const Key('signIn_password'),
      obscureText: obscurePassword,
      keyboardType: TextInputType.number,
      inputFormatters: [LengthLimitingTextInputFormatter(5)],
      decoration: InputDecoration(
        suffixIcon: IconButton(
        icon: Icon(obscurePassword ? Icons.visibility_off : Icons.visibility),
        onPressed: () {
        setState(() {
          obscurePassword = !obscurePassword;
        });
      },
      ),
        labelText: 'Password',
        errorText: state.passwordStatus == PasswordStatus.invalid
            ? 'Password Invalido ingrese 5 digitos'
            : null,
      ),
      onChanged: (String value) {
        context.read<SignInCubit>().passwordChanged(value);
      },
    ),
                const SizedBox(height: 8.0),
                ElevatedButton(
                  key: const Key('signIn_continue'),
                  onPressed: context.read<SignInCubit>().state.formStatus ==
                          FormStatus.submissionInProgress
                      ? null
                      : () async {
                          context.read<SignInCubit>().signIn();
                          print('status form ${state.formStatus}');
                          if(state.formStatus == FormStatus.submissionSuccess) {
                            context.push('/userList');
                          }
                        },
                  child: const Text('Sign In'),
                ),
              ],
            ),
          );
        }));
  }

  void listener(context, state) {
    if (state.formStatus == FormStatus.submissionFailure) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Datos incorrectos intente nuevamente'),
          ),
        );
    }
  }


  TextFormField textFormFieldUsername(BuildContext mContext, state) {
    return TextFormField(
      key: const Key('signIn_username'),
      decoration: InputDecoration(
        labelText: 'Usuario',
        errorText: state.usernameStatus == UsernameStatus.invalid
            ? 'Usuario invalido'
            : null,
      ),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')), // Permite solo letras
      ],
      onChanged: (String value) {
        if (debounce?.isActive ?? false) debounce?.cancel();
        debounce = Timer(const Duration(milliseconds: 500), () {
          mContext.read<SignInCubit>().usernameChanged(value);
        });
      },
    );
  }

  TextFormField textFormFieldPassword(BuildContext mContext, state) {
    return TextFormField(
      key: const Key('signIn_password'),
      obscureText: obscurePassword,
      keyboardType: TextInputType.number,
      inputFormatters: [LengthLimitingTextInputFormatter(5)],
      decoration: InputDecoration(
        suffixIcon: IconButton(
        icon: Icon(obscurePassword ? Icons.visibility_off : Icons.visibility),
        onPressed: () {
        setState(() {
          obscurePassword = !obscurePassword;
        });
      },
      ),
        labelText: 'Password',
        errorText: state.passwordStatus == PasswordStatus.invalid
            ? 'Password Invalido ingrese 5 digitos'
            : null,
      ),
      onChanged: (String value) {
        mContext.read<SignInCubit>().passwordChanged(value);
      },
    );
  }
}
