import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  // Ideal time to initialize
  await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  //...
}
