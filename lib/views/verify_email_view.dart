import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text('Too verify Your email tap the below button'),
          TextButton(
            onPressed: () async {
              final user = FirebaseAuth.instance.currentUser;
              await user?.sendEmailVerification();
            },
            child: const Text('Send Verification Link'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/login/', (route) => false);
            },
            child: const Text('go to Login page'),
          ),
        ],
      ),
    );
  }
}
