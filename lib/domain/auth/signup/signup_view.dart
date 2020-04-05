import 'dart:async';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:noteme/domain/auth/login/login_view.dart';
import 'package:noteme/domain/auth/signup/signup_bloc.dart';
import 'package:noteme/domain/auth/signup/states/signup_state.dart';
import 'package:noteme/framework/ioc/injection.iconfig.dart';
import 'package:noteme/framework/navigation/navigrator.dart';
import 'package:noteme/generated/locale_base.dart';
import 'package:noteme/theme/backgrounds/unlogged_background.dart';
import 'package:noteme/theme/widgets/form/text_input_form_control.dart';
import 'package:noteme/theme/widgets/form/validators/required_validator.dart';
import 'package:noteme/theme/widgets/text_button.dart';
import 'package:noteme/theme/widgets/title_text.dart';
import 'events/signup_event.dart';

@injectable
class SignupPage extends StatefulWidget {
  SignupPage() : super();

  @override
  SignupPageState createState() => getIt<SignupPageState>();
}

@injectable
class SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> _key = new GlobalKey<FormState>();

  SignupBloc _bloc;
  StreamSubscription _sub;

  String _login;
  String _password;

  @override
  void didChangeDependencies() {
    _bloc = getIt<SignupBloc>();
    _sub = _bloc.stateStream.listen(onData);

    super.didChangeDependencies();
  }

  void onData(SignupState event) {
    switch (event.runtimeType) {
      case SignupOkState:
        {
          print('registered');
        }
        break;
      case SignupErrorState:
        {
          var error = event as SignupErrorState;
          print('failed ' + error.error);
        }
        break;
    }
  }

  @override
  void dispose() {
    _bloc.dispose();

    print('disposed');

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.of<LocaleBase>(context, LocaleBase);
    return Scaffold(
      body: UnloggedBackgroundBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TitleNoteMeText(text: 'NoteMe !'),
            SizedBox(height: 100),
            Form(
              key: this._key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextNoteMeInputFormControl(
                              placeholder: locale.global.email,
                              keyboardType: TextInputType.emailAddress,
                              validator: (String value) =>
                                  requiredNoteMeValidator(locale, value),
                              onSaved: (String value) => _login = value),
                          TextNoteMeInputFormControl(
                              placeholder: locale.global.password,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              validator: (String value) =>
                                  requiredNoteMeValidator(locale, value),
                              onSaved: (String value) => _password = value),
                          TextNoteMeInputFormControl(
                              placeholder: locale.global.password,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              validator: (String value) =>
                                  requiredNoteMeValidator(locale, value),
                              onSaved: (String value) => _password = value),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 100),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextNoteMeButton(
                              text: locale.global.sign_up,
                              onPressed: () {
                                _key.currentState.save();

                                if (!_key.currentState.validate()) {
                                  return;
                                }

                                _bloc.eventSink.add(new SignupEvent(
                                    this._login, this._password));
                              }),
                          SizedBox(height: 20),
                          TextNoteMeButton(
                              text: locale.global.login,
                              onPressed: () {
                                NoteMeNavigator.push<LoginPage>(context);
                              }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
