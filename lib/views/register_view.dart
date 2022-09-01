import 'package:flutter/material.dart';
import 'package:notedown/services/auth/auth_exceptions.dart';
import 'package:notedown/services/auth/auth_service.dart';
import 'package:notedown/utilities/show_error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("NoteDown"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: "Enter Your Email",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
              controller: _password,
              obscureText: true,
              autocorrect: false,
              enableSuggestions: false,
              decoration: const InputDecoration(
                hintText: "Enter Your Password",
                border: OutlineInputBorder(),
              )),
          TextButton(
            onPressed: () async {
              final email = _email;
              final password = _password;
              try {
                await AuthService.firebase().createUser(
                  email: email.text,
                  password: password.text,
                );
                AuthService.firebase().sendEmailVerification();
                Navigator.of(context).pushNamed('/verifyEmail/');
              } on WeakPasswordAuthException {
                await showErrorDialog(context, 'weak password');
              } on EmailAlreadyInUseAuthException {
                await showErrorDialog(context, 'Email is already in use');
              } on InvalidEmailAuthException {
                await showErrorDialog(
                    context, 'This is an invalid email address');
              } on GenericAuthException {
                await showErrorDialog(context, 'Failed to register');
              }
            },
            child: const Text("Register"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/login/', (route) => false);
            },
            child: const Text('ALready registered? Login here!'),
          ),
        ],
      ),
    );
  }
}
