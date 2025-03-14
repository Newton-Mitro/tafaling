import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tafaling/configs/routes/route_name.dart';
import 'package:tafaling/features/home/presentation/notifier/notifiers.dart';
import 'package:tafaling/features/home/presentation/widgets/bottom_sheet.dart';
import 'package:tafaling/features/post/data/models/post_model.dart';

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
                          child: profileImage.isNotEmpty
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
            _buildSidebarActionButton(
              FontAwesomeIcons.solidHeart,
              10,
              postModel?.isLiked == true ? Colors.red : Colors.white,
              () {
                if (accessTokenNotifier.value != null) {
                } else {
                  showCustomBottomSheet(context);
                }
              },
            ),
            _buildSidebarActionButton(
              FontAwesomeIcons.solidShareFromSquare,
              14,
              Colors.white,
              () {
                if (accessTokenNotifier.value != null) {
                } else {
                  showCustomBottomSheet(context);
                }
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
