import 'package:flutter/material.dart';

class ReadMoreText extends StatefulWidget {
  final String text;
  final int maxLines;

  const ReadMoreText({super.key, required this.text, this.maxLines = 2});

  @override
  _ReadMoreTextState createState() => _ReadMoreTextState();
}

class _ReadMoreTextState extends State<ReadMoreText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final double maxHeight = MediaQuery.of(context).size.height - 260;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(maxHeight: maxHeight),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Text(
              style: const TextStyle(color: Color.fromARGB(255, 209, 209, 209)),
              _isExpanded
                  ? widget.text
                  : (widget.text.length > 100
                      ? '${widget.text.substring(0, 100)}...'
                      : widget.text),
              maxLines: _isExpanded ? null : widget.maxLines,
              overflow: _isExpanded ? null : TextOverflow.ellipsis,
            ),
          ),
        ),
        if (widget.text.length > 100)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('...'),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Text(
                  _isExpanded ? 'Less' : 'More',
                  style: const TextStyle(
                      color: Color.fromARGB(255, 219, 219, 219)),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
