import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart' as intl;
import 'package:provider/provider.dart';
import '../config.dart';
import '../constants.dart';
import '../providers/auth.dart';
import '../widgets/custom_teal_text.dart';
import '../widgets/custom_text_button.dart';
import '../widgets/custom_text_field.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'home.dart';
import 'login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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

  _selectDate(BuildContext context) async {
    final intl.DateFormat formatter = intl.DateFormat('MM/dd/yyyy');
    setState(() {
      showHint = false;
      showLabel = true;
    });
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

  errorDialog() {
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

  tncDialog() {
    bool tnc;
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => AlertDialog(
        title: Text('Terms and Conditions'),
        insetPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 70),
        content: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Terms and Conditions: Free WI-FI Service'.toUpperCase(),
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 17,
                    height: 1.5,
                  ),
                ),
                Container(
                  height: 270,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'INTRODUCTION',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Text(
                  '1.1    Vulkile Property Fund Limited(herein reffered to as "Vulkile") is the registered owner of various shopping centers within South Africa.',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'DISAGREE',
              style: TextStyle(
                color: black,
                fontSize: 15,
              ),
            ),
            onPressed: () {
              setState(() {
                tnc = false;
                _tncCheck = tnc;
              });
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(
              'AGREE',
              style: TextStyle(
                color: black,
                fontSize: 15,
              ),
            ),
            onPressed: () {
              setState(() {
                tnc = true;
                _tncCheck = tnc;
              });
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    ).then((value) {
      if(tnc) print('I AM TRUE');
      else print('I AM FALSE');
    });
  }

  privacyDialog() {
    Color _dark = Color(0xffC3C0D3);
    Color _light = Color(0xffDEDCE7);
    Color _text = Color(0xff585185);
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => AlertDialog(
        title: Text('Privacy Policy'),
        insetPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        contentPadding: EdgeInsets.zero,
        content:
        Container(
          margin: EdgeInsets.only(top: 2),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 130,
                  color: _dark,
                  padding: EdgeInsets.only(left: 45),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Image.asset(
                      'assets/yellow_fist_bump.png',
                      height: 40,
                      width: 40,
                    ),
                  ),
                ),
               Container(
                 color: _light,
                 padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(
                       'VULKILE PRIVACY NOTICE: FREE WI-FI AND SHOPPING APP SERVICE',
                       style: TextStyle(
                         color: _text,
                         fontSize: 20,
                         fontWeight: FontWeight.bold,
                         height: 1.5,
                       ),
                       textAlign: TextAlign.start,
                     ),
                     SizedBox(
                       height: 20,
                     ),
                     Text(
                       'I. INTRODUCTION',
                       style: TextStyle(
                         color: _text,
                         fontSize: 18,
                         fontWeight: FontWeight.bold,
                       ),
                     ),
                     SizedBox(
                       height: 15,
                     ),
                     Text(
                       'When you use our Connect Waya-Waya® mobile application, you trust us with your personal data. We\'re committed to keeping that trust. That starts with helping you understand our privacy practices.',
                       style: TextStyle(
                         color: _text,
                         fontSize: 16,
                         fontWeight: FontWeight.w400,
                       ),
                     ),
                     SizedBox(
                       height: 20,
                     ),
                     Text(
                       'This notice describes the personal data we collect, how it\'s used and shared, and your choices regarding this data.',
                       style: TextStyle(
                         color: _text,
                         fontSize: 16,
                       ),
                     ),
                     SizedBox(
                       height: 20,
                     ),
                     Text(
                       'II. OVERVIEW',
                       style: TextStyle(
                         color: _text,
                         fontSize: 18,
                         fontWeight: FontWeight.bold,
                       ),
                     ),
                   ],
                 ),
               ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'DISAGREE',
              style: TextStyle(
                color: black,
                fontSize: 15,
              ),
            ),
            onPressed: () {
              setState(() {
                privacyPolicy = false;
              });
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(
              'AGREE',
              style: TextStyle(
                color: black,
                fontSize: 15,
              ),
            ),
            onPressed: () {
              setState(() {
                privacyPolicy = true;
              });
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<AuthProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: bgColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Container(
            height: App.height(context),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Container(
                        height: 40,
                        width: App.width(context),
                        padding: EdgeInsets.only(bottom: 2),
                        margin: EdgeInsets.only(bottom: 5),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 35,
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
                              'Mr.',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            Container(
                              width: 35,
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
                              'Ms.',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            customTextField(
                                controller: _emailController,
                                hint: 'Email',
                                keyboard: TextInputType.emailAddress,
                                showHint: showHint,
                                showLabel: showLabel,
                                autoValidate: true,
                                onTap: () {
                                  setState(() {
                                    showHint = false;
                                    showLabel = true;
                                  });
                                },
                                validator: (value) => (value.isEmpty)
                                    ? "Enter valid email address"
                                    : null),
                            customTextField(
                                controller: _firstNameController,
                                hint: 'First Name',
                                showHint: showHint,
                                showLabel: showLabel,
                                autoValidate: true,
                                onTap: () {
                                  setState(() {
                                    showHint = false;
                                    showLabel = true;
                                  });
                                },
                                validator: (value) => (value.isEmpty)
                                    ? "Enter your first name"
                                    : null),
                            customTextField(
                                controller: _lastNameController,
                                hint: 'Last Name',
                                showHint: showHint,
                                showLabel: showLabel,
                                autoValidate: true,
                                onTap: () {
                                  setState(() {
                                    showHint = false;
                                    showLabel = true;
                                  });
                                },
                                validator: (value) => (value.isEmpty)
                                    ? "Enter your last name"
                                    : null),
                            customTextField(
                              controller: _dobController,
                              hint: 'Date of Birth',
                              showHint: showHint,
                              showLabel: showLabel,
                              onTap: () {
                                _selectDate(context);
                              },
                            ),
                            customTextField(
                                controller: _passwordController,
                                obscure: true,
                                hint: 'Password',
                                showHint: showHint,
                                showLabel: showLabel,
                                autoValidate: true,
                                onTap: () {
                                  setState(() {
                                    showHint = false;
                                    showLabel = true;
                                  });
                                },
                                validator: (value) => (value.isEmpty)
                                    ? "Enter the password"
                                    : null),
                            customTextField(
                              controller: _confirmPassController,
                              obscure: true,
                              showHint: showHint,
                              showLabel: showLabel,
                              hint: 'Confirm Password',
                              autoValidate: true,
                              onTap: () {
                                setState(() {
                                  showHint = false;
                                  showLabel = true;
                                });
                              },
                              validator: (value) {
                                if (value.isEmpty)
                                  return "Enter the password";
                                else if (value != _passwordController.text)
                                  return "Password not a match";
                              },
                            ),
                            customTextField(
                                controller: _phoneController,
                                hint: 'Cell Number',
                                keyboard: TextInputType.number,
                                showHint: showHint,
                                showLabel: showLabel,
                                onTap: () {
                                  setState(() {
                                    showHint = false;
                                    showLabel = true;
                                  });
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Container(
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 35,
                          child: Row(
                            children: [
                              Checkbox(
                                value: _newsCheck,
                                onChanged: (bool value) {
                                  setState(() {
                                    _newsCheck = value;
                                  });
                                },
                              ),
                              Text(
                                'Newsletter',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: hintColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 35,
                          child:
                          InkWell(
                            onTap: () {
                              tncDialog();
                            },
                            child: Row(
                              children: [
                                Checkbox(
                                  value: _tncCheck,
                                  onChanged: (bool value) {
                                   tncDialog();
                                  },
                                ),
                                Text(
                                  'Terms and Conditions',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: hintColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        customTextButton(
                            title: 'SUBMIT',
                            shadow: Colors.white,
                            onTap: () {
                              if (_formKey.currentState.validate() &&
                                  _genderSelected == true &&
                                  _tncCheck == true &&
                                  _newsCheck == true) {
                                _formKey.currentState.save();
                                user
                                    .register(
                                  firstName: _firstNameController.text,
                                  lastName: _lastNameController.text,
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  phone: _phoneController.text,
                                  dob: _dobController.text,
                                )
                                    .then((val) {
                                  printY(val.toString());
                                  switch (val) {
                                    case Status.Registered:
                                      return App.prefs.setBool('homeGestures', true).whenComplete(() => App.pushTo(
                                        context: context, screen: HomeScreen(),
                                      ));
                                    case Status.NotRegistered:
                                      return Future.delayed(
                                          Duration(milliseconds: 300),
                                          () => errorDialog());
                                    case Status.Registering:
                                      return Future.delayed(
                                          Duration(milliseconds: 300),
                                          () => errorDialog());
                                    // ignore: unnecessary_statements
                                    default: null;
                                  }
                                });
                              } else
                                // ignore: unnecessary_statements
                                null;
                            }),
                        Container(
                          height: 50,
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              customText(
                                  text: 'Privacy Policy',
                                  context: context,
                                  onTap: () => privacyDialog()),
                              customText(
                                  text: 'Already have an Account?',
                                  context: context,
                                  onTap: () => Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                          builder: (_) => Login()))),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
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
  }
}
