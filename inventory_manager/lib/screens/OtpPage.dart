import 'package:LocManager/screens/Myapp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OtpPage extends StatefulWidget {
  final String otpToken;
  final String mobile;

  const OtpPage({Key? key, required this.otpToken, required this.mobile})
      : super(key: key);

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final _formKey = GlobalKey<FormState>();

  String otp = "";
  bool verified = false;

  Future<bool> login() async {
    final storage = FlutterSecureStorage();
    // Storing the token

    if (_formKey.currentState!.validate()) {
      // Add your login logic here

      final url = Uri.parse(
          'https://shamhadchoudhary.pythonanywhere.com/api/store/verify-otp/');
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode(
          {"mobile": widget.mobile, "otp": otp, "otp_token": widget.otpToken});

      final response = await http.post(url, headers: headers, body: body);
      print(body);
      if (response.statusCode == 200) {
        // request successful
        final data = jsonDecode(response.body);
        print(data);

        final storage = FlutterSecureStorage();
        // Storing the token
        await storage.write(key: 'access_token', value: data['access_token']);
        setState(() {
          verified = true;
        });
        return true;
      } else {
        // request failed
        print("failed");
        print(response.reasonPhrase);
        return false;
      }
    }
    return false;
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
                            // Handle OTP input
                            setState(() {
                              otp = value;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter the OTP";
                            } else if (!RegExp(r'^[0-9]{4}$').hasMatch(value)) {
                              return "Enter a valid 4-digit OTP";
                            }
                            return null; // Return null if input is valid
                          },
                          keyboardType: TextInputType.number,
                          maxLength: 4,
                          decoration: InputDecoration(
                            filled: true,
                            prefixIcon: Icon(Icons.lock),
                            hintText: "Enter your OTP",
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
                            Text(
                              "Sign In",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () async {
                                print("Logged In");
                                await login();

                                if (verified) {
                                  print("verified or not $verified");
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return Myapp();
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
