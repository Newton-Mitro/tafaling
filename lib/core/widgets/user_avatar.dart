import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar(
      {super.key, required this.profilePhotoUrl, required this.onTap});

  final String profilePhotoUrl;
  final VoidCallback onTap; // Add the onTap callback

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Wrap the SizedBox with GestureDetector
      onTap: onTap, // Handle the tap
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
                  child: CachedNetworkImage(
                    imageUrl: profilePhotoUrl,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
