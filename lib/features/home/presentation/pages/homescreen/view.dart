import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../config/routes.dart';
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

  //_callNumber() async {
  //  const number = '';
  //  bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  //}

  var connectivitySubscription;

  final List<String> imageUrls = [
    "https://static.edokan.co/meghnalife/1_1.png",
    "https://static.edokan.co/meghnalife/1_2.png",
    "https://static.edokan.co/meghnalife/1_3.png",
    "https://static.edokan.co/meghnalife/1_4.png",
  ];

  //@override
  //void initState() {
  //  super.initState();
  //}

  //Future<void> refreshData() async {
  //_isLoading = true;

  /*var data = await getDashboard(context);
    _cStores = data['countries'];
    _orders = data['orders'];

    _cartItems = await getCart(context);

    _acceptList = await getDisclaimerAccepts();

    _isLoading = false;
    setState(() {});*/
  //}

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
          }),
    );
  }

/* Actions */

/* Widgets */
  Widget _scaffold(AuthenticatedResponse? users) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: _drawer(users),

      appBar: AppBar(
        backgroundColor: Color(0XFF60ABE9),
        //title: Text(translate(context, "admin.menu.dashboard"))
        title: users != null
            ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(users.name),
        ])
            : const Text("Edex-365"),
        //actions: [_languageButton()],
      ),
      //appBar: AppBar(
      //  title: Text(translate(context, "homepage.myPolicies.appbar")),
      //  //actions: <Widget>[_actionSearch()],
      //),
      body: _scaffoldBody(users),
      //floatingActionButton: FloatingActionButton(
      //  backgroundColor: Color(0XFFF70405),
      //  onPressed: () {
      //    Navigator.of(context as BuildContext)
      //        .push(MaterialPageRoute(builder: (context) => AddPolicyScreen()));
      //  },
      //  child: const Icon(Icons.add),
      //),
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
                color: Colors.blue,
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
                ListTile(
                  title: const Text("Update App"),
                  onTap: () async {
                    var url =
                        "https://play.google.com/store/apps/details?id=com.meghnalife.app.fa";
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
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
    return Builder(builder: (BuildContext context) {
      return Container(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              PaymentCard(),
              RecentProblems(),
              QuestionHistory(),
            ],
          ));
    });
  }

  DateTime? currentBackPressTime;

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

  Widget _login() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(AppRoutes.signIn);
          },
          child: const Text(
            'Log in',
            textScaleFactor: 1.5,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _logout() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
        child: InkWell(
          onTap: () {
            BlocProvider.of<AuthenticationCubit>(context).signOut();
          },
          child: const Text(
            'Log Out',
            textScaleFactor: 1.5,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
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
      child: Image.asset('assets/images/menu_my_account.png',
          fit: BoxFit.fitHeight, height: 96),
    );
  }

  Widget _bottomNavigationBar() {
    return CurvedNavigationBar(
      index: 0,
      height: 50.0,
      items: <Widget>[
        Icon(Icons.home, size: 30),
        Icon(Icons.add, size: 30),
        Icon(Icons.message, size: 30),
      ],
      onTap: (index) {
        if (index == 0) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => HomeScreen()));
        } else if (index == 1) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => NewProblemCreate()));
        } else if (index == 2) {
          SnackBar(content: Text("Coming Soon"));
        }
      },
    );
  }

//Widget _profileImage(AuthenticatedResponse user) {
//  return BlocProvider(
//    create: (_) => sl<MyAccountCubit>(),
//    child: BlocConsumer<MyAccountCubit, MyAccountState>(
//        builder: (myAccountContext, state) {
//          if (state is MyAccountInitial) {
//            BlocProvider.of<MyAccountCubit>(myAccountContext)
//                .getSingle(user.agentId);
//          }

//          if (state is MyAccountLoaded != true) {
//            return const Center(child: CircularProgressIndicator());
//          }

//          if (state.personalInfo.photo == null) {
//            return _imagePlaceholder();
//          } else {
//            return ClipRRect(
//              borderRadius: BorderRadius.circular(8.0),
//              child: Image.network(
//                state.personalInfo.photo!,
//                fit: BoxFit.fitHeight,
//                height: 110.0,
//                // Adjust the size as needed
//              ),
//            );
//          }
//        },
//        listener: (myAccountContext, state) {}),
//  );
//}
}
