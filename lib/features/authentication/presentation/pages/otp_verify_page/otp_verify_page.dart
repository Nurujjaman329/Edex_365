import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpVerifyPage extends StatefulWidget {
  const OtpVerifyPage({super.key});

  @override
  State<OtpVerifyPage> createState() => _OtpVerifyPageState();
}

class _OtpVerifyPageState extends State<OtpVerifyPage> {
  String code = "";
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController codeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("OtpVerifyPage")),
      body: Center(
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: ListView(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    SizedBox(height: 10),
                    Text(
                      'Verify Phone Number',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .01,
                    ),
                    Text(
                      "Please enter the code sent to: ${_maskPhoneNumber(phoneController.text)}",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .04,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .03,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 8,
                        top: 8,
                        left: 20,
                        right: 20,
                      ),
                      child: PinFieldAutoFill(
                        textInputAction: TextInputAction.done,
                        decoration: BoxLooseDecoration(
                          strokeColorBuilder: PinListenColorBuilder(
                            Colors.black,
                            Colors.black26,
                          ),
                          bgColorBuilder: const FixedColorBuilder(
                            Colors.white,
                          ),
                          strokeWidth: 1.2,
                        ),
                        controller: codeController,
                        currentCode: code,
                        onCodeSubmitted: (code) {},
                        onCodeChanged: (code) {
                          if (code!.length == 6) {
                            FocusScope.of(context).requestFocus(FocusNode());
                          }
                        },
                        codeLength: 6,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .03,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .80,
                      height: MediaQuery.of(context).size.width * .12,
                      decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20.0)),

                      child: ElevatedButton(
                        onPressed: () {
                          // Handle OTP verification
                        },
                        child: Text('Otp'),
                      ),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String _maskPhoneNumber(String phoneNumber) {
    if (phoneNumber.length < 5) {
      return phoneNumber;
    }
    return phoneNumber.replaceRange(0, phoneNumber.length - 4, '*' * (phoneNumber.length - 4));
  }
}
