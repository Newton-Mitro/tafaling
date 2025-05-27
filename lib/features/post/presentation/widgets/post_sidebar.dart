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
        decoration: BoxDecoration(
          color: const Color.fromARGB(43, 0, 0, 0),
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.symmetric(vertical: 10),
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height / 5,
          right: 10,
        ),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, authState) {
            return Column(
              children: [
                GestureDetector(
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
                  },
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

                // BlocBuilder for post preview to get latest post data for buttons
                BlocBuilder<PostPreviewBloc, PostPreviewState>(
                  builder: (context, postPreviewState) {
                    if (postPreviewState is PostPreviewLoaded) {
                      final post = postPreviewState.post;
                      return Column(
                        children: [
                          _buildSidebarActionButton(
                            context,
                            FontAwesomeIcons.solidHeart,
                            post.likeCount,
                            post.isLiked
                                ? Colors.red
                                : context.theme.colorScheme.onPrimary,
                            () {
                              if (authState is Authenticated) {
                                final event =
                                    post.isLiked
                                        ? RemovePostLikeEvent(post.id)
                                        : PostLikeEvent(post.id);
                                context.read<PostPreviewBloc>().add(event);
                              } else {
                                showCustomBottomSheet(context);
                              }
                            },
                            () {
                              if (authState is Authenticated &&
                                  post.likeCount > 0) {
                                Navigator.pushNamed(
                                  context,
                                  AppRouteName.postLikedUsersPage,
                                  arguments: post.id,
                                );
                              }
                            },
                          ),

                          _buildSidebarActionButton(
                            context,
                            FontAwesomeIcons.solidShareFromSquare,
                            post.shareCount,
                            context.theme.colorScheme.onPrimary,
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
                              print("share count tapped!");
                            },
                          ),

                          _buildSidebarActionButton(
                            context,
                            FontAwesomeIcons.solidComment,
                            post.commentCount,
                            context.theme.colorScheme.onPrimary,
                            () {
                              if (authState is Authenticated) {
                                Navigator.pushNamed(
                                  context,
                                  AppRouteName.postCommentPage,
                                  arguments: postModel,
                                );
                              } else {
                                showCustomBottomSheet(context);
                              }
                            },
                            () {
                              print("comment count tapped!");
                            },
                          ),
                        ],
                      );
                    } else {
                      // You can show a loading or fallback widget here if needed
                      return const CircularProgressIndicator();
                    }
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
    VoidCallback onIconTap,
    VoidCallback onTextTap,
  ) {
    return Column(
      children: [
        IconButton(icon: FaIcon(icon, color: color), onPressed: onIconTap),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTextTap,
            borderRadius: BorderRadius.circular(20),
            splashColor: Colors.white.withOpacity(0.3),
            child: Container(
              width: 30,
              height: 30,
              alignment: Alignment.center,
              child: Text(
                count.toString(),
                style: TextStyle(
                  fontSize: 14,
                  color: context.theme.colorScheme.onPrimary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
