import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hajat_mobile_app/src/featrues/app/ui/widgets/error_card.dart';
import 'package:hajat_mobile_app/src/featrues/brands/models/brand.dart';
import 'package:hajat_mobile_app/src/featrues/categories/models/category.dart';
import 'package:hajat_mobile_app/src/featrues/common/ui/alert_widget.dart';
import 'package:hajat_mobile_app/src/featrues/products/logic/cubit/products_cubit.dart';
import 'package:hajat_mobile_app/src/featrues/products/models/product.dart';
import 'package:hajat_mobile_app/src/featrues/products/ui/product_card.dart';
import 'package:hajat_mobile_app/src/utilities/consts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:shimmer/shimmer.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:permission_handler/permission_handler.dart';

@RoutePage()
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController controller;
  final ScrollController _scrollController = ScrollController();
  bool _showBackToTopButton = false;
  var cubit = ProductsCubit(null, null);
  FocusNode focusNode = FocusNode();

  // Speech to text properties
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    _initSpeech();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset > 100 && !_showBackToTopButton) {
      FocusManager.instance.primaryFocus?.unfocus();
      setState(() => _showBackToTopButton = true);
    } else if (_scrollController.offset <= 100 && _showBackToTopButton) {
      setState(() => _showBackToTopButton = false);
    }
  }

  void _initSpeech() async {
    await Permission.microphone.request();
    _speechEnabled = await _speechToText.initialize(
      onError: (error) => print('Speech Error: $error'),
      debugLogging: true,
    );
    setState(() {});
  }

  void _startListening() async {
    try {
      if (!_isListening) {
        var available = await _speechToText.initialize();
        if (available) {
          setState(() => _isListening = true);
          _speechToText.listen(
            onResult: (result) {
              setState(() {
                controller.text = result.recognizedWords;
                if (result.finalResult) {
                  _isListening = false;
                  cubit.loadProducts(null, null, controller.text);
                }
              });
            },
            cancelOnError: true,
            partialResults: true,
            listenMode: ListenMode.search,
          );
        }
      }
    } catch (e) {
      print('Voice search error: $e');
      setState(() => _isListening = false);
    }
  }

  void _stopListening() {
    _speechToText.stop();
    setState(() => _isListening = false);
  }

  @override
  void dispose() {
    _speechToText.stop();
    controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
    );
    FocusScope.of(context).requestFocus(focusNode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: RefreshIndicator(
                onRefresh: () async {
                  cubit.loadProducts(null, null, controller.text);
                },
                child: Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        Padding(
                          padding: Consts.paddingM,
                          child: SearchBar(
                            focusNode: focusNode,
                            elevation: WidgetStateProperty.all(0.0),
                            hintText: 'Search for products',
                            controller: controller,
                            onChanged: (value) {
                              cubit.loadProducts(null, null, value);
                              setState(() {});
                            },
                            leading: const HeroIcon(
                              HeroIcons.magnifyingGlass,
                              style: HeroIconStyle.solid,
                            ),
                            trailing: [
                              IconButton(
                                onPressed: _speechEnabled
                                    ? (_isListening ? _stopListening : _startListening)
                                    : null,
                                icon: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 200),
                                  child: _isListening
                                      ? const Icon(
                                          Icons.mic,
                                          color: Colors.red,
                                          key: ValueKey('listening'),
                                        )
                                      : const Icon(
                                          Icons.mic_none,
                                          key: ValueKey('not_listening'),
                                        ),
                                ),
                              ),
                              if (controller.text.isNotEmpty)
                                IconButton(
                                  onPressed: () {
                                    controller.clear();
                                    cubit.loadProducts(null, null, null);
                                    setState(() {});
                                  },
                                  icon: const Icon(Icons.clear),
                                ),
                            ],
                          ),
                        ),
                        BlocBuilder<ProductsCubit, ProductsState>(
                          bloc: cubit,
                          builder: (context, state) {
                            return state.maybeWhen(
                              loaded: (products) {
                                if (products.isEmpty) {
                                  return SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.65,
                                    child: AlertWidget(
                                      title: 'No products found',
                                      message: 'Try searching for something else.',
                                      image: 'assets/images/empty.png',
                                      onRetry: () {
                                        cubit.loadProducts(null, null, controller.text);
                                      },
                                    ),
                                  );
                                }
                                return GridView.count(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: Consts.paddingHM,
                                  crossAxisSpacing: 14,
                                  mainAxisSpacing: 14,
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.65,
                                  children: products
                                      .map((product) => ProductCard(product: product))
                                      .toList(),
                                );
                              },
                              error: (message) => ErrorCard(message: message),
                              orElse: () {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.orange[50]!,
                                  child: Padding(
                                    padding: Consts.paddingM,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Consts.gapVS,
                                        GridView.builder(
                                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 8,
                                            crossAxisSpacing: 8,
                                            childAspectRatio: 0.75,
                                          ),
                                          itemCount: 6,
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return ProductCard(
                                              product: Product(
                                                id: 1,
                                                name: 'Product',
                                                image: 'assets/images/empty.png',
                                                listPrice: 100,
                                                qtyAvailable: 100,
                                                brand: Brand(
                                                  id: index,
                                                  name: index.toString(),
                                                  image: "assets/images/empty.png"
                                                ),
                                                category: Category(
                                                  id: index,
                                                  name: index.toString(),
                                                  image: "assets/images/empty.png"
                                                ),
                                                productVariantId: index,
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (_isListening)
              Positioned.fill(
                child: GestureDetector(
                  onTap: _stopListening,
                  child: Container(
                    color: Colors.black26,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.mic,
                              size: 48,
                              color: Colors.red,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Listening...',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            if (controller.text.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              Text(
                                controller.text,
                                style: Theme.of(context).textTheme.bodyMedium,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              bottom: _showBackToTopButton ? 20 : -60,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: FilledButton.icon(
                  onPressed: _scrollToTop,
                  icon: const Icon(Icons.search),
                  label: const Text('Search Products'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}