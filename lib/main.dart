import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

//Register function fopr POST request to API
Future<http.Response> registerUser(
    String uname, String email, String password, String mobile) {
  return http.post(
    Uri.parse('http://52.206.48.46/api/register '),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': uname,
      'email': email,
      'password': password,
      'mobileNumber': mobile
    }),
  );
}

//Login function fopr POST request to API
Future<http.Response> login(String email, String password) {
  return http.post(
    Uri.parse('http://52.206.48.46/api/login '),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bronzed Blue App',
      theme: ThemeData(useMaterial3: true, primaryColor: Colors.black),
      home: const MyHomePage(title: 'Bronzed Blue App Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  final _loginFormkey = GlobalKey<FormState>();
  bool _hideText = true;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('BronzedBlue',
                style: TextStyle(
                    fontWeight: FontWeight.bold, height: 2, fontSize: 50.0)),
            SizedBox(height: 20),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                  key: _loginFormkey,
                  child: Column(children: [
                    TextFormField(
                      controller: emailController,
                      cursorColor: theme.colorScheme.primary,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        icon: Icon(Icons.email),
                      ),
                      validator: (value) {
                        if (value == "") {
                          return "Email is required";
                        }
                      },
                    ),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        icon: Icon(Icons.lock),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _hideText = !_hideText;
                            });
                          },
                          child: Icon(_hideText
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
                      obscureText: _hideText,
                      validator: (value) {
                        if (value == "") {
                          return "Password is required";
                        }
                      },
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          ForgotPassword())));
                            },
                            child: Text('Forgot Password')),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => RegisterPage())));
                            },
                            child: Text('Register')),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_loginFormkey.currentState!.validate()) {
                          //POST request sending ata to login to the API
                          //login(emailController.text, passwordController.text);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => ProfilePage())));
                        }
                      },
                      child: Text('Login'),
                    )
                  ])),
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var userContoller = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var mobileNumberController = TextEditingController();

  bool _hideText = true;

  final GlobalKey<FormState> _registerFormkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('BronzedBlue',
                style: TextStyle(
                    fontWeight: FontWeight.bold, height: 2, fontSize: 50.0)),
            SizedBox(height: 20),
            Text("Please fill in all your details to register"),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                  key: _registerFormkey,
                  child: Column(children: [
                    TextFormField(
                      controller: userContoller,
                      decoration: InputDecoration(
                          hintText: 'Username', icon: Icon(Icons.person)),
                      validator: (value) {
                        if (value == "") {
                          return "Username is required";
                        }
                      },
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          hintText: 'Email', icon: Icon(Icons.mail)),
                      validator: (value) {
                        if (value == "") {
                          return "Email is required";
                        }
                      },
                    ),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        icon: Icon(Icons.lock),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _hideText = !_hideText;
                            });
                          },
                          child: Icon(_hideText
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                      ),
                      obscureText: _hideText,
                      validator: (value) {
                        if (value == "") {
                          return "Password is required";
                        }

                        if (value!.length < 8) {
                          return "Password must be 8 characters long";
                        }
                      },
                    ),
                    TextFormField(
                      controller: mobileNumberController,
                      decoration: InputDecoration(
                          hintText: 'Mobile Number', icon: Icon(Icons.phone)),
                      validator: (value) {
                        if (value == "") {
                          return "Mobile Number is required";
                        }
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_registerFormkey.currentState!.validate()) {
                          //POST request sending the data to the API
                          /* registerUser(
                              userContoller.text,
                              emailController.text,
                              passwordController.text,
                              mobileNumberController.text); */

                          Navigator.pop(context);
                        }
                      },
                      child: Text('Register'),
                    )
                  ])),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('BronzedBlue',
              style: TextStyle(
                  fontWeight: FontWeight.bold, height: 2, fontSize: 50.0)),
          SizedBox(height: 20),
          Text('Welcome to Bronzed Blue'),
          Placeholder(),
          Text('Username'),
          Text('Email'),
          Text('Mobile Number'),
        ]),
      ),
    );
  }
}

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();
  final GlobalKey<FormState> _forgotPasswordFormkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('BronzedBlue',
              style: TextStyle(
                  fontWeight: FontWeight.bold, height: 2, fontSize: 50.0)),
          SizedBox(height: 20),
          Text('Please enter your email to reset your password'),
          SizedBox(height: 20),
          Form(
            key: _forgotPasswordFormkey,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: TextFormField(
                controller: emailController,
                decoration:
                    InputDecoration(hintText: 'Email', icon: Icon(Icons.mail)),
                validator: (value) {
                  if (value == "") {
                    return "Email is required";
                  }
                },
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_forgotPasswordFormkey.currentState!.validate()) {
                Navigator.pop(context);
              }
            },
            child: Text('Reset'),
          )
        ]),
      ),
    );
  }
}
