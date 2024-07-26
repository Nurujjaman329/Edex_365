//import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/routes.dart';
import '../../../../authentication/presentation/cubits/authentication_cubit.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    loadUser().then((user) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.home);
    });
  }

  Future<String> loadUser() async {
    /*User user = await getUser();
    if(user==null) user = await postDeviceToken(context);
    return user;*/
    return new Future.delayed(const Duration(seconds: 5), () => "1");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: BlocConsumer<AuthenticationCubit, AuthenticationState>(
          builder: (context, state) {
            BlocProvider.of<AuthenticationCubit>(context).getAuth();
            return _splashScreen();
          }, listener: (context, state) {
        if (state is Authenticated) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.home);
        }
      }),
      backgroundColor: Colors.white,
    );
  }

  Widget _splashScreen() {
    return Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "assets/images/edex_logo.png",
                      fit: BoxFit.fitHeight,
                      height: 128,
                    ),
                    const SizedBox(height: 32),
                    const Text("Please wait..")
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
