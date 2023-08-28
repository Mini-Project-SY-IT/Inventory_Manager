import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  String name = "";
  String password = "";

  void login() {
    if (_formKey.currentState!.validate()) {
      print("Name: $name");
      print("Password: $password");
      // Add your login logic here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("asset/images/login.jpg")),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(left: 35, top: 180),
                child: Text(
                  "Welcome\nUser !",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 430, left: 30, right: 30),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          onChanged: (value) {
                            setState(() {
                              name = value;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            prefixIcon: Icon(Icons.abc),
                            hintText: "Enter your Name",
                            fillColor: Colors.grey.shade100,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            }
                            return null;
                          },
                          obscureText: true,
                          obscuringCharacter: "*",
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            filled: true,
                            prefixIcon: Icon(Icons.password),
                            hintText: "Enter Password",
                            fillColor: Colors.grey.shade100,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Sign In",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () {
                                print("Logged In");
                                login();
                              },
                              child: Text(
                                "Log In",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Forgot Password?",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w200,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey.shade500,
                          child: CircleAvatar(
                            backgroundColor: Colors.grey.shade300,
                            radius: 28,
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.arrow_forward_ios),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
