import 'package:flutter/material.dart';

// Pictures of the item
class Pictures extends StatelessWidget {
  const Pictures({
    super.key,
    required this.images,
  });

  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height *
            0.5, // Set the desired maximum height
      ),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(4),
      ),
      clipBehavior:
          Clip.antiAlias, // Add this line to apply clipping with anti-aliasing
      child: Image.asset(
        'assets/images/dummy/${images[0]}',
        fit: BoxFit.cover,
      ),
    );
  }
}