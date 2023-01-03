import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meeja/screens/authentication/signup_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../../core/constants/colors.dart';
import '../../core/enums/view_state.dart';
import '../widget/custom_button.dart';
import '../widget/custom_textfield.dart';
import 'auth_provider.dart';
import '../../core/extensions/string_ext.dart';

class LogIn extends StatelessWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthenticationProvider(),
      child: Consumer<AuthenticationProvider>(builder: (context, model, child) {
        return (Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Color(0xffFEF6F5),
            title: Center(
              child: Text(
                'Login',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ),
          body: ModalProgressHUD(
            progressIndicator: CircularProgressIndicator(
              color: orangeColor,
            ),
            inAsyncCall: model.state == ViewState.busy,
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: SingleChildScrollView(
                child: Form(
                  key: model.formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SvgPicture.asset(
                          "assets/logo1.svg",
                          color: orangeColor,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SvgPicture.asset("assets/logo2.svg"),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              customTextField(
                                textInputAction: TextInputAction.next,
                                onChanged: (value) {
                                  model.appUser.userEmail = value;
                                },
                                hinttext: "Enter your Email",
                                text: 'Email',
                                autoValidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (email) {
                                  //This validation will be used in actual application to
                                  //define and imply password strength
                                  if (!email!.isValidEmail)
                                    return "Enter a valid email";
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              customTextField(
                                textInputAction: TextInputAction.next,
                                onChanged: (value) {
                                  model.appUser.password = value;
                                },
                                hinttext: "Enter Pasword",
                                text: 'Password',
                                validator: (password) {
                                  if (password == null || password.isEmpty)
                                    return "Enter a valid password";
                                  //This validation will be used in actual application to
                                  //define and imply password strength
                                  // if (!password!.isValidPassword)
                                  //   return "Enter a valid password";
                                },
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    activeColor: orangeColor,
                                    value: model.isValue,
                                    onChanged: (value) {
                                      model.isChecked = value ?? true;
                                    },
                                  ),
                                  Text(
                                    'Remember me',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 60),
                                    child: Text(
                                      'Lost your Password?',
                                      style: TextStyle(
                                        color: orangeColor,
                                      ),
                                      // textAlign: TextAlign.right,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                      CustomButton(
                        title: "LogIn",
                        onTap: () {
                          model.loginUser(context);
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      RichText(
                        text: TextSpan(
                            text: "Don't Have An Account?",
                            style: TextStyle(color: Colors.black54),
                            children: <TextSpan>[
                              TextSpan(
                                text: " Sign Up",
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignUp(),
                                      ),
                                    );
                                  },
                                style: TextStyle(
                                  color: orangeColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ]),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
      }),
    );
  }
}
