import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uts/core/const.dart';

class ProductCarouselSlider extends StatefulWidget {
  final String images;
  const ProductCarouselSlider({super.key, required this.images});

  @override
  State<ProductCarouselSlider> createState() => _ProductCarouselSliderState();
}

class _ProductCarouselSliderState extends State<ProductCarouselSlider> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            CarouselSlider(
              items: [
                Container(
                  color: Colors.white,
                  child: Hero(
                    tag: widget.images,
                    child: CachedNetworkImage(
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      imageUrl: baseUrl + widget.images,
                      placeholder: (context, url) => Shimmer.fromColors(
                        highlightColor: Colors.white,
                        baseColor: Colors.grey.shade300,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          color: Colors.grey.shade300,
                        ),
                      ),
                      errorWidget: (context, url, error) => const Center(
                        child: Icon(
                          Icons.error_outline,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              options: CarouselOptions(
                  autoPlay: false,
                  enlargeCenterPage: true,
                  aspectRatio: 1.5,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  }
              ),
            ),
            Positioned(
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios),

              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 6,
              height: 6,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentIndex == 0 ? Colors.grey.shade600 : Colors.grey.shade400,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
