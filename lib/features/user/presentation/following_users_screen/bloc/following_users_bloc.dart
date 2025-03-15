import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'following_users_event.dart';
part 'following_users_state.dart';

class FollowingUsersBloc extends Bloc<FollowingUsersEvent, FollowingUsersState> {
  FollowingUsersBloc() : super(FollowingUsersInitial()) {
    on<FollowingUsersEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
