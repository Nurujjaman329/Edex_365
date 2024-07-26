
//import 'package:fa/core/widgets/input_field.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/routes.dart';
import '../../../../../core/styles/primary_button.dart';
import '../../../../../core/styles/text_input_decoration.dart';
import '../../../../../core/utils/input_validator.dart';
import '../../../../../core/widgets/heading.dart';
import '../../../../../injection_container.dart';
import '../../cubits/authentication_cubit.dart';
import 'cubit/sign_in_cubit.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  SignInScreenState createState() {
    return SignInScreenState();
  }
}

class SignInScreenState extends State<SignInScreen> {
  SignInScreenState() : super();

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    userNameController.text = "nur@gmail.com"; //4000989
    passController.text = "123"; //4038

    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
        builder: (context, state) {
          return _scaffold();
        }, listener: (context, state) {
      if (state is Authenticated) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.home);
      }
    });
  }

  _scaffold() {
    return BlocProvider(
        create: (_) => sl<SignInCubit>(),
        child: Scaffold(
          appBar: null,
          body:
          BlocConsumer<SignInCubit, SignInState>(builder: (context, state) {
            if (state is SignInLoading || state is SignInSuccessful) {
              return const Center(child: CircularProgressIndicator());
            }
            return SafeArea(
                child: Center(
                    child: SingleChildScrollView(child: _page(context))));
          }, listener: (context, state) {
            if (state is SignInError) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
            if (state is SignInLoading) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Please wait")),
              );
            }
            if (state is SignInSuccessful) {
              BlocProvider.of<AuthenticationCubit>(context).setAuth(state.auth);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Logged in successfully"),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.of(context).pop();
            }
          }),
        ));

    /*return new Scaffold(
      appBar: null,
      body: BlocProvider(
        create: (_) => sl<SignInCubit>(),
        child: BlocConsumer(
          listener: (context, state) {
            if (state is SignInError) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            if( state is SignInLoading){
              return Center( child: Text('Loading..') );
            }
            return _page(context);
          },
        )
      )
      //backgroundColor: TuniBibiStyle.background,
    );*/
  }

  _page(context) {
    translate(key) {
      return key; //LanguageTranslation.of(context)!.value(key);
    }

    return Center(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 32, right: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                "assets/images/edex_logo.png",
                fit: BoxFit.fitHeight,
                height: 128,
              ),
              const SizedBox(height: 32),
              Heading(
                  text: translate('Login to your account'), key: UniqueKey()),
              const SizedBox(height: 32),
              TextFormField(
                  controller: userNameController,
                  decoration: textInputDecoration(
                      translate('User ID'), const Icon(Icons.person)),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) =>
                      InputValidator(value!, 'User ID').isEmpty().validate()),
              const SizedBox(height: 16),
              TextFormField(
                controller: passController,
                decoration: textInputDecoration(
                    translate("Password"), const Icon(Icons.vpn_key)),
                keyboardType: TextInputType.visiblePassword,
                validator: (value) =>
                    InputValidator(value!, 'Password').isEmpty().validate(),
                obscureText: true,
              ),
              const SizedBox(height: 64),
              ElevatedButton(
                style: primaryButton(),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    BlocProvider.of<SignInCubit>(context).postLogin(
                        userNameController.text, passController.text);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Please fill up required fields'),
                        backgroundColor: Colors.red));
                  }

                  //Navigator.of(context).pushReplacementNamed( appRoutes.home );
                  /*final signInCubit = context.bloc<SignInCubit>();
                        signInCubit.postLogin(phoneController,passController);*/
                },
                child: Text(translate('Login')),
              ),

              const SizedBox(height: 16),
              //TextButton(onPressed: (){}, child: Text(_translate('site.login.forgot'))),
              //_isLoading ? new CircularProgressIndicator() : primaryButton('          Login          ',(){

              //_submit();

              //}),
              /*SizedBox(height: 64),
                  Text("New user? Register for free."),
                  TextButton(
                    child: Text('Create New Account'),
                    onPressed: (){
                      Navigator.of(context).pushReplacementNamed( appRoutes.signup );
                    },
                  ),*/
              /*whiteButton("Register",(){

                      Navigator.of(context).pushNamed("/register").then((userCreated){

                        if(userCreated!=null && userCreated){

                          navigate();

                        }

                      });

                    })*/
            ],
          ),
        ),
      ),
    );
  }

  /*@override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          'Settings',
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            SettingsCardWidget(),
            SettingsCardWidget(),
            SettingsCardWidget(),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );

  }*/

  Widget _displayEmpty() {
    return const SliverToBoxAdapter(
      child: SizedBox(
        height: 500,
        child: Center(child: Text("Your cart is empty.")),
      ),
    );
  }

/*Widget _buildRow(int index) {
    Order item = _orders[index];print(item);

    return InkWell(
      child: new Container(
          padding: new EdgeInsets.only(top: 16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: new EdgeInsets.only(left:16.0,right: 16.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                              children: <Widget>[
                                Text(item.id.toUpperCase(), style: TuniBibiStyle.h1),
                                SizedBox(width: 16),
                                Text("("+item.status.toUpperCase()+")")
                              ]
                          ),
                          Text(item.cartItems.length.toString()+ " items")
                        ],
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Text( 'Tk. '+ item.amount.toStringAsFixed(2),style: TuniBibiStyle.h2  ),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 16),
              Divider(
                height: 1,
              )
            ],
          )
      ),
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return new OrderSingleScreen(orderId: item.id);
            }));
      },
    );


  }*/
}
