import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:wayawaya/common/custom_raise_button.dart';
import 'package:wayawaya/common/full_screen_dialog_with_web_view.dart';
import 'package:wayawaya/utils/app_color.dart';
import 'package:wayawaya/utils/app_strings.dart';
import 'package:wayawaya/utils/dimens.dart';
import 'package:wayawaya/utils/utils.dart';

import '../../../constants.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPassController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int _groupValue = -1;
  bool _newsCheck = true;
  bool _tncCheck = false;
  bool privacyPolicy = false;
  bool _genderSelected = false;
  bool showHint = true;
  bool showLabel = false;
  DateTime _selectedDate;

  // _selectDate(BuildContext context) async {
  //   final intl.DateFormat formatter = intl.DateFormat('MM/dd/yyyy');
  //   setState(() {
  //     showHint = false;
  //     showLabel = true;
  //   });
  //   DateTime newSelectedDate = await DatePicker.showSimpleDatePicker(
  //     context,
  //     initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
  //     dateFormat: "dd-MMMM-yyyy",
  //     locale: DateTimePickerLocale.en_us,
  //     firstDate: DateTime(1800),
  //     lastDate: DateTime(2040),
  //   );
  //
  //   if (newSelectedDate != null) {
  //     _selectedDate = newSelectedDate;
  //     _dobController
  //       ..text = formatter.format(_selectedDate)
  //       ..selection = TextSelection.fromPosition(TextPosition(
  //           offset: _dobController.text.length,
  //           affinity: TextAffinity.upstream));
  //   }
  // }

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

  // tncDialog() {
  //   bool tnc;
  //   showDialog(
  //     context: context,
  //     barrierDismissible: true,
  //     builder: (_) => AlertDialog(
  //       title: Text('Terms and Conditions'),
  //       insetPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 70),
  //       content: Container(
  //         child: SingleChildScrollView(
  //           child: Column(
  //             children: [
  //               Text(
  //                 'Terms and Conditions: Free WI-FI Service'.toUpperCase(),
  //                 style: TextStyle(
  //                   color: Colors.grey[600],
  //                   fontSize: 17,
  //                   height: 1.5,
  //                 ),
  //               ),
  //               Container(
  //                 height: 270,
  //                 child: Align(
  //                   alignment: Alignment.centerLeft,
  //                   child: Text(
  //                     'INTRODUCTION',
  //                     style: TextStyle(
  //                       color: Colors.grey[600],
  //                       fontSize: 16,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               Text(
  //                 '1.1    Vulkile Property Fund Limited(herein reffered to as "Vulkile") is the registered owner of various shopping centers within South Africa.',
  //                 style: TextStyle(
  //                   color: Colors.grey[600],
  //                   fontSize: 16,
  //                   height: 1.5,
  //                 ),
  //                 textAlign: TextAlign.start,
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //       actions: <Widget>[
  //         TextButton(
  //           child: Text(
  //             'DISAGREE',
  //             style: TextStyle(
  //               color: black,
  //               fontSize: 15,
  //             ),
  //           ),
  //           onPressed: () {
  //             setState(() {
  //               tnc = false;
  //               _tncCheck = tnc;
  //             });
  //             Navigator.of(context).pop();
  //           },
  //         ),
  //         TextButton(
  //           child: Text(
  //             'AGREE',
  //             style: TextStyle(
  //               color: black,
  //               fontSize: 15,
  //             ),
  //           ),
  //           onPressed: () {
  //             setState(() {
  //               tnc = true;
  //               _tncCheck = tnc;
  //             });
  //             Navigator.of(context).pop();
  //           },
  //         ),
  //       ],
  //     ),
  //   ).then((value) {
  //     if(tnc) print('I AM TRUE');
  //     else print('I AM FALSE');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // var user = Provider.of<AuthProvider>(context, listen: true);

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
                // _loginButtonPressed(context);
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
        child: Row(
          children: <Widget>[
            Container(
              width: Dimens.thirtyFive,
              child: Radio(
                value: 0,
                groupValue: _groupValue,
                onChanged: (newValue) => setState(() {
                  _groupValue = newValue;
                  _genderSelected = true;
                }),
                activeColor: appLightColor,
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
                groupValue: _groupValue,
                onChanged: (newValue) => setState(() {
                  _groupValue = newValue;
                  _genderSelected = true;
                }),
                activeColor: appLightColor,
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
        ),
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
        },
        child: TextFormField(
          autofocus: false,
          controller: _dobController,
          validator: (value) {
            if (value.isEmpty) {
              return AppString.enter_your_dob;
            }
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
          if (value.isEmpty) {
            return AppString.enter_your_cell_number;
          } else {
            return null;
          }
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
          Navigator.of(context).push(FullScreenDialogWithWebView());
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
              child: Checkbox(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: _newsCheck,
                onChanged: (bool value) {
                  setState(() {
                    _newsCheck = value;
                  });
                },
              ),
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
        child: InkWell(
          onTap: () {
            // tncDialog();
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: Dimens.twentyFour,
                child: Checkbox(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  value: _tncCheck,
                  onChanged: (bool value) {
                    // tncDialog();
                  },
                ),
              ),
              SizedBox(
                width: Dimens.twentyFour,
              ),
              Text(
                AppString.term_and_conditions,
                style: TextStyle(
                  fontSize: Dimens.seventeen,
                  color: AppColor.secondaryColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      );

  privacyDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => AlertDialog(
        title: Text(AppString.privacy_policy),
        insetPadding: EdgeInsets.symmetric(
            horizontal: Dimens.twentyFour, vertical: Dimens.ten),
        contentPadding: EdgeInsets.zero,
        content: Container(
          margin: EdgeInsets.only(top: Dimens.two),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: Dimens.oneThirty,
                  color: Color(0xffC3C0D3),
                  padding: EdgeInsets.only(left: Dimens.fortyFive),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Image.asset(
                      'assets/yellow_fist_bump.png',
                      height: Dimens.forty,
                      width: Dimens.forty,
                    ),
                  ),
                ),
                Container(
                  color: Color(0xffDEDCE7),
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimens.twenty, vertical: Dimens.twentyFive),
                  child: WebviewScaffold(
                    url: "https://instagram.com/mahi7781",
                    withZoom: true,
                    withLocalStorage: true,
                    initialChild: Container(
                      child: const Center(
                        child: Text("Loading...."),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              AppString.disagree.toUpperCase(),
              style: TextStyle(
                color: Colors.black,
                fontSize: Dimens.fifteen,
              ),
            ),
            onPressed: () {
              privacyPolicy = false;
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(
              AppString.agree.toUpperCase(),
              style: TextStyle(
                color: Colors.black,
                fontSize: Dimens.fifteen,
              ),
            ),
            onPressed: () {
              privacyPolicy = true;
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
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
