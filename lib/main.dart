import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_website/background/background.dart';

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
      color: Colors.blue[700],
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context)!.homePageTitle,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      localeResolutionCallback: (locale, supportedLocales) {
        if (locale == null) return supportedLocales.first;

        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode) {
            return supportedLocale;
          }
        }

        return supportedLocales.first;
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        secondaryHeaderColor: Colors.blue[700],
      ),
      home: MainSection(),
    );
  }
}

class MainSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var smallSize = MediaQuery.of(context).size.width < 705;
    return Scaffold(
      body: Stack(
        children: [
          Background(),
          Center(
            child: Column(
              children: [
                _header(
                  smallSize,
                  AppLocalizations.of(context)!.name,
                  AppLocalizations.of(context)!.position,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget _titleText(String text, bool isSmallSize) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Text(
      text,
      style: GoogleFonts.firaMono(
        fontSize: isSmallSize ? 24 : 36,
        fontWeight: FontWeight.w600,
        fontStyle: FontStyle.normal,
        color: Colors.white,
      ),
    ),
  );
}

Widget _mainTitleBlock(String title, String position, bool isSmallSize) {
  return Column(
    children: [
      _titleText(title, isSmallSize),
      SizedBox(height: 5),
      _titleText(position, isSmallSize),
    ],
  );
}

Widget _header(bool isSmallSize, String name, String position) {
  List<Widget> widgets = [
    Padding(
      padding: const EdgeInsets.all(5.0),
      child: CircleAvatar(
        radius: isSmallSize ? 50.0 : 80.0,
        backgroundImage: AssetImage('assets/nico.jpg'),
      ),
    ),
    SizedBox(
      width: 10.0,
    ),
    _mainTitleBlock(
      name,
      position,
      isSmallSize,
    ),
  ];
  return Container(
    margin: EdgeInsets.all(20),
    padding: EdgeInsets.all(5),
    child: Card(
      color: Colors.transparent,
      child: isSmallSize
          ? Column(
              children: widgets,
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widgets,
            ),
    ),
  );
}
