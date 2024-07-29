import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edex_3_6_5/features/authentication/domain/entities/sign_up_details.dart';
import 'package:edex_3_6_5/features/authentication/domain/entities/user_roles.dart';
import 'package:edex_3_6_5/features/authentication/domain/usecases/post_register.dart';
import 'package:edex_3_6_5/features/home/presentation/pages/homescreen/view.dart';

import '../../../../../core/custom_widget/custom_form.dart';
import '../../../../../core/utils/translate.dart';
import '../../../../../core/widgets/heading.dart';
import '../../../../../injection_container.dart';
import '../../../../../language-translation.dart';
import '../../cubits/authentication_cubit.dart';
import '../signIn/view.dart';
import '../userRole/cubit/user_role_cubit.dart';
import 'cubit/register_cubit.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController dobController = TextEditingController(); // DOB Controller

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _mobileNumberFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _dobFocus = FocusNode(); // DOB Focus Node

  List<DropdownMenuItem<String>> roles = [];
  String? _selectedRole;

  bool _passwordVisible = true;

  final _formKey = GlobalKey<FormState>();

  bool _hasFetchedRoles = false;

  @override
  void dispose() {
    userNameController.dispose();
    phoneController.dispose();
    emailNameController.dispose();
    passwordController.dispose();
    dobController.dispose(); // Dispose DOB Controller
    _nameFocus.dispose();
    _mobileNumberFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _dobFocus.dispose(); // Dispose DOB Focus Node
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<RegisterCubit>()),
        BlocProvider(create: (_) => sl<UserRoleCubit>()),
      ],
      child: BlocConsumer<AuthenticationCubit, AuthenticationState>(
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
      ),
    );
  }

  Widget _scaffold() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterError) {
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
          } else if (state is RegisterSuccessful) {
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
    );
  }

  Widget _page(BuildContext context) {
    if (!_hasFetchedRoles) {
      _hasFetchedRoles = true;
      BlocProvider.of<UserRoleCubit>(context).getList();
    }

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
                    "assets/images/edex_logo.png",
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
                    labelText: translate(context, "register.phone"),
                    hintText: translate(context, "register.phone.hinttext"),
                    prefixicon: const Icon(Icons.mobile_friendly),
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_emailFocus);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return translate(context, "register.phone.validation");
                      }
                    },
                  ),
                  const SizedBox(height: 5),

                  CustomFormField(
                    controller: emailNameController,
                    focusNode: _emailFocus,
                    labelText: translate(context, "register.email"),
                    hintText: translate(context, "register.email.hinttext"),
                    prefixicon: const Icon(Icons.email),
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_passwordFocus);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return translate(context, "register.email.validation");
                      }
                    },
                  ),
                  const SizedBox(height: 5),

                  // Date of Birth Field
                  GestureDetector(
                    onTap: () async {
                      DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (selectedDate != null && selectedDate != DateTime.now()) {
                        setState(() {
                          dobController.text = selectedDate.toLocal().toString().split(' ')[0]; // Update DOB controller
                        });
                      }
                    },
                    child: AbsorbPointer(
                      child: CustomFormField(
                        controller: dobController,
                        focusNode: _dobFocus,
                        labelText: translate(context, "register.dob"),
                        hintText: translate(context, "register.dob.hinttext"),
                        prefixicon: const Icon(Icons.calendar_today),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return translate(context, "register.dob.validation");
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),

                  BlocBuilder<UserRoleCubit, UserRoleState>(
                    builder: (context, state) {
                      if (state is UserRoleLoading) {
                        return const CircularProgressIndicator();
                      } else if (state is UserRoleLoaded) {
                        roles = state.userRoles
                            .map((role) => DropdownMenuItem(
                          value: role.id,
                          child: Text(role.rName),
                        ))
                            .toList();
                        return DropdownButtonFormField<String>(
                          items: roles,
                          value: _selectedRole,
                          hint: Text(translate(context, "register.select_role")),
                          onChanged: (value) {
                            setState(() {
                              _selectedRole = value;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return translate(context, "register.role.validation");
                            }
                          },
                        );
                      } else if (state is UserRoleError) {
                        return Text(translate(context, "register.role.error"));
                      }
                      return const SizedBox();
                    },
                  ),
                  const SizedBox(height: 5),

                  CustomFormField(
                    controller: passwordController,
                    focusNode: _passwordFocus,
                    labelText: translate(context, "register.password"),
                    hintText: translate(context, "register.password.hinttext"),
                    obscureText: _passwordVisible,
                    prefixicon: const Icon(Icons.lock),
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return translate(context, "register.password.validation");
                      }
                    },
                  ),
                  const SizedBox(height: 25),
                  Container(
                    width: MediaQuery.of(context).size.width * .81,
                    height: MediaQuery.of(context).size.width * .12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Create SignUpDetails object
                          final signUpDetails = SignUpDetails(
                            name: userNameController.text,
                            mobileNo: phoneController.text,
                            status: true, // or your appropriate status
                            email: emailNameController.text,
                            password: passwordController.text,
                            dob: dobController.text.isNotEmpty
                                ? DateTime.parse(dobController.text) // Parse the DOB from text
                                : null,
                            school: userNameController.text, // Update as needed
                            sClass: userNameController.text, // Update as needed
                            role: _selectedRole != null ? [_selectedRole!] : [],
                          );

                          // Call postRegister with the SignUpDetails object
                          BlocProvider.of<RegisterCubit>(context).postRegister(signUpDetails);
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
