import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:shedmedd/config/customCircularProg.dart';
import 'package:shedmedd/config/getImageUrl.dart';
import 'package:shedmedd/constants/customColors.dart';

// Pictures of the item
class Pictures extends StatelessWidget {
  const Pictures({
    super.key,
    required this.images,
  });

  final List<dynamic> images;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: images.map((image) {
        return FutureBuilder(
            future: getImageUrl(image),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height *
                        0.5, // Set the desired maximum height
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: CustomColors.white.withOpacity(0.4), width: 4),
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  clipBehavior: Clip
                      .antiAlias, // Add this line to apply clipping with anti-aliasing
                  child: CustomCircularProgress(),
                );
              } else if (snapshot.hasError) {
                return Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height *
                        0.5, // Set the desired maximum height
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: CustomColors.white.withOpacity(0.4), width: 4),
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  clipBehavior: Clip
                      .antiAlias, // Add this line to apply clipping with anti-aliasing
                  child: Center(child: Text('an error occured')),
                );
              } else {
                String downloadUrl = snapshot.data!;
                return Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height *
                        0.5, // Set the desired maximum height
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: CustomColors.white.withOpacity(0.4), width: 4),
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  clipBehavior: Clip
                      .antiAlias, // Add this line to apply clipping with anti-aliasing
                  child: InstaImageViewer(
                    backgroundIsTransparent: true,
                    child: Image.network(
                        downloadUrl,
                        fit: BoxFit.cover,
                      ),
                  ),
                );
              }
            });
      }).toList(),
      options: CarouselOptions(
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 3 / 4,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 1000),
        viewportFraction: 0.84,
        pageSnapping: true,
        pauseAutoPlayOnTouch: true,
        enlargeStrategy: CenterPageEnlargeStrategy.height,
      ),
    );
  }
}

class ImageScreen extends StatelessWidget {
  final String imagePath;

  ImageScreen({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image'),
      ),
      body: Center(
        child: Image.asset(
          imagePath,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
