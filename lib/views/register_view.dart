import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
              final userCredentials =
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: email.text,
                password: password.text,
              );
              print(userCredentials);
            },
            child: const Text("Register"),
          ),
        ],
      ),
    );
  }
}
