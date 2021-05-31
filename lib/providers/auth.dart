import 'package:flutter/material.dart';
import '../constants.dart';
import '../config.dart';
import '../models/user.dart';
import '../user_prefs.dart';

enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut,
}

class AuthProvider with ChangeNotifier {

  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredInStatus = Status.NotRegistered;

  Status get loggedInStatus => _loggedInStatus;

  Status get registeredInStatus => _registeredInStatus;

  Future<Status> register({String email,
    String firstName,
    String lastName,
    String dob,
    String password,
    String phone}) {

    _registeredInStatus = Status.Registering;
    notifyListeners();

    UserPreferences().saveUser(
        User(
          email: email,
          firstName: firstName,
          lastName: lastName,
          dob: dob,
          password: password,
          phone: phone,
        )
    );

    printY(App.prefs.getString('email'));
    _registeredInStatus = Status.Registered;
    notifyListeners();

    return Future.delayed(Duration.zero, () => registeredInStatus);
  }

  Future<Status> login({String email, String password}) async{
    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    var userInfo = await UserPreferences().getUser();

    if(userInfo != null) {
      printR(App.prefs.getString('email'));
      if (userInfo.email == email && userInfo.password == password) {
        _loggedInStatus = Status.LoggedIn;
        print('LOGGED IN');
        notifyListeners();
      } else {
        _loggedInStatus = Status.NotLoggedIn;
        notifyListeners();
      }
    } else {
        _loggedInStatus = Status.NotLoggedIn;
        notifyListeners();
    }
    return loggedInStatus;
  }

  void logout(){
    App.prefs.setBool('login', false);
    _loggedInStatus = Status.LoggedOut;
    notifyListeners();
    printY(App.prefs.getBool('login').toString());
  }
}