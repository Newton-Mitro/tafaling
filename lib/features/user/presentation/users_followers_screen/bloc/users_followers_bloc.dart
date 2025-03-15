import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'users_followers_event.dart';
part 'users_followers_state.dart';

class UsersFollowersBloc extends Bloc<UsersFollowersEvent, UsersFollowersState> {
  UsersFollowersBloc() : super(UsersFollowersInitial()) {
    on<UsersFollowersEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
