import 'package:flutter/material.dart';

void main() {
  runApp(LoginApp());
}
Map<String, String> registeredUsers = {}; // 保存用户名和密码

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      theme: ThemeData(primarySwatch:Colors.blue),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  void _login() {
  String username = _usernameController.text;
  String password = _passwordController.text;

  if (registeredUsers.containsKey(username) && registeredUsers[username] == password) {
    setState(() {
      _errorMessage = '';
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage(username: username)),
    );
  } else {
    setState(() {
      _errorMessage = '用户名或密码错误';
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('登录')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: '用户名'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: '密码'),
              obscureText: true,
            ),
            
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login, 
              child: Text('登录'),
            ),
            SizedBox(height: 10),
            Text(
              _errorMessage,
              style: TextStyle(color: Colors.red),
            ),
            TextButton(
            onPressed: () {
            Navigator.push(
            context,
             MaterialPageRoute(builder: (context) => RegisterPage()),
            );
            },
            child: Text('还没有账号？点击注册'),
            )

          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final String username;

  HomePage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('欢迎')),
      body: Center(
      child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('欢迎你，$username！', style: TextStyle(fontSize: 24)),
        SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // 返回登录页
              },
              child: Text('退出登录'),
            )
        ]
      ),
      )
    );
  }
}
class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _newUsernameController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  String _message = '';

  void _register() {
    String newUsername = _newUsernameController.text;
    String newPassword = _newPasswordController.text;

    if (newUsername.isEmpty || newPassword.isEmpty) {
      setState(() {
        _message = '用户名和密码不能为空';
      });
    } else if (registeredUsers.containsKey(newUsername)) {
      setState(() {
        _message = '用户名已存在';
      });
    } else {
      registeredUsers[newUsername] = newPassword;
      setState(() {
        _message = '注册成功！请返回登录';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('注册')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [
            TextField(
              controller: _newUsernameController,
              decoration: InputDecoration(labelText: '新用户名'),
            ),
            TextField(
              controller: _newPasswordController,
              decoration: InputDecoration(labelText: '新密码'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _register,
              child: Text('注册'),
            ),
            SizedBox(height: 10),
            Text(
              _message,
              style: TextStyle(color: _message.contains('成功') ? Colors.green : Colors.red),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // 返回登录页
              },
              child: Text('返回登录'),
            )
          ],
        ),
      ),
    );
  }
}
