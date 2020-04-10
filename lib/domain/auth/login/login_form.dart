import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteme/domain/auth/login/states/login_state.dart';
import 'package:noteme/domain/auth/signup/signup_view.dart';
import 'package:noteme/framework/navigation/navigrator.dart';
import 'package:noteme/generated/locale_base.dart';
import 'package:noteme/theme/widgets/form/text_input_form_control.dart';
import 'package:noteme/theme/widgets/form/validators/required_validator.dart';
import 'package:noteme/theme/widgets/text_button.dart';

import 'events/login_event.dart';
import 'login_bloc.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _key = new GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      _key.currentState.save();

      if (!_key.currentState.validate()) {
        return;
      }

      BlocProvider.of<LoginBloc>(context).add(
        LoginButtonPressed(
          email: _usernameController.text,
          password: _passwordController.text,
        ),
      );
    }

    final locale = Localizations.of<LocaleBase>(context, LocaleBase);

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Form(
            child: Column(
              children: [
                TextNoteMeInputFormControl(
                  controller: _usernameController,
                  placeholder: locale.global.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (String value) =>
                      requiredNoteMeValidator(locale, value),
                ),
                TextNoteMeInputFormControl(
                    placeholder: locale.global.password,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    validator: (String value) =>
                        requiredNoteMeValidator(locale, value)),
                SizedBox(height: 100),
                TextNoteMeButton(
                    text: locale.global.login,
                    onPressed:
                        state is! LoginLoading ? _onLoginButtonPressed : null),
                SizedBox(height: 20),
                TextNoteMeButton(
                    text: locale.global.sign_up,
                    onPressed: () {
                      NoteMeNavigator.push<SignupPage>(context);
                    }),
                Container(
                  child: state is LoginLoading
                      ? CircularProgressIndicator()
                      : null,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
