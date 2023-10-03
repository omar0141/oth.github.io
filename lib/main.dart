// ignore_for_file: unused_import
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shakosh/new/Bloc/Categories/categories_bloc.dart';
import 'package:shakosh/new/Config/Colors/AppColors.dart';
import 'package:shakosh/new/Config/Services/InitialServices.dart';
import 'package:shakosh/new/Config/Themes/MyTheme.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';
import 'package:shakosh/new/Screens/OnBoarding/OnBoardingScreen.dart';
import 'package:shakosh/new/Config/Routes/routes.dart';
import 'package:shakosh/screens/home/home_screen.dart';
import 'package:shakosh/test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'helper/translation.dart';
import 'package:shakosh/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

// flutter pub run build_runner build --delete-conflicting-outputs

late SharedPreferences preferences;
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
double screenWidth = 0;
double screenHeight = 0;
AppColors colors(context) => Theme.of(context).extension<AppColors>()!;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  preferences = await SharedPreferences.getInstance();
  await Translations.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static void setAppState() {
    _MyAppState? state =
        navigatorKey.currentContext!.findAncestorStateOfType<_MyAppState>();
    // ignore: invalid_use_of_protected_member
    state!.setState(() {});
  }
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void didChangeMetrics() {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    if (MediaQuery.of(context).size.width > 750) MyApp.setAppState();
    super.didChangeMetrics();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await InitialServices().getDependancies();
    });

    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return MultiBlocProvider(
      providers: [
        BlocProvider<CategoriesBloc>(
          create: (BuildContext context) => CategoriesBloc(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        scrollBehavior: MyCustomScrollBehavior(),
        title: 'Bayt Aleadad',
        theme: myTheme(),
        locale: Translations.getLocale(),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: Translations.getLocales(),
        initialRoute: HomeScreen.routeName,
        routes: routes,
      ),
    );
  }
}
