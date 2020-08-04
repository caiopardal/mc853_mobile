import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inscritus/blocs/authentication/authentication_bloc.dart';
import 'package:inscritus/inscritus_app.dart';
import 'package:inscritus/services/fcm.dart';
import 'package:inscritus/views/login/login.dart';
import 'blocs/simple_bloc_delegate.dart';
import 'views/splash_screen.dart';
import 'repositories/user_repository.dart';

void main() {
  _main(
    null,
  );
}

void mainTest(
  UserRepository userRepository,
) {
  _main(
    userRepository,
  );
}

void _main(
  UserRepository userRepository,
) {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final FCM fcm = FCM();

  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc(
        userRepository: userRepository,
        fcm: fcm,
      )..add(AppStarted()),
      child: Inscritus(
        userRepository: userRepository,
      ),
    ),
  );
}

class Inscritus extends StatelessWidget {
  final UserRepository _userRepository;

  Inscritus({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Unauthenticated) {
            return LoginScreen(userRepository: _userRepository);
          }
          if (state is Authenticated) {
            return InscritusApp(
              email: state.user.email,
              uid: state.user.uid,
              isAdmin: state.user.isAdmin,
            );
          }
          return SplashScreen();
        },
      ),
      routes: {
        // '/home': (ctx) => HomeScreen(name: userName),
        // '/about': (ctx) => About(),
      },
    );
  }
}
