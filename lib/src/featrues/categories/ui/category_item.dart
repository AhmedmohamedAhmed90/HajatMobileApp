import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hajat_mobile_app/src/featrues/categories/models/category.dart';
import 'package:hajat_mobile_app/src/utilities/consts.dart';
import 'package:hajat_mobile_app/src/utilities/router.dart';




class CategoryItem extends StatelessWidget {
  final Category category;

  const CategoryItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // borderRadius: BorderRadius.circular(Consts.borderRadiusM),
      onTap: () {
        context.router.push(CategoryDetailsRoute(category: category));
      },
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Consts.borderRadiusM),
              border: Border.all(
                color: Colors.blueGrey[100]!,
                width: 2,
              ),
            ),
            child: AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Consts.borderRadiusM),
                child: CachedNetworkImage(
                  imageUrl: category.image!,
                  // height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.contain,
                  progressIndicatorBuilder: (context, url, progress) {
                    return Container(
                      // height: 50,
                      // width: 50,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[100],
                        borderRadius:
                            BorderRadius.circular(Consts.borderRadiusM),
                      ),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        // height: 50,
                        // width: 50,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[100],
                          borderRadius:
                              BorderRadius.circular(Consts.borderRadiusM),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Consts.gapS,
          Text(
            category.name,
            style: Theme.of(context).textTheme.bodyLarge,
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
