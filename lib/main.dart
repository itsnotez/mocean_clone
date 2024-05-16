import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mocean_app/biometric_auth.dart';
import 'package:mocean_app/main_screen.dart';
import 'package:mocean_app/pin_entry_screen.dart';
import 'package:mocean_app/reset_password_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  bool _rememberMe = false;

  String? _idError;
  String? _passwordError;

  @override
  void initState() {
    super.initState();
    _loadSavedId();
  }

  void _loadSavedId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedId = prefs.getString('savedId');
    if (savedId != null) {
      _idController.text = savedId;
      setState(() {
        _rememberMe = true;
      });
    }
  }

  void _saveId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_rememberMe) {
      prefs.setString('savedId', _idController.text);
    } else {
      prefs.remove('savedId');
    }
  }

  void _showLoginOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '다른 로그인 방식',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              ListTile(
                leading: Icon(Icons.fingerprint, color: Colors.green),
                title: Text('생체'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BiometricAuthScreen()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.pin, color: Colors.green),
                title: Text('간편 핀'),
                onTap: () {
                  // 간편 핀 로그인 로직 추가
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PinEntryScreen()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.person, color: Colors.green),
                title: Text('아이디'),
                onTap: () {
                  // 아이디 로그인 로직 추가
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _validateAndSubmit() {
    setState(() {
      _idError = null;
      _passwordError = null;

      if (_idController.text.isEmpty) {
        _idError = '아이디를 입력해 주세요';
      }
      String password = _passwordController.text;

      if (password.isEmpty) {
        _passwordError = '비밀번호를 입력해 주세요';
      } else if (!_isPasswordValid(password)) {
        _passwordError = '비밀번호가 유효하지 않습니다.';
      }
      if (_idError == null && _passwordError == null) {
        _saveId();
        //TODO
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()),
        );
      }
    });
  }

  bool _isPasswordValid(String password) {
    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    bool hasDigits = password.contains(RegExp(r'[0-9]'));
    bool hasSpecialCharacters =
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    int count = (hasUppercase ? 1 : 0) +
        (hasLowercase ? 1 : 0) +
        (hasDigits ? 1 : 0) +
        (hasSpecialCharacters ? 1 : 0);

    if (count >= 3 && password.length >= 8) {
      return true;
    } else if (count >= 2 && password.length >= 10) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/logo.png',
                height: 150.0,
              ),
              SizedBox(height: 40),
              TextField(
                controller: _idController,
                decoration: InputDecoration(
                  labelText: '아이디',
                  border: OutlineInputBorder(),
                  errorText: _idError,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: '비밀번호',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  errorText: _passwordError,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Checkbox(
                      value: _rememberMe,
                      onChanged: (bool? value) {
                        setState(() {
                          _rememberMe = value ?? false;
                        });
                      }),
                  Text('아이디 저장'),
                ],
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _validateAndSubmit,
                  child: Text('LOGIN'),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      // 비밀번호 초기화 동작 정의
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResetPasswordPage()));
                    },
                    child: Text(
                      '비밀번호 초기화',
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      _showLoginOptions(context);
                    },
                    child: Text(
                      '다른 로그인 방식',
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  // 개인정보처리방침 동작 정의
                },
                child: Text(
                  '개인정보처리방침',
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
