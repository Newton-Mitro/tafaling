import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tafaling/core/extensions/app_context.dart';
import 'package:tafaling/features/user/domain/entities/user_entity.dart';

class ImagePostPreview extends StatelessWidget {
  final String attachmentUrl;
  final String postBody;
  final UserEntity userEntity;

  const ImagePostPreview({
    super.key,
    required this.attachmentUrl,
    required this.postBody,
    required this.userEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: context.theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(25, 0, 0, 0),
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Image section
          AspectRatio(
            aspectRatio: 16 / 9,
            child: CachedNetworkImage(
              imageUrl: attachmentUrl,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder:
                  (context, url) =>
                      const Center(child: CircularProgressIndicator()),
              errorWidget:
                  (context, url, error) =>
                      const Center(child: Icon(Icons.broken_image)),
            ),
          ),

          /// User info
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage:
                      userEntity.profilePicture != null
                          ? CachedNetworkImageProvider(
                            userEntity.profilePicture!,
                          )
                          : null,
                  radius: 20,
                  child:
                      userEntity.profilePicture == null
                          ? const Icon(Icons.person)
                          : null,
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userEntity.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      userEntity.email,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),

          /// Post body
          if (postBody.trim().isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(postBody),
            ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
