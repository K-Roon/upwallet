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
      home: Scaffold(
        appBar: AppBar(
          title: const Text('upwallet'),
        ),
        body: const PassForm(),
      ),
    );
  }
}

class PassForm extends StatefulWidget {
  const PassForm({super.key});

  @override
  _PassFormState createState() => _PassFormState();
}

class _PassFormState extends State<PassForm> {
  final _controller = TextEditingController();

  Future<void> _addPassToWallet(String code) async {
    // 서버에서 Pass 파일을 생성하고 URL을 반환하는 API 호출
    final response = await http.post(
      Uri.parse('https://upwallet-764a8.firebaseapp.com/create-pass'),
      body: {'code': code},
    );

    if (response.statusCode == 200) {
      final passUrl = response.body;
      // Apple Wallet에 Pass 추가하는 로직
      // ...
    } else {
      // 오류 처리
      print('Failed to create pass');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(labelText: 'Enter Code'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _addPassToWallet(_controller.text);
            },
            child: const Text('Add to Wallet'),
          ),
        ],
      ),
    );
  }
}
