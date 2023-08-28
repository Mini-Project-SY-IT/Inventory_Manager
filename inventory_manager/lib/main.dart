import 'package:LocManager/screens/Myapp.dart';
import 'package:LocManager/screens/LoginPage.dart';
import 'package:LocManager/screens/models/notes_model.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

const String SETTINGS_BOX = 'settings';
const String API_BOX = "api_data";

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(SETTINGS_BOX);
  await Hive.openBox(API_BOX);
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(NotesModelAdapter());
  await Hive.openBox<NotesModel>('notes');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      home: FutureBuilder(
        // Simulate checking authentication status (replace with actual logic)
        future: Future.delayed(Duration(seconds: 3)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show splash screen widget
            return Splash();
          } else {
            return FutureBuilder<bool?>(
              future: checkLogin(),
              builder: (context, authSnapshot) {
                if (authSnapshot.connectionState == ConnectionState.waiting) {
                  // Still waiting for authentication status
                  return Splash();
                } else {
                  final isAuth = authSnapshot.data;
                  // Navigate to main screen or login screen based on authentication
                  if (isAuth == true) {
                    return Myapp();
                  } else {
                    return LoginPage();
                  }
                }
              },
            );
          }
        },
      ),
    );
  }
}

Future<bool> checkLogin() async {
  final storage = FlutterSecureStorage();

  String? token = await storage.read(key: 'access_token');

  final url = Uri.parse(
      'https://shamhadchoudhary.pythonanywhere.com/api/store/validate-access-token/');
  final headers = {'Content-Type': 'application/json'};
  final body = jsonEncode({"token": token});

  final response = await http.post(url, headers: headers, body: body);
  if (response.statusCode == 200) {
    // Token is valid
    final data = jsonDecode(response.body);
    return data['valid'];
  } else {
    // Token is invalid or expired
    return false;
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Inventory app',
        home: AnimatedSplashScreen(
          backgroundColor: Color(0xffe0e0e0),
          splashIconSize: double.infinity,
          nextScreen: Myapp(),
          splash: Container(
            height: double.infinity,
            width: double.infinity,
            child: Image(
              fit: BoxFit.contain,
              image: AssetImage('assets/images/splashy.gif'),
            ),
          ),
        ));
  }
}

class NotesModelAdapter extends TypeAdapter<NotesModel> {
  @override
  final int typeId = 0;

  @override
  NotesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotesModel(
      title: fields[0] as String,
      description: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NotesModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
