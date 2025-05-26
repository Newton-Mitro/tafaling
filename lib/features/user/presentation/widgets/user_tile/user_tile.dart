import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafaling/core/injection.dart';
import 'package:tafaling/features/auth/presentation/views/bloc/auth_bloc/auth_bloc.dart';
import 'package:tafaling/features/home/presentation/widgets/bottom_sheet.dart';
import 'package:tafaling/features/user/domain/entities/user_entity.dart';
import 'package:tafaling/features/user/presentation/widgets/user_tile/bloc/user_tile_bloc.dart';
import 'package:tafaling/routes/app_route_name.dart';

class UserTile extends StatelessWidget {
  final UserEntity user;

  const UserTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<UserTileBloc>()..add(LoadUserEvent(user)),
        ),
      ],
      child: BlocBuilder<UserTileBloc, UserTileState>(
        builder: (context, userTileState) {
          if (userTileState is UserTileLoaded) {
            return BlocBuilder<AuthBloc, AuthState>(
              builder: (context, authState) {
                return Card(
                  color: Theme.of(context).colorScheme.surface,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    minTileHeight: 60,
                    leading: CachedNetworkImage(
                      imageUrl: user.profilePicture ?? '',
                      imageBuilder:
                          (context, imageProvider) => ClipOval(
                            child: Image(
                              image: imageProvider,
                              fit: BoxFit.cover,
                              width: 40,
                              height: 40,
                            ),
                          ),
                      placeholder:
                          (context, url) => SizedBox(
                            width: 40,
                            height: 40,
                            child: CircularProgressIndicator(),
                          ),
                      errorWidget:
                          (context, url, error) => ClipOval(
                            child: Image.asset(
                              'assets/images/misc/avatar.png',
                              fit: BoxFit.cover,
                              width: 40,
                              height: 40,
                            ),
                          ),
                    ),
                    title: Text(
                      user.name,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    trailing:
                        authState is Authenticated
                            ? ElevatedButton(
                              onPressed: () {
                                userTileState.user.isFollowing
                                    ? context.read<UserTileBloc>().add(
                                      UnfollowUserEvent(userTileState.user.id),
                                    )
                                    : context.read<UserTileBloc>().add(
                                      FollowUserEvent(userTileState.user.id),
                                    );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    userTileState.user.isFollowing
                                        ? const Color.fromARGB(255, 13, 82, 14)
                                        : const Color.fromARGB(255, 6, 47, 82),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                minimumSize: const Size(70, 30),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                              child: Text(
                                userTileState.user.isFollowing
                                    ? 'Unfollow'
                                    : 'Follow',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            )
                            : const SizedBox.shrink(),
                    onTap: () {
                      if (authState is Authenticated) {
                        Navigator.pushNamed(
                          context,
                          AppRouteName.userProfilePage,
                          arguments: userTileState.user,
                        );
                      } else {
                        showCustomBottomSheet(context);
                      }
                    },
                  ),
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
