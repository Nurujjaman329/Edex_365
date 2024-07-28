
import 'package:edex_3_6_5/features/home/presentation/pages/homescreen/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/custom_widget/custom_form.dart';
import '../../../../../core/utils/translate.dart';
import '../../../../../core/widgets/heading.dart';
import '../../../../../injection_container.dart';
import '../../../../../language-translation.dart';
import '../../cubits/authentication_cubit.dart';
import '../signIn/view.dart';
import 'cubit/register_cubit.dart';



class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _mobileNumberFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  bool _passwordVisible = true;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    userNameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    _nameFocus.dispose();
    _mobileNumberFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is Authenticated) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        }
      },
      builder: (context, state) {
        return _scaffold();
      },
    );
  }

  _scaffold() {
    return BlocProvider(
      create: (_) => sl<RegisterCubit>(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: null,
        body: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is ResgisterError) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is RegisterLoading) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(translate(context, "loginpage.login_wait")),
                ),
              );
            } else if (state is ResgisterSuccessful) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is RegisterLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return SafeArea(
              child: SingleChildScrollView(
                child: _page(context),
              ),
            );
          },
        ),
      ),
    );
  }

  _page(BuildContext context) {
    _translate(String key) {
      return LanguageTranslation.of(context)?.value(key) ?? key;
    }

    return SizedBox(
      height: MediaQuery.of(context).size.height * .85,
      child: ListView(
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(top: 50, left: 32, right: 32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    "assets/images/logo.png",
                    fit: BoxFit.fitHeight,
                    height: 128,
                  ),
                  const SizedBox(height: 32),
                  Heading(
                    text: _translate('register.registermessage'),
                    key: UniqueKey(),
                  ),
                  const SizedBox(height: 32),
                  CustomFormField(
                    controller: userNameController,
                    focusNode: _nameFocus,
                    labelText: translate(context, "register.name"),
                    hintText: translate(context, "register.name.hinttext"),
                    prefixicon: const Icon(Icons.person),
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_mobileNumberFocus);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return translate(context, "register.name.validation");
                      }
                    },
                  ),
                  const SizedBox(height: 5),
                  CustomFormField(
                    controller: phoneController,
                    focusNode: _mobileNumberFocus,
                    keyBoardType: TextInputType.phone,
                    labelText: translate(context, "register.phone"),
                    hintText: translate(context, "register.phone.hinttext"),
                    prefixicon: const Icon(Icons.person),
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_passwordFocus);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return translate(context, "register.phone.validation");
                      }
                    },
                  ),
                  const SizedBox(height: 5),
                  CustomFormField(
                    controller: passwordController,
                    focusNode: _passwordFocus,
                    labelText: translate(context, "register.password"),
                    hintText: translate(context, "register.password.hinttext"),
                    obscureText: _passwordVisible,
                    prefixicon: const Icon(Icons.person),
                    suffixIconButton: IconButton(
                        icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        }
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return translate(
                            context, "loginpage.password.validation");
                      }
                    },
                  ),
                  const SizedBox(height: 25),
                  Container(
                    width: MediaQuery.of(context).size.width * .81,
                    height: MediaQuery.of(context).size.width * .12,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0)
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<RegisterCubit>(context).postRegister(
                            userNameController.text,
                            phoneController.text,
                            passwordController.text,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                translate(context, "common.fill_up_required_fields"),
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      child: Text(translate(context, "common.register")),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(translate(context, "common.register.message1")),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SignInScreen(),
                            ),
                          );
                        },
                        child: Text(translate(context, "common.login")),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

