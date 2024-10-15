import 'package:emoshare_diary/common/const/colors.dart';
import 'package:emoshare_diary/common/layout/default_layout.dart';
import 'package:emoshare_diary/user/provider/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static String get routeName => 'login';

  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool isLoggingIn = false;

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: PRIMARY_COLOR,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'EmoShare Diary',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              const Icon(
                Icons.edit_calendar_rounded,
                size: 100,
              ),
              const SizedBox(height: 32),
              const Text(
                '로그인하고 일기를 작성해보세요!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              if (isLoggingIn)
                const CircularProgressIndicator()
              else
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      isLoggingIn = true;
                    });

                    GoogleSignIn googleSignIn = GoogleSignIn();
                    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

                    GoogleSignInAccount? account = await googleSignIn.signIn();

                    if (account != null) {
                      GoogleSignInAuthentication authentication =
                          await account.authentication;

                      OAuthCredential googleCredential =
                          GoogleAuthProvider.credential(
                        idToken: authentication.idToken,
                        accessToken: authentication.accessToken,
                      );

                      UserCredential credential = await firebaseAuth
                          .signInWithCredential(googleCredential);

                      if (credential.user != null) {
                        debugPrint(credential.user.toString());
                        ref
                            .read(userProvider.notifier)
                            .setUser(credential.user!);
                        if (context.mounted) context.go('/');
                      }

                      await googleSignIn.signOut();
                    }

                    setState(() {
                      isLoggingIn = false;
                    });
                  },
                  child: Image.asset(
                    'assets/icons/google_login.png',
                    height: 50,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
