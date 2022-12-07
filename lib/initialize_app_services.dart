import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';

final initializeAppServicesProvider = Provider<InitializeAppServices>((ref) {
  return InitializeAppServices(ref);
});

class InitializeAppServices{
  final Ref ref;
  InitializeAppServices(this.ref);

  Future<void> init() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  }
}