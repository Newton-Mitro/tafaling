import 'package:cached_network_image_plus/flutter_cached_network_image_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tafaling/configs/routes/route_name.dart';
import 'package:tafaling/features/home/presentation/states/bloc/home_screen_bloc.dart';
import 'package:tafaling/features/post/data/models/post_model.dart';
import 'package:tafaling/features/post/presentation/states/post_bloc/posts_screen_bloc.dart';

class PostSidebar extends StatelessWidget {
  final PostModel? postModel;

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
                if (context.read<PostsScreenBloc>().state.loggedInUserId != 0) {
                  Navigator.pushNamed(
                    context,
                    RoutesName.userProfilePage,
                    arguments: postModel?.creator.id,
                  );
                } else {
                  context
                      .read<HomeScreenBloc>()
                      .add(const SetGuestStateEvent());
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
                          child: profileImage.isNotEmpty
                              ? CacheNetworkImagePlus(
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
            _buildSidebarActionButton(
              FontAwesomeIcons.solidHeart,
              10,
              postModel?.isLiked == true ? Colors.red : Colors.white,
              () => print('Heart clicked'),
            ),
            _buildSidebarActionButton(
              FontAwesomeIcons.solidShareFromSquare,
              14,
              Colors.white,
              () => print('Share clicked'),
            ),
            _buildSidebarActionButton(
              FontAwesomeIcons.solidComment,
              5,
              Colors.white,
              () => print('Comment clicked'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSidebarActionButton(
      IconData icon, int count, Color color, VoidCallback onTap) {
    return Column(
      children: [
        IconButton(
          icon: FaIcon(icon, color: color),
          onPressed: onTap,
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(20),
            splashColor: Colors.white.withOpacity(0.3),
            child: Container(
              width: 30,
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Text(
                count.toString(),
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
