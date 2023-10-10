import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shakosh/new/Bloc/Dependancies/dependancies_bloc.dart';
import 'package:shakosh/new/Bloc/Favourite/favourite_bloc.dart';
import 'package:shakosh/new/Bloc/Products/products_bloc.dart';
import 'package:shakosh/new/Bloc/Cart/cart_bloc.dart';
import 'package:shakosh/new/Config/Colors/AppColors.dart';
import 'package:shakosh/new/Config/Services/InitialServices.dart';
import 'package:shakosh/new/Config/Themes/MyTheme.dart';
import 'package:shakosh/new/Config/Translations/Translation.dart';
import 'package:shakosh/new/Data/Remote/MyApi.dart';
import 'package:shakosh/new/Screens/Home/HomeScreen.dart';
import 'package:shakosh/new/Config/Routes/routes.dart';
import 'package:shakosh/new/Screens/Login/LoginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
late Timer timer;
late int newDate;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  preferences = await SharedPreferences.getInstance();
  await Translations.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  HttpOverrides.global = MyHttpOverrides();
  MyApi.UID = preferences.getString("id") ?? "";
  MyApi.username = preferences.getString("username") ?? "";
  String? date = preferences.getString("date");
  newDate = DateTime.now()
      .difference(DateTime.parse(date ?? "2023-09-18 21:59"))
      .inMinutes;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  static final RouteObserver<PageRoute> routeObserver =
      RouteObserver<PageRoute>();

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
    if (screenWidth > 750) MyApp.setAppState();
    super.didChangeMetrics();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await InitialServices().getDependancies();
    });

    WidgetsBinding.instance.addObserver(this);
    super.initState();
    Flurorouter.setupRouter();
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
    return Directionality(
      textDirection:
          "language_iso".tr == "ar" ? TextDirection.rtl : TextDirection.ltr,
      child: MaterialApp(
        navigatorObservers: [MyApp.routeObserver],
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        scrollBehavior: MyCustomScrollBehavior(),
        title: 'bayt-aleadad'.tr,
        theme: myTheme(),
        builder: (context, child) {
          return Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider<CartBloc>(
                        create: (BuildContext context) => CartBloc()),
                    BlocProvider<DependanciesBloc>(
                        create: (BuildContext context) => DependanciesBloc()),
                    BlocProvider<ProductsBloc>(
                        create: (BuildContext context) => ProductsBloc()),
                    BlocProvider<FavouriteBloc>(
                        create: (BuildContext context) => FavouriteBloc()),
                  ],
                  child: child!,
                ),
              ),
            ],
          );
        },
        locale: Translations.getLocale(),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: Translations.getLocales(),
        initialRoute: LoginScreen.routeName,
        onGenerateRoute: Flurorouter.router.generator,
      ),
    );
  }
}
