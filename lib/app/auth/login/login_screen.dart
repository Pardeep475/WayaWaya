import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wayawaya/common/custom_raise_button.dart';
import 'package:wayawaya/network/live/model/api_response.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_images.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/dimens.dart';
import 'package:wayawaya/utils/utils.dart';
import '../../../constants.dart';
import 'bloc/login_bloc.dart';
import 'model/user_api_response.dart';
import 'model/user_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _loginBloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    // var user = Provider.of<AuthProvider>(context, listen: true);

    return SafeArea(
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
          forgotLabel(),
          createAccLabel(),
        ],
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: Dimens.fifteen),
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
                                debugPrint('skip button pressed');
                              },
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(Dimens.twenty,
                                    Dimens.ten, Dimens.six, Dimens.ten),
                                child: Text(
                                  AppString.skip,
                                  style: TextStyle(
                                    color: AppColor.primary,
                                    fontSize: Dimens.sixteen,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Image.asset(
                          AppImages.icon_logo,
                          width: Dimens.threeHundred,
                          height: Dimens.threeHundred,
                          fit: BoxFit.cover,
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
            StreamBuilder<ApiResponse<UserApiResponse>>(
              stream: _loginBloc.loginStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  switch (snapshot.data.status) {
                    case Status.LOADING:
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.transparent,
                        height: MediaQuery.of(context).size.height,
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation<Color>(
                                AppColor.yellow),
                          ),
                        ),
                      );
                      break;
                    case Status.COMPLETED:
                      {
                        debugPrint("completed");
                        Future.delayed(Duration(milliseconds: 100), () {
                          _loginComplete(snapshot.data.data);
                        });
                      }
                      break;
                    case Status.ERROR:
                      {
                        Future.delayed(Duration(milliseconds: 100), () {
                          debugPrint("Error error ${snapshot.data.message}");
                          // if (!_isKeyboardOpen) return;
                          Utils.showSnackBar(snapshot.data.message, context);
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
    );
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
        hintStyle: TextStyle(
          fontSize: Dimens.fifteen,
          fontWeight: FontWeight.w500,
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
        hintStyle: TextStyle(
          fontSize: Dimens.fifteen,
          fontWeight: FontWeight.w500,
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

  Widget forgotLabel() {
    return InkWell(
      onTap: () {
        debugPrint('forgot password');
        _forgotButtonPressed(context);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: Dimens.seven),
        child: Text(
          AppString.forgot_password,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: AppColor.colored_text,
          ),
        ),
      ),
    );
  }

  Widget createAccLabel() {
    return InkWell(
      onTap: () {
        debugPrint('create account');
        Navigator.pushNamed(context, AppString.SIGN_UP_SCREEN_ROUTE);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: Dimens.seven),
        child: Text(
          AppString.not_account_yet,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: AppColor.colored_text,
          ),
        ),
      ),
    );
  }

  errorDialog() {
    printR('HELLO');
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Container(
          child: Row(
            children: [
              Icon(
                FontAwesomeIcons.exclamationCircle,
                color: Colors.red,
              ),
              SizedBox(
                width: 10,
              ),
              Text('Sorry'),
            ],
          ),
        ),
        content: Container(
          child: Text(
            'Invalid Credentials. Check username and password.',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'OK',
              style: TextStyle(
                color: black,
                fontSize: 15,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  authDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          Future.delayed(Duration(seconds: 1), () {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
            content: Container(
              child: Row(
                children: [
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.0,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Signing in.....',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _forgotButtonPressed(BuildContext context) {
    Navigator.pushNamed(context, AppString.FORGOT_PASSWORD_SCREEN_ROUTE);
  }

  _loginButtonPressed(BuildContext context) {
    if (_formKey.currentState.validate()) {
      Utils.checkConnectivity().then((value) {
        if (value) {
          UserModel userModel = UserModel(
              username: _emailController.text,
              password: _passwordController.text);
          _loginBloc.loginApi(userModel);
        } else {
          Utils.showSnackBar(
              AppString.check_your_internet_connectivity, context);
        }
      });
    }
  }

  _loginComplete(UserApiResponse _userApiResponse) {}

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
