import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:inscritus/blocs/register/bloc/bloc.dart';
import 'package:inscritus/helpers/validators.dart';
import 'package:inscritus/repositories/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;

  RegisterBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  RegisterState get initialState => RegisterState.empty();

  @override
  Stream<Transition<RegisterEvent, RegisterState>> transformEvents(
    Stream<RegisterEvent> events,
    TransitionFunction<RegisterEvent, RegisterState> transitionFn,
  ) {
    final nonDebounceStream = events.where((event) {
      return (event is! EmailChanged &&
          event is! PasswordChanged &&
          event is! CPFChanged &&
          event is! NameChanged &&
          event is! PhoneChanged);
    });
    final debounceStream = events.where((event) {
      return (event is EmailChanged ||
          event is PasswordChanged ||
          event is CPFChanged ||
          event is NameChanged ||
          event is PhoneChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      transitionFn,
    );
  }

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is EmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is PasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is CPFChanged) {
      yield* _mapCPFChangedToState(event.cpf);
    } else if (event is NameChanged) {
      yield* _mapNameChangedToState(event.name);
    } else if (event is PhoneChanged) {
      yield* _mapPhoneChangedToState(event.phone);
    } else if (event is Submitted) {
      yield* _mapFormSubmittedToState(
        event.email,
        event.password,
        event.cpf,
        event.name,
        event.phone,
      );
    }
  }

  Stream<RegisterState> _mapEmailChangedToState(String email) async* {
    yield state.update(
      isEmailValid: Validators.isValidEmail(email),
    );
  }

  Stream<RegisterState> _mapPasswordChangedToState(String password) async* {
    yield state.update(
      isPasswordValid: Validators.isValidPassword(password),
    );
  }

  Stream<RegisterState> _mapCPFChangedToState(String cpf) async* {
    yield state.update(
      isCPFValid: Validators.validateCPF(cpf),
    );
  }

  Stream<RegisterState> _mapNameChangedToState(String name) async* {
    yield state.update(
      isNameValid: Validators.validateUserName(name),
    );
  }

  Stream<RegisterState> _mapPhoneChangedToState(String phone) async* {
    yield state.update(
      isPhoneValid: Validators.validatePhone(phone),
    );
  }

  Stream<RegisterState> _mapFormSubmittedToState(
    String email,
    String password,
    String cpf,
    String name,
    String phone,
  ) async* {
    yield RegisterState.loading();
    try {
      await _userRepository.signUp(
        email: email,
        password: password,
        cpf: cpf,
        name: name,
        phone: phone,
      );
      yield RegisterState.success();
    } catch (_) {
      yield RegisterState.failure();
    }
  }
}
