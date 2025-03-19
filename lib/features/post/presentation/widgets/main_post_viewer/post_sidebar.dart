import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tafaling/configs/routes/route_name.dart';
import 'package:tafaling/features/home/presentation/notifier/notifiers.dart';
import 'package:tafaling/features/home/presentation/widgets/bottom_sheet.dart';
import 'package:tafaling/features/post/domain/entities/post_entity.dart';
import 'package:tafaling/features/post/presentation/posts_screen/bloc/posts_screen_bloc.dart';

class PostSidebar extends StatelessWidget {
  final PostEntity? postModel;

  const PostSidebar({super.key, required this.postModel});

  @override
  Widget build(BuildContext context) {
    final String profileImage = postModel?.creator.profilePicture ?? '';
    return Positioned(
      right: 0,
      child: Container(
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height / 3,
          right: 10,
        ),
        child: Column(
          children: [
            GestureDetector(
              // Wrap the SizedBox with GestureDetector
              onTap: () {
                if (accessTokenNotifier.value != null) {
                  Navigator.pushNamed(
                    context,
                    RoutesName.userProfilePage,
                    arguments: postModel?.creator.id,
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
                                  ? CachedNetworkImage(imageUrl: profileImage)
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
            _buildSidebarActionButton(
              FontAwesomeIcons.solidHeart,
              postModel?.likeCount ?? 0,
              postModel?.isLiked == true ? Colors.red : Colors.white,
              () {
                if (accessTokenNotifier.value != null) {
                  final event =
                      postModel?.isLiked == true
                          ? DisLikePostEvent(postModel?.id ?? 0)
                          : LikePostEvent(postModel?.id ?? 0);
                  context.read<PostsScreenBloc>().add(event);
                } else {
                  showCustomBottomSheet(context);
                }
              },
              () {
                if (accessTokenNotifier.value != null) {
                  Navigator.pushNamed(
                    context,
                    RoutesName.postLikedUsersPage,
                    arguments: postModel?.id,
                  );
                } else {
                  showCustomBottomSheet(context);
                }
              },
            ),
            _buildSidebarActionButton(
              FontAwesomeIcons.solidShareFromSquare,
              1,
              Colors.white,
              () {
                if (accessTokenNotifier.value != null) {
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
              FontAwesomeIcons.solidComment,
              5,
              Colors.white,
              () {
                if (accessTokenNotifier.value != null) {
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
        ),
      ),
    );
  }

  Widget _buildSidebarActionButton(
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
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
