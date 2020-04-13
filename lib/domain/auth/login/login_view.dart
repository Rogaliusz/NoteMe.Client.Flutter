import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:noteme/domain/auth/authentication/authentication_bloc.dart';
import 'package:noteme/domain/auth/authentication/authentication_event.dart';
import 'package:noteme/domain/auth/login/states/login_state.dart';
import 'package:noteme/framework/ioc/injection.iconfig.dart';
import 'package:noteme/theme/backgrounds/unlogged_background.dart';
import 'package:noteme/theme/widgets/title_text.dart';

import 'login_bloc.dart';
import 'login_form.dart';

@injectable
class LoginPage extends StatelessWidget {
  LoginPage() : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(create: (context) {
      return getIt<LoginBloc>();
    }, child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      if (state is LoginSuccess) {
        BlocProvider.of<AuthenticationBloc>(context).add(AppStarted());
      }

      return UnloggedBackgroundBox(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TitleNoteMeText(text: 'NoteMe !'),
          SizedBox(height: 100),
          LoginForm(),
        ],
      ));
    })));
  }
}
