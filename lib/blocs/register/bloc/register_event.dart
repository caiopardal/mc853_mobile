import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends RegisterEvent {
  final String email;

  const EmailChanged({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'EmailChanged { email :$email }';
}

class PasswordChanged extends RegisterEvent {
  final String password;

  const PasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class CPFChanged extends RegisterEvent {
  final String cpf;

  const CPFChanged({
    @required this.cpf,
  });

  @override
  List<Object> get props => [
        cpf,
      ];

  @override
  String toString() => 'CPFChanged { cpf: $cpf }';
}

class NameChanged extends RegisterEvent {
  final String name;

  const NameChanged({
    @required this.name,
  });

  @override
  List<Object> get props => [
        name,
      ];

  @override
  String toString() => 'NameChanged { name: $name }';
}

class PhoneChanged extends RegisterEvent {
  final String phone;

  const PhoneChanged({
    @required this.phone,
  });

  @override
  List<Object> get props => [
        phone,
      ];

  @override
  String toString() => 'PhoneChanged { phone: $phone }';
}

class Submitted extends RegisterEvent {
  final String email;
  final String password;
  final String cpf;
  final String name;
  final String phone;

  const Submitted({
    @required this.email,
    @required this.password,
    @required this.cpf,
    @required this.name,
    @required this.phone,
  });

  @override
  List<Object> get props => [
        email,
        password,
        cpf,
        name,
        password,
      ];

  @override
  String toString() {
    return 'Submitted { email: $email, password: $password, cpf: $cpf, name: $name, phone: $phone, }';
  }
}
