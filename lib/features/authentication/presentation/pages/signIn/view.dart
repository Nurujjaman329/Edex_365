
//import 'package:fa/core/widgets/input_field.dart';

import 'dart:developer';

import 'package:edex_3_6_5/core/utils/app_colors.dart';
import 'package:edex_3_6_5/features/authentication/presentation/pages/otp_verify_page/otp_verify_page.dart';
import 'package:edex_3_6_5/features/authentication/presentation/pages/register/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/routes.dart';
import '../../../../../core/custom_widget/custom_form.dart';
import '../../../../../core/styles/primary_button.dart';
import '../../../../../core/styles/text_input_decoration.dart';
import '../../../../../core/utils/input_validator.dart';
import '../../../../../core/widgets/heading.dart';
import '../../../../../injection_container.dart';
import '../../../../home/presentation/pages/homescreen/teacher_home_screen/teacher_home_page.dart';
import '../../../domain/entities/sign_up_details.dart';
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

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final  SignUpDetails signUpDetails = SignUpDetails.empty();


  bool _passwordVisible = true;





  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    emailController.text = "nur@gmail.com"; //4000989
    passController.text = "123"; //4038

    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
        builder: (context, state) {
          return _scaffold();
        }, listener: (context, state) {
      if (state is Authenticated) {


        log(state.auth.type);
      state.auth.type == 'Student' ?
        Navigator.of(context).pushReplacementNamed(AppRoutes.home): Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TeacherHomePage()));

      }
    });
  }

  _scaffold() {
    return BlocProvider(
        create: (_) => sl<SignInCubit>(),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(backgroundColor: AppColors.primaryColor,title: Text('Login Screen'),),
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
                  backgroundColor: AppColors.secondaryColor,
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


              CustomFormField(
                controller: emailController,

                labelText: 'Email',
                hintText: 'Enter Your Email',
                prefixicon: const Icon(Icons.email,color: AppColors.primaryColor,),

                  validator: (value) =>
                      InputValidator(value!, 'User ID').isEmpty().validate()
              ),


              const SizedBox(height: 16),



              CustomFormField(
                  controller: passController,

                  labelText: 'Password',
                  hintText: 'Enter Your Password',
                  prefixicon: const Icon(Icons.lock,color: AppColors.primaryColor,),
                  obscureText: _passwordVisible,
                  suffixIconButton: IconButton(
                    icon: Icon(
                      _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),

                  validator: (value) =>
                      InputValidator(value!, 'Password').isEmpty().validate()
              ),
              // TextFormField(
              //     controller: userNameController,
              //     decoration: textInputDecoration(
              //         translate('User ID'), const Icon(Icons.person,color:  AppColors.primaryColor,)),
              //     keyboardType: TextInputType.emailAddress,
              //     validator: (value) =>
              //         InputValidator(value!, 'User ID').isEmpty().validate()),







              // TextFormField(
              //   controller: passController,
              //   decoration: textInputDecoration(
              //       translate("Password"), const Icon(Icons.vpn_key,color:  AppColors.primaryColor,)),
              //   keyboardType: TextInputType.visiblePassword,
              //   validator: (value) =>
              //       InputValidator(value!, 'Password').isEmpty().validate(),
              //   obscureText: true,
              // ),
              const SizedBox(height: 20),


              Container(
                width: MediaQuery.of(context).size.width * .81,
                height: MediaQuery.of(context).size.width * .12,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: InkWell(

                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      BlocProvider.of<SignInCubit>(context).postLogin(
                          emailController.text, passController.text);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please fill up required fields'),
                          backgroundColor: Colors.red));
                    }
                  },
                  child: Center(child: Text('LogIn',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,letterSpacing:1 ),)),
                ),
              ),


              const SizedBox(height: 16),
              
              
              InkWell(onTap: (){Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RegisterScreen()),
              );
                }, child: Row(
                children: [
                  Text('Need an Account ? '),
                  Text("Create New Account",style: TextStyle(color: AppColors.primaryColor,fontWeight: FontWeight.w500),),
                
                ],
              ),
              ),
              InkWell(onTap: (){Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OtpVerifyPage()),
              );
                },
                child: Text('Otp'),
              ),
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
