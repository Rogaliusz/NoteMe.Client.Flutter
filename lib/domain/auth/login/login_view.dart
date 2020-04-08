import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:noteme/domain/auth/login/events/login_event.dart';
import 'package:noteme/domain/auth/login/login_bloc.dart';
import 'package:noteme/domain/auth/login/states/logged_state.dart';
import 'package:noteme/domain/auth/signup/signup_view.dart';
import 'package:noteme/domain/notes/notes_view.dart';
import 'package:noteme/framework/ioc/injection.iconfig.dart';
import 'package:noteme/framework/navigation/navigrator.dart';
import 'package:noteme/generated/locale_base.dart';
import 'package:noteme/theme/backgrounds/unlogged_background.dart';
import 'package:noteme/theme/services/toast_service.dart';
import 'package:noteme/theme/widgets/form/text_input_form_control.dart';
import 'package:noteme/theme/widgets/form/validators/required_validator.dart';
import 'package:noteme/theme/widgets/text_button.dart';
import 'package:noteme/theme/widgets/title_text.dart';

@injectable
class LoginPage extends StatefulWidget {
  LoginPage() : super();

  @override
  LoginPageState createState() => getIt<LoginPageState>();
}

@injectable
class LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _key = new GlobalKey<FormState>();
  final ToastService _toastService;

  LoginPageState(this._toastService);

  LocaleBase locale;
  LoginBloc _bloc;

  String _login;
  String _password;

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _bloc = getIt<LoginBloc>();
    _bloc.logged.listen(onData);

    super.didChangeDependencies();
  }

  onData(LoggedState state) {
    switch (state.runtimeType) {
      case LoginOkState:
        {
          NoteMeNavigator.push<NotesPage>(context);
        }
        break;
      case LoginErrorState:
        {
          _toastService.show(locale.login.invalid);
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    locale = Localizations.of<LocaleBase>(context, LocaleBase);

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
                              text: locale.global.login,
                              onPressed: () {
                                _key.currentState.save();

                                if (!_key.currentState.validate()) {
                                  return;
                                }

                                var event = new LoginEvent(_login, _password);
                                _bloc.login.add(event);
                              }),
                          SizedBox(height: 20),
                          TextNoteMeButton(
                              text: locale.global.sign_up,
                              onPressed: () {
                                NoteMeNavigator.push<SignupPage>(context);
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
