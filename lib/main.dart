import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Providers/Homeprovider/HomeProvider.dart';
import 'Providers/Productdetailpageprovider/ProductDetailPageProvider.dart';
import 'Providers/loginprovider/LoginProvider.dart';
import 'SplashScreen/splashscreen.dart';


void main() => runApp(
    MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: LoginProvider()),
        ChangeNotifierProvider.value(value: HomeProvider()),
        ChangeNotifierProvider.value(value: ProductDetailPageProvider()),
      ],
      child: MaterialApp(
          title: 'ZUZU',
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        ),
    );
  }
}



