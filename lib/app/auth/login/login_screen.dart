import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wayawaya/app/auth/forgotpassword/model/error_response.dart';
import 'package:wayawaya/app/common/dialogs/common_error_dialog.dart';
import 'package:wayawaya/app/common/custom_raise_button.dart';
import 'package:wayawaya/network/live/model/api_response.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/dimens.dart';
import 'package:wayawaya/utils/session_manager.dart';
import 'package:wayawaya/utils/utils.dart';
import 'bloc/login_bloc.dart';
import 'model/user_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController;
  TextEditingController _passwordController;
  var _formKey;
  LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _initViews();
  }

  _initViews() {
    debugPrint('performance_testing:-   login screen initState ');
    _emailController =
        TextEditingController(text: 'pardeepsharma475@gmail.com');
    _passwordController = TextEditingController(text: 'qwerty');
    _formKey = GlobalKey<FormState>();
    _loginBloc = LoginBloc();
  }

  @override
  Widget build(BuildContext context) {
    var value = ModalRoute.of(context).settings.arguments;
    return WillPopScope(
      onWillPop: () {
        if (value != null) {
          Navigator.pop(context);
          Navigator.pushNamedAndRemoveUntil(
              context, AppString.HOME_SCREEN_ROUTE, (route) => true);
        } else {
          Navigator.pop(context);
        }
      },
      child: SafeArea(
        child: Scaffold(
          persistentFooterButtons: [
            Builder(
              builder: (BuildContext context) {
                return CustomRaiseButton(
                  backgroundColor: AppColor.white,
                  title: AppString.login.toUpperCase(),
                  borderRadius: 0,
                  width: MediaQuery.of(context).size.width,
                  onPressed: () {
                    _loginButtonPressed(context);
                  },
                );
              },
            ),
            InkWell(
              onTap: () {
                debugPrint('forgot password');
                _forgotButtonPressed(context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(vertical: 7),
                child: const Text(
                  AppString.forgot_password,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: AppColor.colored_text,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                debugPrint('create account');
                FocusScopeNode currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
                SessionManager.setISLoginScreenVisible(true);
                Navigator.pushNamed(context, AppString.SIGN_UP_SCREEN_ROUTE);
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(vertical: 7),
                child: const Text(
                  AppString.not_account_yet,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: AppColor.colored_text,
                  ),
                ),
              ),
            ),
          ],
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  // onTap: () => Navigator.of(context)
                                  //     .push(MaterialPageRoute(builder: (_) => Preferences())),
                                  onTap: () {
                                    SessionManager.setISLoginScreenVisible(
                                        true);
                                    Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        AppString
                                            .SELECT_PREFERENCES_SCREEN_ROUTE,
                                        (route) => false);
                                  },
                                  child: const Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 10, 6, 10),
                                    child: const Text(
                                      AppString.skip,
                                      style: TextStyle(
                                        color: AppColor.primary,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            FutureBuilder(
                              builder: (context, snapshot) {
                                if (snapshot.data == null) {
                                  return const SizedBox();
                                }
                                return Image.asset(
                                  snapshot.data,
                                  width: 300,
                                  height: 300,
                                  fit: BoxFit.cover,
                                );
                              },
                              initialData: null,
                              future: getImageFromAssets(),
                            ),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  // _emailField(),
                                  _emailField(),
                                  _passwordField(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              StreamBuilder<ApiResponse<ErrorResponse>>(
                stream: _loginBloc.loginStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    switch (snapshot.data.status) {
                      case Status.LOADING:
                        Future.delayed(Duration(milliseconds: 200), () {
                          Utils.commonProgressDialog(context);
                        });
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.transparent,
                          height: MediaQuery.of(context).size.height,
                        );
                        break;
                      case Status.COMPLETED:
                        {
                          debugPrint("completed");
                          Navigator.pop(context);
                          Future.delayed(Duration(milliseconds: 100), () {
                            _loginComplete();
                          });
                        }
                        break;
                      case Status.ERROR:
                        {
                          Navigator.pop(context);
                          Future.delayed(Duration(milliseconds: 100), () {
                            debugPrint(
                                "Error error ${snapshot.data.data.message}");

                            if (snapshot.data.data.message == '401') {
                              _showErrorDialog(
                                icon: Icon(
                                  FontAwesomeIcons.exclamationCircle,
                                  color: AppColor.red_500,
                                ),
                                title: AppString.sorry,
                                content: AppString
                                    .invalid_cred_check_user_name_and_password,
                                buttonText: AppString.ok.toUpperCase(),
                                onPressed: () => Navigator.pop(context),
                              );
                            } else {
                              if (snapshot.data.data.differ == 'USER_DETAILS') {
                                _showErrorDialog(
                                  icon: Icon(
                                    FontAwesomeIcons.exclamationTriangle,
                                    color: AppColor.orange_500,
                                  ),
                                  title: AppString.login.toUpperCase(),
                                  content: AppString
                                      .check_your_internet_connectivity,
                                  buttonText:
                                      AppString.preferences.toUpperCase(),
                                  onPressed: _loginComplete,
                                );
                              } else {
                                _showErrorDialog(
                                  icon: Icon(
                                    FontAwesomeIcons.exclamationTriangle,
                                    color: AppColor.orange_500,
                                  ),
                                  title: AppString.login.toUpperCase(),
                                  content: AppString
                                      .check_your_internet_connectivity,
                                  buttonText: AppString.ok.toUpperCase(),
                                  onPressed: () => Navigator.pop(context),
                                );
                              }
                            }
                          });
                        }
                        break;
                    }
                  }
                  return SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> getImageFromAssets() async {
    String defaultMall = await SessionManager.getDefaultMall();
    return 'assets/image/ic_launcher_$defaultMall.png';
  }

  Widget _passwordField() {
    return TextFormField(
      autofocus: false,
      controller: _passwordController,
      validator: (value) =>
          value.isEmpty ? AppString.enter_valid_password : null,
      decoration: InputDecoration(
        labelText: AppString.password,
        alignLabelWithHint: true,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        labelStyle: TextStyle(
          fontSize: Dimens.sixteen,
          fontWeight: FontWeight.w400,
        ),
        hintStyle: TextStyle(
          fontSize: Dimens.sixteen,
          fontWeight: FontWeight.w400,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.colored_text,
            width: Dimens.two,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.borderColor,
          ),
        ),
      ),
      keyboardType: TextInputType.text,
      obscureText: true,
      textInputAction: TextInputAction.done,
    );
  }

  Widget _emailField() {
    return TextFormField(
      autofocus: false,
      controller: _emailController,
      validator: (value) {
        if (value.isEmpty) {
          return AppString.enter_valid_email_address;
        } else if (!Utils.emailValidation(value)) {
          return AppString.email_validation_error_message;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: AppString.email,
        alignLabelWithHint: true,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        labelStyle: TextStyle(
          fontSize: Dimens.sixteen,
          fontWeight: FontWeight.w400,
        ),
        hintStyle: TextStyle(
          fontSize: Dimens.sixteen,
          fontWeight: FontWeight.w400,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.colored_text,
            width: Dimens.two,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.borderColor,
          ),
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
    );
  }

  _showErrorDialog(
      {Icon icon,
      String title,
      String content,
      String buttonText,
      VoidCallback onPressed}) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.1),
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
          return Transform(
            transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 100),
              opacity: a1.value,
              child: CommonErrorDialog(
                icon: icon,
                title: title,
                content: content,
                buttonText: buttonText,
                onPressed: onPressed,
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: false,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {});
  }

  _forgotButtonPressed(BuildContext context) async {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    // try {
    //   print(DateTime.now().toUtc().timeZoneOffset);
    //   print(DateTime.now().timeZoneOffset);
    //   print(DateFormat("Z").format(DateTime.now()));
    // } catch (e) {
    //   debugPrint('time_zone:-  $e');
    // }
    SessionManager.setISLoginScreenVisible(true);
    Navigator.pushNamed(context, AppString.FORGOT_PASSWORD_SCREEN_ROUTE);
  }

  _loginButtonPressed(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    SessionManager.setISLoginScreenVisible(true);

    if (_formKey.currentState.validate()) {
      Utils.checkConnectivity().then((value) {
        if (value) {
          UserModel userModel = UserModel(
              username: _emailController.text,
              password: _passwordController.text);
          _loginBloc.loginApi(userModel, "GUEST");
        } else {
          _showErrorDialog(
            icon: Icon(
              FontAwesomeIcons.exclamationTriangle,
              color: AppColor.orange_500,
            ),
            title: AppString.login.toUpperCase(),
            content: AppString.check_your_internet_connectivity,
            buttonText: AppString.ok.toUpperCase(),
            onPressed: () => Navigator.pop(context),
          );
        }
      });
    }
  }

  _loginComplete() {
    debugPrint('login_testing :-   login complete');
    SessionManager.setISLoginScreenVisible(true);
    SessionManager.setISLogin(true);
    Navigator.pop(context);
    Navigator.pushNamedAndRemoveUntil(
        context, AppString.HOME_SCREEN_ROUTE, (route) => false);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
