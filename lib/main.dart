import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/routes.dart';
import 'features/authentication/presentation/cubits/authentication_cubit.dart';
import 'features/authentication/presentation/pages/signIn/view.dart';

import 'features/home/presentation/pages/homescreen/view.dart';
import 'features/home/presentation/pages/splash/view.dart';
import 'injection_container.dart' as di;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(BlocProvider(
    create: (_) => di.sl<AuthenticationCubit>(),
    child:  MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'Edex-365',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.lightBlue[50],
          backgroundColor: Colors.blueAccent,
          fontFamily: 'Nikosh'),
      home: SplashScreen(),
      routes: _registerRoutes(),
    );
  }
}

Map<String, WidgetBuilder> _registerRoutes() {
  return <String, WidgetBuilder>{
    AppRoutes.home: (context) => HomeScreen(),
    AppRoutes.signIn: (context) => const SignInScreen(),
  };
}
