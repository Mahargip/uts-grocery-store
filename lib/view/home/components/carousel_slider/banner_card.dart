import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uts/core/const.dart';

class BannerCard extends StatefulWidget {
  final String imageUrl;

  const BannerCard({super.key, required this.imageUrl});

  @override
  State<BannerCard> createState() => _BannerCardState();
}

class _BannerCardState extends State<BannerCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: CachedNetworkImage(
          imageUrl: '$baseUrl${widget.imageUrl}',
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              Shimmer.fromColors(
                highlightColor: Colors.white,
                baseColor: Colors.grey.shade300,
                child: Container(
                            margin: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Container(
                    color: Colors.grey,
                  ),
                ),
                            ),
                          ),
              ),
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ),
    );
  }
}
