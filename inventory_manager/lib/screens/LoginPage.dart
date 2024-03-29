import 'package:LocManager/screens/SignUpPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:LocManager/screens/OtpPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  String mobile = "";

  Future<Map<dynamic, dynamic>> login() async {
    final data = {};
    data['canOtp'] = false;

    if (_formKey.currentState!.validate()) {
      // Add your login logic here

      final url = Uri.parse(
          'https://shamhadchoudhary.pythonanywhere.com/api/store/send-otp/');
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({"mobile": mobile});

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 202) {
        // request successful
        final data1 = jsonDecode(response.body);
        print(data1);

        final storage = FlutterSecureStorage();
        // Storing the token

        await storage.write(key: 'isAuthenticated', value: "true");
        data['otp_token'] = data1['otp_token'];
        data['otp'] = data1['otp'];
        data['mobile'] = mobile;
        data['canOtp'] = true;
        return data;
      } else {
        // request failed
        print("failed");
        print(response.reasonPhrase);
      }
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/login.jpg')),
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
                              mobile = value;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter the Mobile";
                            } else if (!RegExp(r'^-?[0-9]+$').hasMatch(value)) {
                              return "Enter a valid Mobile (only numbers allowed)";
                            } else if (value.length > 10) {
                              return "Input limit exceeded";
                            }
                            return null; // Return null if input is valid
                          },
                          decoration: InputDecoration(
                            filled: true,
                            prefixIcon: Icon(Icons.mobile_friendly),
                            hintText: "Enter your Mobile",
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                // Handle signup button press
                                // Navigate to your signup page or perform signup logic
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return SignupPage();
                                }));
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () async {
                                print("Logged In");
                                Future<Map<dynamic, dynamic>> dataFuture =
                                    login(); // Replace with your actual login function

                                // Wait for the future to complete and get the Map value
                                Map<dynamic, dynamic> data = await dataFuture;
                                print(data);
                                if (data['canOtp']) {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return OtpPage(
                                        mobile: data['mobile'],
                                        otpToken: data['otp_token']);
                                  }));
                                }
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
