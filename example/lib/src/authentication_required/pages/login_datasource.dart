/*
 Created by Thanh Son on 28/09/2023.
 Copyright (c) 2023 . All rights reserved.
*/
class UserData {
  final String username;
  final String password;

  const UserData({required this.username, required this.password});
}
/// In this example, we use [userData] for the check login,
/// if [userData] is special, that means you're in an authentication state.
class LoginDataSource {
  UserData? userData;

  Future<void> login(String username, String password) async {
    userData = UserData(username: username, password: password);
  }

  Future<void> logout() async {
    userData = null;
  }

  bool get isLogin => userData != null;
}
