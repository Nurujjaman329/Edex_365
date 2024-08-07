import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../../../config/routes.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/widgets/payment_card.dart';
import '../../../../../../core/widgets/question_history.dart';
import '../../../../../../core/widgets/recent_problems_list.dart';
import '../../../../../authentication/domain/entities/authenticated_reponse.dart';
import '../../../../../authentication/presentation/cubits/authentication_cubit.dart';
import '../new_problem_create_page.dart';


class TeacherHomePage extends StatefulWidget {
  const TeacherHomePage({Key? key}) : super(key: key);

  @override
  TeacherHomePageState createState() => TeacherHomePageState();
}

class TeacherHomePageState extends State<TeacherHomePage> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

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

  DateTime? currentBackPressTime;
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

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
      // appBar: AppBar(
      //   backgroundColor: AppColors.primaryColor,
      //   title: users != null
      //       ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      //     Text(users.name),
      //   ])
      //       : const Text("Edex-365"),
      //   actions: [
      //     Padding(
      //       padding: EdgeInsets.only(right: 10.0),
      //       child: Icon(Icons.notifications),
      //     )
      //   ],
      // ),
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
          backgroundColor: AppColors.primaryColor,
          expandedHeight: 200.0,
          floating: false,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(user != null ? (user.name + '->' + user.type): "Edex-365",style: TextStyle(fontSize: 10),),
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
                    PaymentCard(),
                    RecentProblems(),
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
          fit: BoxFit.fitHeight, height: 96),
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
        Icon(Icons.message, color: Colors.white),
      ],
    );
  }
}




