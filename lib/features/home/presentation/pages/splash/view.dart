import 'package:edex_3_6_5/features/authentication/domain/entities/sign_up_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/routes.dart';
import '../../../../authentication/presentation/cubits/authentication_cubit.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late SignUpDetails signUpDetails;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _rotationAnimation = Tween<double>(begin: -0.1, end: 0.1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    loadUser().then((user) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.home);
    });
  }

  Future<String> loadUser() async {
    return Future.delayed(const Duration(seconds: 5), () => "1");
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        builder: (context, state) {
          BlocProvider.of<AuthenticationCubit>(context).getAuth();
          return _splashScreen();
        },
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.of(context).pushReplacementNamed(AppRoutes.home);
          }
        },
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _splashScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AnimatedBuilder(
            animation: _controller,
            child: Image.asset(
              "assets/images/edex_logo.png",
              fit: BoxFit.fitHeight,
              height: 128,
            ),
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Transform.rotate(
                  angle: _rotationAnimation.value,
                  child: child,
                ),
              );
            },
          ),
          const SizedBox(height: 32),
          const Text("Please wait.."),
          const SizedBox(height: 32),

        ],
      ),
    );
  }
}
