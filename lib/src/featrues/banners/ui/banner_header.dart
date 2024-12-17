import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hajat_mobile_app/src/services/locator/get_it.dart';
import 'package:hajat_mobile_app/src/utilities/consts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:hajat_mobile_app/src/featrues/banners/logic/cubit/banner_cubit.dart';

class BannersHeader extends StatefulWidget {
  const BannersHeader({super.key});

  @override
  State<BannersHeader> createState() => _BannersHeaderState();
}

class _BannersHeaderState extends State<BannersHeader> {
  PageController controller = PageController();
  Timer? _scrollTimer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _scrollTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (controller.hasClients) {
        double maxScroll = controller.position.maxScrollExtent;
        double currentScroll = controller.position.pixels;

        if (currentScroll >= maxScroll) {
          // Reset scroll position to the start
          // controller.jumpTo(0);
          controller.animateTo(0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut);
        } else {
          // Scroll down by 100 pixels
          controller.nextPage(
            // currentScroll + 100,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOut,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannersCubit, BannersState>(
      bloc: getIt<BannersCubit>(),
      builder: (context, state) {
        return state.maybeMap(
          orElse: () {
            return const SizedBox();
          },
          loaded: (value) {
            return Column(
              children: [
                SizedBox(
                  height: 200,
                  child: PageView.builder(
                    controller: controller,
                    scrollDirection: Axis.horizontal,
                    itemCount: value.banners.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius:
                              BorderRadius.circular(Consts.borderRadiusXL),
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(Consts.borderRadiusXL),
                          child: CachedNetworkImage(
                            imageUrl: value.banners[index].image,
                            fit: BoxFit.cover,
                            width: 300,
                            placeholder: (context, url) {
                              return Image.asset(
                                'assets/images/placeholder.jpg',
                                fit: BoxFit.cover,
                              );
                            },
                            errorWidget: (context, url, error) => Image.asset(
                              'assets/images/placeholder.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Consts.gapVS,
                SmoothPageIndicator(
                  controller: controller,
                  count: value.banners.length,
                  effect: ExpandingDotsEffect(
                    dotWidth: 10,
                    dotHeight: 10,
                    activeDotColor: Theme.of(context).colorScheme.primary,
                    dotColor: Theme.of(context).colorScheme.primaryContainer,
                  ),
                )
              ],
            );
          },
          loading: (value) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.orange[50]!,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(Consts.borderRadiusXL),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(Consts.borderRadiusXL),
                    child: Image.asset('assets/images/banner1.jpeg')),
              ),
            );
          },
        );
      },
    );
  }
}
