import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = StateNotifierProvider<UserStateNotifier, User?>((ref) {
  return UserStateNotifier();
});

class UserStateNotifier extends StateNotifier<User?> {
  UserStateNotifier() : super(null);

  void setUser(User user) => state = user;

  void signOut() => state = null;
}
