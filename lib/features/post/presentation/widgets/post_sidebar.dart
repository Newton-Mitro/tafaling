import 'package:cached_network_image_plus/flutter_cached_network_image_plus.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
            SizedBox(
              width: 50,
              child: Container(
                width: 50,
                height: 50,
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: CacheNetworkImagePlus(
                    imageUrl: profileImage,
                    errorWidget: Image.asset('assets/images/misc/avatar.png'),
                  ),
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
