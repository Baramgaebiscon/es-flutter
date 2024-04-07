import 'dart:convert';
import 'package:es_flutter_application/next.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(
        title: 'Flutter Demo Home Page',
        userIdController: TextEditingController(),
        passwordController: TextEditingController(),
      ),
    );
  }
}

// ignore: must_be_immutable
class MyHomePage extends StatelessWidget {
  MyHomePage(
      {super.key,
      required this.title,
      required this.userIdController,
      required this.passwordController});

  String title;
  TextEditingController userIdController;
  TextEditingController passwordController;

  Future<http.Response> login(String id, String pw) async {
    var url = Uri.http('localhost:8080', '/login');

    var body = json.encode({'id': id, 'password': pw});

    return await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 300,
                child: CupertinoTextField(
                  controller: userIdController,
                  placeholder: '아이디를 입력해주세요',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 300,
                child: CupertinoTextField(
                  controller: passwordController,
                  placeholder: '비밀번호를 입력해주세요',
                  textAlign: TextAlign.center,
                  obscureText: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 250,
                child: ElevatedButton(
                  onPressed: () async {
                    print('call login');

                    final loginReponse = await login(
                        userIdController.text, passwordController.text);

                    if (loginReponse.statusCode == 200) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NextPage(title: 'next page',),
                        ),
                      );
                    }
                  },
                  child: Text('로그인'),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
