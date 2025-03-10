import 'package:flutter/material.dart';
import 'package:tafaling/core/utils/app_context.dart';
import 'package:tafaling/features/post/data/models/post_model.dart';
import 'package:tafaling/features/post/presentation/widgets/read_more_text.dart';

class PostBody extends StatelessWidget {
  final PostModel postModel;

  const PostBody({super.key, required this.postModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10, left: 15, right: 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            postModel.creator.name,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: context.theme.colorScheme.onPrimary),
          ),
          ReadMoreText(text: postModel.body ?? ''),
        ],
      ),
    );
  }
}
