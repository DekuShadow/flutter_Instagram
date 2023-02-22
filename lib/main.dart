import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram/providers/providers.dart';
import 'package:flutter_instagram/screens/screens.dart';
import 'package:provider/provider.dart';
// import 'firebase_options.dart';
import 'responsives/responsives.dart';
import 'utils/utills.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCs83mhL79_p7_JxALu5Hg32Megi6j-vI8",
            appId: "G-YJKXHMN4TD",
            messagingSenderId: "238279455040",
            projectId: "instagram-c3754",
            storageBucket: "instagram-c3754.appspot.com"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
      child: MaterialApp(
        title: 'Instagram',
        theme: ThemeData.dark()
            .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
        // home: const responsiveLayout(
        //     WebScreenLayout: WebScreenLayout(),
        //     MobileScreenLayout: MobileScreenLayout()),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const responsiveLayout(
                    WebScreenLayout: WebScreenLayout(),
                    MobileScreenLayout: MobileScreenLayout());
              } else if (snapshot.hasError) {
                return Container(
                  child: Text(snapshot.hasError.toString()),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
