import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wayawaya/app/common/dialogs/common_error_dialog.dart';
import 'package:wayawaya/common/custom_raise_button.dart';
import 'package:wayawaya/network/live/model/api_response.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/dimens.dart';
import 'package:wayawaya/utils/utils.dart';

import 'bloc/forgot_password_bloc.dart';
import 'model/authentication_code_model.dart';
import 'model/error_response.dart';

class ForgotPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ForgotPasswordState();
}

class ForgotPasswordState extends State<ForgotPassword> {
  var _formKey;
  var _formKey2;

  TextEditingController _emailController;
  TextEditingController _codeController;
  TextEditingController _passController;
  TextEditingController _confirmPassController;
  var _forgotPasswordBloc;

  @override
  void initState() {
    super.initState();
    _initViews();
  }

  _initViews() {
    debugPrint('performance_testing:-   forgot password initState ');
    _formKey = GlobalKey<FormState>();
    _formKey2 = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _codeController = TextEditingController();
    _passController = TextEditingController();
    _confirmPassController = TextEditingController();
    _forgotPasswordBloc = ForgotPasswordBloc();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('performance_testing:-   forgot password build method call ');
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppString.enter_your_email_phone_username,
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 15,
                      ),
                    ),
                    TextFormField(
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
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Builder(
                      builder: (BuildContext context) {
                        return CustomRaiseButton(
                          backgroundColor: AppColor.white,
                          title: AppString.submit.toUpperCase(),
                          borderRadius: 0,
                          width: MediaQuery.of(context).size.width,
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              FocusScope.of(context).unfocus();
                              _forgotPasswordApi();
                            }
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    Builder(
                      builder: (BuildContext context) {
                        return CustomRaiseButton(
                          backgroundColor: AppColor.white,
                          title: AppString.cancel.toUpperCase(),
                          borderRadius: 0,
                          width: MediaQuery.of(context).size.width,
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            StreamBuilder<ApiResponse<ErrorResponse>>(
              stream: _forgotPasswordBloc.loginStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  switch (snapshot.data.status) {
                    case Status.LOADING:
                      {
                        Future.delayed(Duration(milliseconds: 200), () {
                          Utils.commonProgressDialog(context);
                        });
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.transparent,
                          height: MediaQuery.of(context).size.height,
                        );
                      }
                      break;
                    case Status.COMPLETED:
                      {
                        debugPrint("completed");
                        _successApiResponse(snapshot.data.data.differ);
                      }
                      break;
                    case Status.ERROR:
                      {
                        debugPrint("error:-   ${snapshot.data.data.message}");
                        _errorApiResponse(
                            data: snapshot.data.data.differ,
                            message: snapshot.data.data.message);
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

  _successApiResponse(String data) {
    Navigator.pop(context);
    if (data == "FORGOT_PASSWORD" || data == "REQUEST_CODE") {
      Future.delayed(Duration(milliseconds: 300), () {
        commonErrorAndSuccessDialog(
            title: AppString.success,
            content: AppString.verification_email_has_been_sent,
            onPressed: () {
              Navigator.pop(context);
              Future.delayed(
                  Duration(milliseconds: 300), () => passResetDialog());
            });
      });
    } else if (data == "AUTHENTICATE_CODE") {
      Future.delayed(Duration(milliseconds: 300), () {
        commonErrorAndSuccessDialog(
            title: AppString.success,
            content: AppString.password_change_successfully,
            buttonText: AppString.login.toUpperCase(),
            onPressed: () {
              Navigator.pop(context);
              Future.delayed(
                  Duration(milliseconds: 300), () => Navigator.pop(context));
            });
      });
    }
  }

  _errorApiResponse({String data, String message}) {
    Navigator.pop(context);
    if (data == "FORGOT_PASSWORD" || data == "REQUEST_CODE") {
      Future.delayed(Duration(milliseconds: 300), () {
        debugPrint("Error error $data");
        commonErrorAndSuccessDialog(
            title: AppString.error,
            content: message,
            onPressed: () => Navigator.pop(context));
      });
    } else if (data == "AUTHENTICATE_CODE") {
      Future.delayed(Duration(milliseconds: 300), () {
        debugPrint("Error error $data");
        commonErrorAndSuccessDialog(
            title: AppString.error,
            content: message,
            onPressed: () => Navigator.pop(context));
      });
    }
  }

  // widget of email field

  commonErrorAndSuccessDialog(
      {String title,
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
              child: AlertDialog(
                title: Text(title),
                content: Container(
                  child: Text(
                    content,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                      height: 1.2,
                    ),
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text(
                      buttonText ?? AppString.ok,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    onPressed: onPressed,
                  ),
                ],
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

  passResetDialog() {
    showGeneralDialog(
      barrierColor: Colors.black.withOpacity(0.1),
      transitionBuilder: (context, a1, a2, widget) {
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              insetPadding: EdgeInsets.all(10),
              title: Text(AppString.password_reset),
              content: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _authenticationCode(),
                    Form(
                      key: _formKey2,
                      child: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _passwordField(),
                            _confirmPasswordField(),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 60,
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      debugPrint("Request code ");
                                      Navigator.pop(context);
                                      _requestCodeApi();
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(0, 5, 10, 5),
                                      child: Text(
                                        AppString.request_code.toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      debugPrint("cancel");
                                      Navigator.pop(context);
                                    },
                                    child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 5, 10, 5),
                                      child: Text(
                                        AppString.cancel.toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      debugPrint("ok");
                                      _authenticationApiResponse();
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
                                      child: Text(
                                        AppString.ok.toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
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
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 300),
      barrierDismissible: false,
      barrierLabel: '',
      context: context,
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {},
    );
  }

  Widget _authenticationCode() {
    return TextFormField(
      autofocus: false,
      controller: _codeController,
      decoration: InputDecoration(
        labelText: AppString.authentication_code,
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
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
    );
  }

  Widget _passwordField() {
    return TextFormField(
      autofocus: false,
      controller: _passController,
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
      textInputAction: TextInputAction.next,
    );
  }

  Widget _confirmPasswordField() {
    return TextFormField(
      autofocus: false,
      controller: _confirmPassController,
      validator: (value) {
        if (value.isEmpty) {
          return AppString.enter_valid_confirm_password;
        } else if (value == _passController.text) {
          return AppString.password_and_confirm_password_must_be_same;
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        labelText: AppString.confirm_password,
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

  // forgot password api (which send the reset email)
  _forgotPasswordApi() {
    Utils.checkConnectivity().then((value) {
      if (value) {
        _forgotPasswordBloc.forgotPasswordApi(
            _emailController.text, "FORGOT_PASSWORD");
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

  // forgot password api (which send the reset email)
  _requestCodeApi() {
    Utils.checkConnectivity().then((value) {
      if (value) {
        _forgotPasswordBloc.forgotPasswordApi(
            _emailController.text, "REQUEST_CODE");
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

  // authentication code
  _authenticationApiResponse() {
    if (_codeController.text.isEmpty) {
      Utils.showSnackBar(AppString.enter_authentication_code, context);
      return;
    }
    if (_passController.text.isEmpty) {
      Utils.showSnackBar(AppString.enter_valid_password, context);
      return;
    }
    if (_confirmPassController.text.isEmpty) {
      Utils.showSnackBar(AppString.enter_valid_confirm_password, context);
      return;
    } else if (_passController.text != _confirmPassController.text) {
      Utils.showSnackBar(
          AppString.password_and_confirm_password_must_be_same, context);
      return;
    } else {
      Utils.checkConnectivity().then((value) {
        if (value) {
          AuthenticationCodeModel authenticationCodeModel =
              AuthenticationCodeModel();
          authenticationCodeModel.password =
              _confirmPassController.text.toString();
          authenticationCodeModel.code = _codeController.text.toString();
          authenticationCodeModel.user_name = _emailController.text.toString();
          Navigator.pop(context);
          _forgotPasswordBloc.authenticationCodeApi(_emailController.text,
              authenticationCodeModel, "AUTHENTICATE_CODE");
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

  @override
  void dispose() {
    if (_emailController != null) _emailController.dispose();
    if (_codeController != null) _codeController.dispose();
    if (_passController != null) _passController.dispose();
    if (_confirmPassController != null) _confirmPassController.dispose();
    super.dispose();
  }
}
