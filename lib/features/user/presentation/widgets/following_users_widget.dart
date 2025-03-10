import 'package:flutter/material.dart';

class FollowingUsersWidget extends StatelessWidget {
  final int itemCount;
  final List<dynamic> users;

  const FollowingUsersWidget({
    super.key,
    required this.itemCount,
    required this.users,
  });

  @override
  Widget build(BuildContext context) {
    // Check if there are no users
    if (itemCount == 0) {
      return Center(
        child: Text(
          'Not following anyone',
          style: TextStyle(fontSize: 18, color: Colors.grey[500]),
        ),
      );
    }

    // Build the user list if there are users
    return ListView.separated(
      itemCount: itemCount,
      separatorBuilder: (context, index) => const Divider(
        color: Colors.white30,
        thickness: 0.5,
        height: 1,
      ),
      itemBuilder: (context, index) {
        var user = users[index];
        final avatarUrl = user['avatarUrl'];
        final username = user['username'];
        bool isFollowing = user['isFollowing'] ?? false;

        return ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: avatarUrl == null || avatarUrl.isEmpty
                ? const AssetImage('assets/images/avatar.png')
                : NetworkImage(avatarUrl) as ImageProvider,
          ),
          title: Text(
            username ?? 'Unknown User',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            isFollowing ? 'Following' : 'Not following',
            style: TextStyle(
              color: isFollowing ? Colors.blue[700] : Colors.red[300],
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.message, color: Colors.blueAccent),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Message button pressed for $username')),
              );
            },
          ),
        );
      },
    );
  }
}
