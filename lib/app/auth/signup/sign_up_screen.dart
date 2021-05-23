import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:wayawaya/common/custom_raise_button.dart';
import 'package:wayawaya/common/full_screen_privacy_policy_dialog.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/dimens.dart';
import 'package:wayawaya/utils/utils.dart';
import 'package:intl/intl.dart' as intl;

import '../../../utils/app_color.dart';
import 'bloc/sign_up_bloc.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _emailController;
  TextEditingController _firstNameController;
  TextEditingController _lastNameController;
  TextEditingController _dobController;
  TextEditingController _passwordController;
  TextEditingController _confirmPassController;
  TextEditingController _phoneController;
  var _formKey;
  int _groupValue = -1;
  bool _newsCheck = true;
  bool _tncCheck = false;
  bool privacyPolicy = false;
  DateTime _selectedDate;

  var _signUpBloc;

  @override
  void initState() {
    super.initState();
    _initViews();
  }

  _initViews() {
    _emailController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _dobController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPassController = TextEditingController();
    _phoneController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    _signUpBloc = SignUpBloc();
  }

  _selectDate(BuildContext context) async {
    final intl.DateFormat formatter = intl.DateFormat('MM/dd/yyyy');
    DateTime newSelectedDate = await DatePicker.showSimpleDatePicker(
      context,
      initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
      dateFormat: "dd-MMMM-yyyy",
      locale: DateTimePickerLocale.en_us,
      firstDate: DateTime(1800),
      lastDate: DateTime(2040),
    );

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      _dobController
        ..text = formatter.format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _dobController.text.length,
            affinity: TextAffinity.upstream));
    }
  }

  // errorDialog() {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (_) => AlertDialog(
  //       title: Container(
  //         child: Row(
  //           children: [
  //             Icon(
  //               FontAwesomeIcons.exclamationCircle,
  //               color: Colors.red,
  //             ),
  //             SizedBox(
  //               width: 10,
  //             ),
  //             Text('Sorry'),
  //           ],
  //         ),
  //       ),
  //       content: Container(
  //         child: Text(
  //           'Invalid Credentials. Check username and password.',
  //           style: TextStyle(
  //             color: Colors.grey[600],
  //             fontSize: 14,
  //           ),
  //         ),
  //       ),
  //       actions: <Widget>[
  //         TextButton(
  //           child: Text(
  //             'OK',
  //             style: TextStyle(
  //               color: black,
  //               fontSize: 15,
  //             ),
  //           ),
  //           onPressed: () {
  //             Navigator.of(context).pop();
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      resizeToAvoidBottomInset: false,
      persistentFooterButtons: [
        SizedBox(
          height: Dimens.five,
        ),
        _newsLetterWidget(),
        SizedBox(
          height: Dimens.five,
        ),
        _termAndConditionsWidget(),
        SizedBox(
          height: Dimens.five,
        ),
        Builder(
          builder: (BuildContext context) {
            return CustomRaiseButton(
              backgroundColor: AppColor.white,
              title: AppString.submit.toUpperCase(),
              borderRadius: 0,
              width: MediaQuery.of(context).size.width,
              onPressed: () {
                _submitButtonPressed(context);
              },
            );
          },
        ),
        _privacyLabel(),
        _alreadyHaveAnAccountLabel(),
      ],
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _radioButtonWidget(),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: Dimens.ten),
                  child: Column(
                    children: [
                      _emailWidget(),
                      _firstNameWidget(),
                      _lastNameWidget(),
                      _dobWidget(),
                      _passwordWidget(),
                      _confirmPasswordWidget(),
                      _phoneNumberWidget(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _radioButtonWidget() => Container(
        height: Dimens.forty,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(bottom: Dimens.two),
        margin: EdgeInsets.only(bottom: Dimens.five),
        child: StreamBuilder<int>(
            initialData: -1,
            stream: _signUpBloc.genderStream,
            builder: (context, snapshot) {
              return Row(
                children: <Widget>[
                  Container(
                    width: Dimens.thirtyFive,
                    child: Radio(
                      value: 0,
                      groupValue: snapshot.data,
                      onChanged: (newValue) {
                        debugPrint('radio_button_click:-   $newValue');
                        _groupValue = newValue;
                        _signUpBloc.genderSink.add(_groupValue);
                      },
                      activeColor: AppColor.colored_text,
                    ),
                  ),
                  Text(
                    AppString.mr,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: Dimens.sixteen,
                    ),
                  ),
                  Container(
                    width: Dimens.thirtyFive,
                    child: Radio(
                      value: 1,
                      groupValue: snapshot.data,
                      onChanged: (newValue) {
                        debugPrint('radio_button_click:-   $newValue');
                        _groupValue = newValue;
                        _signUpBloc.genderSink.add(_groupValue);
                      },
                      activeColor: AppColor.colored_text,
                    ),
                  ),
                  Text(
                    AppString.ms,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: Dimens.sixteen,
                    ),
                  ),
                ],
              );
            }),
      );

  Widget _emailWidget() => TextFormField(
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

  Widget _firstNameWidget() => TextFormField(
        autofocus: false,
        controller: _firstNameController,
        validator: (value) {
          if (value.isEmpty) {
            return AppString.enter_your_first_name;
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: AppString.first_name,
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
        textInputAction: TextInputAction.next,
      );

  Widget _lastNameWidget() => TextFormField(
        autofocus: false,
        controller: _lastNameController,
        validator: (value) {
          if (value.isEmpty) {
            return AppString.enter_your_last_name;
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: AppString.last_name,
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
        textInputAction: TextInputAction.next,
      );

  Widget _dobWidget() => GestureDetector(
        onTap: () {
          print("dob widget click");
          _selectDate(context);
        },
        child: TextFormField(
          autofocus: false,
          controller: _dobController,
          validator: (value) {
            // if (value.isEmpty) {
            //   return AppString.enter_your_dob;
            // }
            return null;
          },
          decoration: InputDecoration(
            labelText: AppString.dob,
            alignLabelWithHint: true,
            enabled: false,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            hintText: AppString.dob,
            labelStyle: TextStyle(
              fontSize: Dimens.sixteen,
              color: Colors.black54,
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
          style: TextStyle(
            fontSize: Dimens.sixteen,
            color: Colors.black54,
            fontWeight: FontWeight.w400,
          ),
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
        ),
      );

  Widget _passwordWidget() => TextFormField(
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
        textInputAction: TextInputAction.next,
      );

  Widget _confirmPasswordWidget() => TextFormField(
        autofocus: false,
        controller: _confirmPassController,
        validator: (value) {
          if (value.isEmpty) {
            return AppString.enter_valid_confirm_password;
          } else if (value == _passwordController.text) {
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
        textInputAction: TextInputAction.next,
      );

  Widget _phoneNumberWidget() => TextFormField(
        autofocus: false,
        controller: _phoneController,
        validator: (value) {
          // if (value.isEmpty) {
          //   return AppString.enter_your_cell_number;
          // } else {
          return null;
          // }
        },
        decoration: InputDecoration(
          labelText: AppString.cell_number,
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
        textInputAction: TextInputAction.done,
      );

  Widget _privacyLabel() => InkWell(
        onTap: () {
          debugPrint('privacy policy');
          Navigator.push(
            context,
            FullScreenPrivacyPolicyDialog(
                title: AppString.privacy_policy,
                url: AppString.PRIVACY_POLICY_URL),
          ).then((value) {
            if (value != null) privacyPolicy = value;

            debugPrint('Privacy Policy   $privacyPolicy');
          });
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: Dimens.seven),
          child: Text(
            AppString.privacy_policy,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: AppColor.colored_text,
            ),
          ),
        ),
      );

  Widget _alreadyHaveAnAccountLabel() => InkWell(
        onTap: () {
          debugPrint('Already have an account');
          Navigator.pop(context);
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: Dimens.seven),
          child: Text(
            AppString.already_have_an_account,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: AppColor.colored_text,
            ),
          ),
        ),
      );

  Widget _newsLetterWidget() => Container(
        height: Dimens.thirty,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            SizedBox(
              width: Dimens.twentyFour,
              child: StreamBuilder<bool>(
                  initialData: true,
                  stream: _signUpBloc.newsLetterStream,
                  builder: (context, snapshot) {
                    return Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: snapshot.data,
                      onChanged: (bool value) {
                        _newsCheck = value;
                        _signUpBloc.newsLetterSink.add(_newsCheck);
                        debugPrint('News Letter :-  $_newsCheck');
                      },
                    );
                  }),
            ),
            SizedBox(
              width: Dimens.twentyFour,
            ),
            Text(
              AppString.news_letter,
              style: TextStyle(
                fontSize: Dimens.seventeen,
                color: AppColor.secondaryColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      );

  Widget _termAndConditionsWidget() => Container(
        height: Dimens.thirty,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: Dimens.twentyFour,
              child: StreamBuilder<bool>(
                  initialData: false,
                  stream: _signUpBloc.tACStream,
                  builder: (context, snapshot) {
                    return Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: snapshot.data,
                      onChanged: (bool value) {
                        _termAndConditionOnClick();
                      },
                    );
                  }),
            ),
            GestureDetector(
              onTap: () {
                _termAndConditionOnClick();
              },
              child: SizedBox(
                width: Dimens.twentyFour,
              ),
            ),
            GestureDetector(
              onTap: () {
                _termAndConditionOnClick();
              },
              child: Text(
                AppString.term_and_conditions,
                style: TextStyle(
                  fontSize: Dimens.seventeen,
                  color: AppColor.secondaryColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      );

  _termAndConditionOnClick() {
    debugPrint('Term and condition');
    if (_tncCheck) {
      _tncCheck = false;
      _signUpBloc.tACSink.add(_tncCheck);
    } else {
      Navigator.push(
        context,
        FullScreenPrivacyPolicyDialog(
            title: AppString.term_and_conditions,
            url: AppString.TERMS_CONDITION_URL),
      ).then((value) {
        setState(() {
          if (value != null) {
            _tncCheck = value;
            _signUpBloc.tACSink.add(_tncCheck);

            debugPrint('Term and condition  --->  $_tncCheck');
          }
        });
      });
    }
  }

  void _submitButtonPressed(BuildContext context) {
    if (_formKey.currentState.validate() && _tncCheck == true) {
      _formKey.currentState.save();
    }
  }

  @override
  void dispose() {
    if (_emailController != null) _emailController.dispose();
    if (_firstNameController != null) _firstNameController.dispose();
    if (_lastNameController != null) _lastNameController.dispose();
    if (_dobController != null) _dobController.dispose();
    if (_passwordController != null) _passwordController.dispose();
    if (_confirmPassController != null) _confirmPassController.dispose();
    if (_phoneController != null) _phoneController.dispose();
    super.dispose();
  }
}
