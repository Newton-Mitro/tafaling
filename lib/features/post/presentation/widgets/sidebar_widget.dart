import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tafaling/core/widgets/user_avatar.dart';
import 'package:tafaling/features/post/data/models/post_model.dart';

class SidebarWidget extends StatelessWidget {
  final PostModel? postModel;

  const SidebarWidget({super.key, required this.postModel});

  @override
  Widget build(BuildContext context) {
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
            UserAvatar(
              profilePhotoUrl: postModel?.creator.profilePicture,
              onTap: () {},
            ),
            _buildSidebarActionButton(FontAwesomeIcons.solidHeart, 10,
                postModel?.isLiked == true ? Colors.red : Colors.white, () {}),
            _buildSidebarActionButton(
                FontAwesomeIcons.solidShareFromSquare, 14, Colors.white, () {}),
            _buildSidebarActionButton(
                FontAwesomeIcons.solidComment, 5, Colors.white, () {}),
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
        Text(
          count.toString(),
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
