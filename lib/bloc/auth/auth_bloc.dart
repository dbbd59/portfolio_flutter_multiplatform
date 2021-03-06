// 🎯 Dart imports:
import 'dart:async';

// 📦 Package imports:
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 🌎 Project imports:
import 'package:portfolio_flutter/injections.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@Injectable()
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthEventStart) {
      if (getIt<SharedPreferences>().getString('accessToken') != null) {
        yield AuthStateLogged();
      } else {
        yield AuthStateUnLogged();
      }
    }
  }
}
