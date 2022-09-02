import 'package:flutter/material.dart';
import 'package:notedown/services/auth/auth_service.dart';
import 'package:notedown/views/login_view.dart';
import 'package:notedown/views/notes_view.dart';
import 'package:notedown/views/register_view.dart';
import 'package:notedown/views/verify_email_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        '/login/': (context) => const Loginpage(),
        '/register/': (context) => const RegisterView(),
        '/notes/': (context) => const NotesView(),
        '/verifyEmail/': (context) => const VerifyEmail(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;

            if (user != null) {
              if (user.isEmailVerified) {
                return const NotesView();
              } else {
                return const VerifyEmail();
              }
            } else {
              return const Loginpage();
            }

          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
