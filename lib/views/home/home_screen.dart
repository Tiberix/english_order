import 'package:english_order/components/my_drawer.dart';
import 'package:english_order/util/constants.dart';
import 'package:english_order/controllers/cart_controller.dart';
import 'package:english_order/models/product.dart';
import 'package:english_order/views/details/details_screen.dart';
import 'package:flutter/material.dart';
import 'components/cart_details_view.dart';
import 'components/cart_short_view.dart';
import 'components/header.dart';
import 'components/product_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => HomeScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    CartController controll = context.read<CartController>();
    return Scaffold(
      backgroundColor: Colors.white,
      //appBar: MyAppBar('Order'),
      endDrawer: MyDrawer(
        con: context,
      ),
      body: SafeArea(
        child: Container(
          color: primaryColor,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: AnimatedBuilder(
                animation: controll,
                builder: (context, _) {
                  return LayoutBuilder(
                    builder: (context, BoxConstraints constraints) {
                      return Stack(
                        children: [
                          AnimatedPositioned(
                            duration: panelTransition,
                            top: controll.homeState == HomeState.normal
                                ? headerHeight
                                : -(constraints.maxHeight -
                                    cartBarHeight * 2 -
                                    headerHeight),
                            left: 0,
                            right: 0,
                            height: constraints.maxHeight -
                                headerHeight -
                                cartBarHeight,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: defaultPadding),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  bottomLeft:
                                      Radius.circular(defaultPadding * 1.5),
                                  bottomRight:
                                      Radius.circular(defaultPadding * 1.5),
                                ),
                              ),
                              child: GridView.builder(
                                controller: ScrollController(),
                                itemCount: getProdukte().length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.75,
                                  mainAxisSpacing: defaultPadding,
                                  crossAxisSpacing: defaultPadding,
                                ),
                                itemBuilder: (context, index) => ProductCard(
                                  heroId: getProdukte()[index].title,
                                  product: getProdukte()[index],
                                  press: () {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        transitionDuration:
                                            const Duration(milliseconds: 500),
                                        reverseTransitionDuration:
                                            const Duration(milliseconds: 1000),
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            FadeTransition(
                                          opacity: animation,
                                          child: DetailsScreen(
                                            heroId: getProdukte()[index].title,
                                            product: getProdukte()[index],
                                            onProductAdd: () {
                                              controll.addProductToCart(
                                                  getProdukte()[index]);
                                            },
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          AnimatedPositioned(
                            duration: panelTransition,
                            bottom: 0,
                            left: 0,
                            right: 0,
                            height: controll.homeState == HomeState.normal
                                ? cartBarHeight
                                : (constraints.maxHeight - cartBarHeight),
                            child: GestureDetector(
                              onVerticalDragUpdate: (details) {
                                if (details.primaryDelta! < -0.7) {
                                  controll.changeHomeState(HomeState.cart);
                                } else if (details.primaryDelta! > 12) {
                                  controll.changeHomeState(HomeState.normal);
                                }
                              },
                              onTap: () =>
                                  controll.changeHomeState(HomeState.cart),
                              child: Container(
                                padding: const EdgeInsets.all(defaultPadding),
                                color: const Color(0xFFEAEAEA),
                                alignment: Alignment.topLeft,
                                child: AnimatedSwitcher(
                                    duration: panelTransition,
                                    child: controll.homeState ==
                                            HomeState.normal
                                        ? CardShortView() //(controller: controll)
                                        : CartDetailsView() //(controller: controll),
                                    ),
                              ),
                            ),
                          ),
                          //Header
                          AnimatedPositioned(
                            duration: panelTransition,
                            top: controll.homeState == HomeState.normal
                                ? 0
                                : -headerHeight,
                            right: 0,
                            left: 0,
                            height: headerHeight,
                            child: const HomeHeader(),
                          ),
                        ],
                      );
                    },
                  );
                }),
          ),
        ),
      ),
    );
  }
}
