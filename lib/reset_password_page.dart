import 'package:flutter/material.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _additionalController = TextEditingController();
  bool _isEmployee = true;

  //에러 상태를 관리하는 함수
  String? _idError;
  String? _additionalError;

  void _validateAndSubmit() {
    setState(() {
      // 초기화
      _idError = null;
      _additionalError = null;

      if (_idController.text.isEmpty) {
        _idError = '아이디를 입력해 주세요';
      }
      if (_additionalController.text.isEmpty) {
        _additionalError = _isEmployee ? '생년월일을 입력해 주세요' : '사업자등록번호를 입력해 주세요';
      }
      if (_idError == null && _additionalError == null) {
        // TODO
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('비밀번호 초기화'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      '비밀번호 초기화',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('통합인증계정 비밀번호 초기화'),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      // 정직원 탭 클릭 시 동작 정의
                      setState(() {
                        _isEmployee = true;
                      });
                    },
                    child: Text(
                      '정직원',
                      style: TextStyle(
                        color: _isEmployee ? Colors.green : Colors.black,
                        fontWeight:
                            _isEmployee ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  TextButton(
                    onPressed: () {
                      // 비직원 탭 클릭 시 동작 정의
                      setState(() {
                        _isEmployee = false;
                      });
                    },
                    child: Text(
                      '비직원',
                      style: TextStyle(
                        color: !_isEmployee ? Colors.green : Colors.black,
                        fontWeight:
                            !_isEmployee ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              TextField(
                controller: _idController,
                decoration: InputDecoration(
                  labelText: '아이디(사번)',
                  border: OutlineInputBorder(),
                  errorText: _idError,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _additionalController,
                decoration: InputDecoration(
                  labelText: _isEmployee ? '생년월일' : '사업자등록번호',
                  border: OutlineInputBorder(),
                  errorText: _additionalError,
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _validateAndSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: Text('확인'),
                ),
              ),
              SizedBox(height: 20),
              Text(
                '• 초기화 시 등록된 핸드폰번호로 임시비밀번호가 발송됩니다.\n'
                '• 핸드폰번호 미등록 경우 임시비밀번호 발송이 불가 합니다. PC 통합인증 프로그램을 이용하여 비밀번호 초기화를 해주십시오. (핸드폰번호 등록 후 임시비밀번호 발송가능)\n'
                '• MOcean 및 PC 통합인증 프로그램 모두 발송된 임시비밀번호를 이용해주십시오.\n'
                '• 비밀번호 변경은 MOcean 및 PC 통합인증 로그인 후 아래에서 하실 수 있습니다.\n'
                '[MOcean] MOcean 로그인 > 우측상단 사람 모양 아이콘 > 비밀번호 변경\n'
                '[PC] 통합인증 로그인 > 통합아이디관리센터 > 개인정보관리 > 비밀번호 수정\n',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
