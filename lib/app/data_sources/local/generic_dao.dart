import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:todo_list/app/models/user_login_model.dart';

class UserDAO {
  final Box box = GetIt.I.get<Box>();

  Future<void> saveUser(UserLoginModel user) async {
    await box.put('user', user.name);
    await box.put('password', user.password);
    await box.put('isLogged', user.email);
  }
  
  UserLoginModel getUser() {
    final UserLoginModel user = UserLoginModel(
      name: box.get('user'),
      password: box.get('password'),
      email: box.get('isLogged'),
    );

    return user;
  }
}