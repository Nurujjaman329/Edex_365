import 'dart:async';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../../config/routes.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/widgets/payment_card.dart';
import '../../../../../core/widgets/question_history.dart';
import '../../../../../core/widgets/recent_problems_list.dart';
import '../../../../authentication/domain/entities/authenticated_reponse.dart';
import '../../../../authentication/presentation/cubits/authentication_cubit.dart';
import 'new_problem_create_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  bool _showBalance = false;
  String _balance = "1000.00"; // Replace with actual balance fetching logic
  DateTime? currentBackPressTime;
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  void _onBalanceClick() {
    setState(() {
      _showBalance = true;
    });

    Timer(Duration(seconds: 3), () {
      setState(() {
        _showBalance = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
        builder: (context, authState) {
          AuthenticatedResponse user;
          if (authState is Authenticated) {
            user = authState.auth;
            return _scaffold(user);
          } else {
            return _scaffold(null);
          }
        },
      ),
    );
  }

  Widget _scaffold(AuthenticatedResponse? users) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: _drawer(users),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          _scaffoldBody(users),
          NewProblemCreate(),
          Center(child: Text("Messages - Coming Soon")),
        ],
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _drawer(AuthenticatedResponse? users) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: DrawerHeader(
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
              ),
              child: Container(
                width: double.infinity,
                child: Column(
                  children: [
                    users == null ? _imagePlaceholder() : SizedBox(),
                    const SizedBox(height: 16),
                    users == null
                        ? Text("Not Logged in",
                        textScaleFactor: .8,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 19))
                        : Text(''),
                    users == null ? const SizedBox() : Text(''),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                ListTile(
                  title: const Text("Contact HO"),
                  onTap: () {
                    //FlutterPhoneDirectCaller.callNumber("09613-440 440");
                  },
                ),
                users != null
                    ? ListTile(
                  title: const Text("Log Out"),
                  onTap: () {
                    BlocProvider.of<AuthenticationCubit>(context)
                        .signOut();
                  },
                )
                    : ListTile(
                  title: const Text("Log In"),
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutes.signIn);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _scaffoldBody(AuthenticatedResponse? user) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.notifications),
            ),
          ],
          backgroundColor: AppColors.primaryColor,
          expandedHeight: 200.0,
          floating: false,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title:  user!=null ? Row(
              children: [
                _imagePlaceholder(),
                Padding(
                  padding:  EdgeInsets.only(left: 10.0),
                  child: _balanceSlider(),
                ),
              ],
            ) : SizedBox(),
            background: Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.all(50.0),
                    child: Image.asset(
                      'assets/images/edex_logo_new.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    // _balanceSlider(),
                    PaymentCard(),
                    RecentProblems(),
                    QuestionHistory(),
                    PaymentCard(),

                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _balanceSlider() {
    return GestureDetector(
      onTap: _onBalanceClick,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: _showBalance ? MediaQuery.of(context).size.height *.15 : MediaQuery.of(context).size.height *.13,
        height: MediaQuery.of(context).size.height *.025,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Text(
            _showBalance ? "Balance: $_balance" : "Check Your Balance",
            style: TextStyle(color: Colors.black,fontSize: 10.0),
          ),
        ),
      ),
    );
  }

  Future<bool> onWillPop() async {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: "Press back again to exit",
        toastLength: Toast.LENGTH_SHORT,
      );
      return Future.value(false);
    }
    return Future.value(true);
  }

  Widget _imagePlaceholder() {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(
          Radius.circular(8.0),
        ),
      ),
      child: Image.asset('assets/images/edex_logo.png',
          fit: BoxFit.fitHeight, height: 15),
    );
  }

  Widget _bottomNavigationBar() {
    return CurvedNavigationBar(
      index: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
        _pageController.jumpToPage(index);
      },
      backgroundColor: Colors.white,
      color: AppColors.primaryColor,
      buttonBackgroundColor: AppColors.primaryColor,
      items: const [
        Icon(Icons.home, color: Colors.white),
        Icon(Icons.add, color: Colors.white),
        Icon(CupertinoIcons.profile_circled, color: Colors.white),
      ],
    );
  }
}
