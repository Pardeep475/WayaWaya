import 'dart:io';

import 'config.dart';
import 'constants.dart';
import 'models/user.dart';

class UserPreferences {
  void saveUser(User user) {
    App.prefs.setString("firstName", user.firstName);
    App.prefs.setString("lastName", user.lastName);
    App.prefs.setString("email", user.email);
    App.prefs.setString("phone", user.phone);
    App.prefs.setString("dob", user.dob);
    App.prefs.setString("password", user.password);
  }

  Future<User> getUser() async {
    await Future.delayed(Duration.zero, () => 'Hello');
    String firstName = App.prefs.getString("firstName");
    String lastName = App.prefs.getString("lastName");
    String email = App.prefs.getString("email");
    String phone = App.prefs.getString("phone");
    String dob = App.prefs.getString("dob");
    String password = App.prefs.getString("password");

    return User(
      email: email,
      firstName: firstName,
      lastName: lastName,
      dob: dob,
      password: password,
      phone: phone,
    );
  }

  Future<String> getUserEmail() async {
    String email = App.prefs.getString("email");
    printR(email);

    return email;
  }

  Map<String, dynamic> getAccessDetails() {
    String callAccess = App.prefs.getString('callAccess') ?? Platform.isIOS
        ? 'GRANTED'
        : 'DENIED';
    String locAccess = App.prefs.getString('locAccess') ?? 'DENIED';
    String locType = App.prefs.getString('locType') ?? 'NOT SET';

    Map<String, dynamic> accessDetails = {
      'callAccess': callAccess,
      'locAccess': locAccess,
      'locType': locType,
    };
    print("CallAccess: $callAccess");

    printY(accessDetails.toString());
    return accessDetails;
  }

  Map<String, dynamic> screenVisited() {
    bool defaultMall = App.prefs.getBool('defaultMall') ?? false;
    bool bgScreen = App.prefs.getBool('defaultMall') ?? false;
    bool login = App.prefs.getBool('login') ?? false;

    Map<String, dynamic> screens = {
      'defaultMall': defaultMall,
      'bgScreen': bgScreen,
      'login': login,
    };

    return screens;
  }

  void removeUser() async {
    App.prefs.remove("firstName");
    App.prefs.remove("email");
    App.prefs.remove("phone");
    App.prefs.remove("lastName");
    App.prefs.remove("password");
    App.prefs.remove("dob");
  }
}
