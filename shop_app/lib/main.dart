import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/helpers/custom_route.dart';

import './providers/auth.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';
import './screens/cart_screen.dart';
import './screens/auth_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/products_overview_screen.dart';
import './screens/splash_screen.dart';
import './screens/product_detail_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, Products>(
              update: (ctx, auth, previousProduct) => Products(
                  auth.token,
                  auth.userId,
                  previousProduct == null ? [] : previousProduct.items)),
          ChangeNotifierProvider.value(value: Cart()),
          ChangeNotifierProxyProvider<Auth, Orders>(
              update: (ctx, auth, previousOrder) => Orders(
                  auth.token,
                  auth.userId,
                  previousOrder == null ? [] : previousOrder.orders))
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) {
            return MaterialApp(
                title: 'My Shop',
                theme: ThemeData(
                    primarySwatch: Colors.purple,
                    accentColor: Colors.deepOrange,
                    fontFamily: 'Lato',
                    pageTransitionsTheme: PageTransitionsTheme(builders: {
                      TargetPlatform.android: CustomPageTransitionBuilder(),
                      TargetPlatform.iOS: CustomPageTransitionBuilder()
                    })),
                home: auth.isAuth
                    ? ProductsOverviewScreen()
                    : FutureBuilder(
                        future: auth.tryAutoLogin(),
                        builder: (ctx, resultSnapshot) =>
                            resultSnapshot.connectionState ==
                                    ConnectionState.waiting
                                ? SplashScreen()
                                : AuthScreen()),
                routes: {
                  ProductDetailScreen.pageRoute: (_) => ProductDetailScreen(),
                  CartScreen.routeName: (_) => CartScreen(),
                  OrdersScreen.routeName: (_) => OrdersScreen(),
                  UserProductsScreen.routeName: (_) => UserProductsScreen(),
                  EditProductScreen.routeName: (_) => EditProductScreen(),
                  ProductsOverviewScreen.routeName: (_) =>
                      ProductsOverviewScreen()
                });
          },
        ));
  }
}
