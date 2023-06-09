import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:isabel/routes.dart';
import 'api/firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        SfGlobalLocalizations.delegate
      ],
      supportedLocales: [Locale('pt', 'BR')],
      locale: Locale('pt', 'BR'),
      debugShowCheckedModeBanner: false,
      title: 'Isabel',
      initialRoute: "/",
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
