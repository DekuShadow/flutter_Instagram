import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_instagram/providers/providers.dart';
import 'package:flutter_instagram/resources/bloc/auth_current_uid_bloc.dart';
import 'package:flutter_instagram/screens/profile_screen/bloc/app_bar/app_bar_bloc.dart';
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
            apiKey: "AIzaSyACzBLJgXpZkxVmOmnMCWacS9p9J80sUi8",
            appId: "1:850077482149:web:cdd4244b3f2b0f9c89a14c",
            messagingSenderId: "850077482149",
            projectId: "instagramflutter-d6428",
            storageBucket: "instagramflutter-d6428.appspot.com"));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authUid = BlocProvider<AuthCurrentUidBloc>(
        create: (context) => AuthCurrentUidBloc());
    final profile = BlocProvider(
      create: (context) => AppBarBloc(),
    );
    return MultiBlocProvider(
      providers: [authUid, profile],
      child: MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
        child: MaterialApp(
          routes: {
            '/home': (context) => responsiveLayout(
                WebScreenLayout: WebScreenLayout(),
                MobileScreenLayout: MobileScreenLayout()),
          },
          title: 'Instagram',
          theme: ThemeData.dark()
              .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
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
      ),
    );
  }
}
