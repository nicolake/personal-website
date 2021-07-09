import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_website/profile_link_icons_icons.dart';
import 'package:url_launcher/url_launcher.dart';

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
  final String linkedinUrl =
      'https://www.linkedin.com/in/nicolas-chichi-18601135/';
  final String githubUrl = 'https://github.com/nicolake';
  final String stackoverflowUrl =
      'https://stackoverflow.com/users/6253192/nico';
  final String codepenUrl = 'https://codepen.io/nicolake/';
  @override
  Widget build(BuildContext context) {
    var smallSize = MediaQuery.of(context).size.width < 705;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.blue[600]!,
                  Colors.deepOrange.shade200,
                ],
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                _header(
                  smallSize,
                  AppLocalizations.of(context)!.name,
                  AppLocalizations.of(context)!.position,
                ),
                Expanded(
                  child: SizedBox(),
                ),
                Card(
                  color: Colors.transparent,
                  margin: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 20.0,
                      ),
                      IconButton(
                        tooltip: AppLocalizations.of(context)!.linkedinTooltip,
                        onPressed: () async {
                          if (await canLaunch(linkedinUrl)) {
                            await launch(
                              linkedinUrl,
                              forceSafariVC: true,
                              forceWebView: true,
                              webOnlyWindowName: '_blank',
                            );
                          } else {
                            throw 'Could not launch $linkedinUrl';
                          }
                        },
                        icon: const Icon(
                          ProfileLinkIcons.linkedin,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        tooltip: AppLocalizations.of(context)!.githubTooltip,
                        onPressed: () async {
                          if (await canLaunch(githubUrl)) {
                            await launch(
                              githubUrl,
                              forceSafariVC: true,
                              forceWebView: true,
                              webOnlyWindowName: '_blank',
                            );
                          } else {
                            throw 'Could not launch $githubUrl';
                          }
                        },
                        icon: const Icon(
                          ProfileLinkIcons.github,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        tooltip: AppLocalizations.of(context)!.codepenTooltip,
                        onPressed: () async {
                          if (await canLaunch(codepenUrl)) {
                            await launch(
                              codepenUrl,
                              forceSafariVC: true,
                              forceWebView: true,
                              webOnlyWindowName: '_blank',
                            );
                          } else {
                            throw 'Could not launch $codepenUrl';
                          }
                        },
                        icon: const Icon(
                          ProfileLinkIcons.codepen,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        tooltip:
                            AppLocalizations.of(context)!.stackoverflowTooltip,
                        onPressed: () async {
                          if (await canLaunch(stackoverflowUrl)) {
                            await launch(
                              stackoverflowUrl,
                              forceSafariVC: true,
                              forceWebView: true,
                              webOnlyWindowName: '_blank',
                            );
                          } else {
                            throw 'Could not launch $stackoverflowUrl';
                          }
                        },
                        icon: const Icon(
                          ProfileLinkIcons.stackoverflow,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                    ],
                  ),
                )
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
      child: AvatarGlow(
        glowColor: Colors.yellow,
        endRadius: isSmallSize ? 70.0 : 120.0,
        duration: Duration(milliseconds: 2000),
        repeat: false,
        showTwoGlows: true,
        child: Material(
          elevation: 8.0,
          shape: CircleBorder(),
          child: CircleAvatar(
            radius: isSmallSize ? 50.0 : 80.0,
            backgroundImage: AssetImage('assets/nico.jpg'),
          ),
        ),
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
