import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tafaling/core/extensions/app_context.dart';
import 'package:tafaling/features/auth/presentation/views/bloc/auth_bloc/auth_bloc.dart';
import 'package:tafaling/features/home/presentation/widgets/bottom_sheet.dart';
import 'package:tafaling/features/post/domain/entities/post_entity.dart';
import 'package:tafaling/features/post/presentation/widgets/post_viewer/bloc/post_preview_bloc.dart';
import 'package:tafaling/routes/app_route_name.dart';

class PostSidebar extends StatelessWidget {
  final PostEntity postModel;

  const PostSidebar({super.key, required this.postModel});

  @override
  Widget build(BuildContext context) {
    final String profileImage = postModel.creator.profilePicture ?? '';
    return Positioned(
      right: 0,
      child: Container(
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height / 3,
          right: 10,
        ),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, authState) {
            return Column(
              children: [
                GestureDetector(
                  // Wrap the SizedBox with GestureDetector
                  onTap: () {
                    if (authState is Authenticated) {
                      Navigator.pushNamed(
                        context,
                        AppRouteName.userProfilePage,
                        arguments: postModel.creator,
                      );
                    } else {
                      showCustomBottomSheet(context);
                    }
                  }, // Handle the tap
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 5,
                          child: Container(
                            width: 45,
                            height: 45,
                            padding: const EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(35),
                              child:
                                  profileImage.isNotEmpty
                                      ? CachedNetworkImage(
                                        imageUrl: profileImage,
                                      )
                                      : Image.asset(
                                        'assets/images/misc/avatar.png',
                                        fit: BoxFit.cover,
                                      ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                BlocBuilder<PostPreviewBloc, PostPreviewState>(
                  builder: (context, state) {
                    if (state is PostPreviewLoaded) {
                      return _buildSidebarActionButton(
                        context,
                        FontAwesomeIcons.solidHeart,
                        state.post.likeCount,
                        state.post.isLiked
                            ? Colors.red
                            : context.theme.colorScheme.surface,
                        () {
                          if (authState is Authenticated) {
                            final event =
                                state.post.isLiked
                                    ? RemovePostLikeEvent(state.post.id)
                                    : PostLikeEvent(state.post.id);
                            context.read<PostPreviewBloc>().add(event);
                          } else {
                            showCustomBottomSheet(context);
                          }
                        },
                        () {
                          if (authState is Authenticated) {
                            Navigator.pushNamed(
                              context,
                              AppRouteName.postLikedUsersPage,
                              arguments: state.post.id,
                            );
                          } else {
                            showCustomBottomSheet(context);
                          }
                        },
                      );
                    }
                    return CircularProgressIndicator();
                  },
                ),
                _buildSidebarActionButton(
                  context,
                  FontAwesomeIcons.solidShareFromSquare,
                  1,
                  context.theme.colorScheme.surface,
                  () {
                    if (authState is Authenticated) {
                      Navigator.pushNamed(
                        context,
                        AppRouteName.postSharePage,
                        arguments: postModel,
                      );
                    } else {
                      showCustomBottomSheet(context);
                    }
                  },
                  () {
                    // Action when clicking the like count text
                    print("share count tapped!");
                  },
                ),
                _buildSidebarActionButton(
                  context,
                  FontAwesomeIcons.solidComment,
                  5,
                  context.theme.colorScheme.surface,
                  () {
                    if (authState is Authenticated) {
                      Navigator.pushNamed(
                        context,
                        AppRouteName.postSharePage,
                        arguments: postModel.creator,
                      );
                    } else {
                      showCustomBottomSheet(context);
                    }
                  },
                  () {
                    // Action when clicking the like count text
                    print("comment count tapped!");
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSidebarActionButton(
    BuildContext context,
    IconData icon,
    int count,
    Color color,
    VoidCallback onIconTap, // Action for the icon
    VoidCallback onTextTap, // Action for the text
  ) {
    return Column(
      children: [
        IconButton(
          icon: FaIcon(icon, color: color),
          onPressed: onIconTap, // Action for icon
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTextTap, // Action for text
            borderRadius: BorderRadius.circular(20),
            splashColor: Colors.white.withOpacity(0.3),
            child: Container(
              width: 30,
              height: 30,
              alignment: Alignment.center,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: TextButton(
                onPressed: onTextTap, // Separate action for text
                child: Text(
                  count.toString(),
                  style: TextStyle(
                    fontSize: 14,
                    color: context.theme.colorScheme.surface,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
