import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inscritus/about_app/about.dart';
import 'package:inscritus/inscritus_app.dart';
import 'authentication_bloc/authentication_bloc.dart';
import 'home_screen.dart';
import 'login/login_screen.dart';
import 'simple_bloc_delegate.dart';
import 'splash_screen.dart';
import 'user_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = UserRepository();
  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc(
        userRepository: userRepository,
      )..add(AppStarted()),
      child: Inscritus(userRepository: userRepository),
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
            return InscritusApp(email: state.displayName);
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
