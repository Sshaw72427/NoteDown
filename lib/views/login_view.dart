import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({Key? key}) : super(key: key);

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
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
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                email: email.text,
                password: password.text,
              );
              print(userCredentials);
              // Navigator.pushAndRemoveUntil(
              //     context, '/notes/', (route) => false);
            },
            child: const Text("Login"),
          ),
        ],
      ),
    );
  }
}
