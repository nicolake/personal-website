import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return AlertDialog(
            title: Text('Error initializing app.'),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MainApp();
        }

        return CircularProgressIndicator();
      },
    );
  }
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nicolas Chichi',
      color: Colors.amberAccent,
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context)!.homePageTitle,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainSection(),
    );
  }
}

class MainSection extends StatelessWidget {
  const MainSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Text(AppLocalizations.of(context)!.helloWorld),
      ),
    );
  }
}
