import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:flutter_image_slider/carousel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:zazu/screens/ProductDetailPage/rectangle.dart';
import 'package:zazu/utils/Styles.dart';
import '../../Providers/providers.dart';
import '../../utils/colors.dart';
import '../Cart/Cart.dart';
import '../CommonWidgets/Button.dart';
import '../ProductViewImage/ProductViewImage.dart';

class ProductDetailPage extends StatelessWidget {
  ProductDetailPage({Key? key}) : super(key: key);

  BranchContentMetaData metadata = BranchContentMetaData();
  StreamController<String> controllerUrl = StreamController<String>();

  void generateLink(BranchUniversalObject buo, BranchLinkProperties lp,String title,BuildContext context) async {
    BranchResponse response =
    await FlutterBranchSdk.getShortUrl(buo: buo, linkProperties: lp);
    if (response.success) {
      print("PRODUCT GENERATED LINK : ${response.result}");
      controllerUrl.sink.add('${response.result}');
      final box = context.findRenderObject() as RenderBox;
      Share.share('${title}\n${response.result}', subject: 'Share Product',sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,);
    } else {
      controllerUrl.sink
          .add('Error : ${response.errorCode} - ${response.errorMessage}');
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: true,
        backgroundColor: AppColors.white,
        leading: const BackButton(
          color: Colors.black,
        ),
        title: Text(
          'Product Details',
          style: Styles().normalS(
            fontW: FontWeight.normal,
            fontS: 22,
            color: AppColors.black,
          ),
        ),
        actions: <Widget>[
          Row(
            children: [
      IconButton(
          onPressed: () {
    BranchLinkProperties lp = BranchLinkProperties(
    channel: 'facebook',
    feature: 'sharing',
    stage: 'new share',
    campaign: 'xxxxx',
    tags: ['one', 'two', 'three'],);
    BranchUniversalObject bo;
    bo = BranchUniversalObject(
    canonicalIdentifier: 'flutter/branch',
    canonicalUrl: 'https://nesto.shop/',
    title: 'LADIES GOWN',
    imageUrl:
    'assets/images/img_2.png',
    contentDescription:'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled iining essentially unchanged. ',
    contentMetadata: BranchContentMetaData(),
    // ..addCustomMetadata("item", "123"),
    keywords: ['Plugin', 'Branch', 'Flutter'],
    publiclyIndex: true,
    locallyIndex: true,
    expirationDateInMilliSec: DateTime.now()
        .add(const Duration(days: 1000))
        .millisecondsSinceEpoch,);
    lp.addControlParam('\$uri_redirect_mode', '1');
    return generateLink(bo, lp,'LADIES GOWN',context);
    },
        icon: const Icon(
          Icons.share,
          color: Colors.black,
          size: 23,
        ),
      ),

              IconButton(
                icon: const Icon(
                  Icons.shopping_cart,
                  color: AppColors.black,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Cart()),
                  );
                },
              ),




            ],
          )
        ],
      ),
      body: Consumer(
        builder: (_, ref, __) {
          final data = ref.watch(productDetailesProvider);
          return SizedBox(
            width: w,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductViewimage(),
                        ),
                      );
                    },
                    child: SizedBox(
                      width: w,
                      child: Carousel(
                        height: w + 100,
                        indicatorBarColor: Colors.white,
                        autoScrollDuration: const Duration(seconds: 2),
                        animationPageDuration:
                            const Duration(milliseconds: 500),
                        activateIndicatorColor: Colors.pink.shade100,
                        animationPageCurve: Curves.bounceInOut,
                        indicatorBarHeight: 50,
                        indicatorHeight: 10,
                        indicatorWidth: 10,
                        unActivatedIndicatorColor: Colors.grey.shade100,
                        stopAtEnd: true,
                        autoScroll: true,
                        // widgets
                        items: [
                          SizedBox(
                            width: w,
                            child: Image.asset(
                              'assets/images/img_2.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: w,
                            child: Image.asset(
                              'assets/images/img_2.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: w,
                            child: Image.asset(
                              'assets/images/img_2.png',
                              fit: BoxFit.cover,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: w,
                    margin: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LADIES GOWN',
                          style: Styles().normalS(
                            fontW: FontWeight.w600,
                            fontS: 20,
                            color: AppColors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'RS :',
                              style: Styles().normalS(
                                fontW: FontWeight.normal,
                                fontS: 17,
                                color: AppColors.black,
                              ),
                            ),
                            Text(
                              ' 899',
                              style: Styles().normalS(
                                fontW: FontWeight.w500,
                                fontS: 20,
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text(
                              'AVAILABLE IN :',
                              style: Styles().normalS(
                                fontW: FontWeight.normal,
                                fontS: 17,
                                color: AppColors.black,
                              ),
                            ),
                            Text(
                              ' S,M,L,XL',
                              style: Styles().normalS(
                                fontW: FontWeight.w600,
                                fontS: 20,
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text(
                              'AVAILABLE IN :   ',
                              style: Styles().normalS(
                                fontW: FontWeight.normal,
                                fontS: 17,
                                color: AppColors.black,
                              ),
                            ),
                            Rectangles().rectangles(clr: Colors.red),
                            const SizedBox(
                              width: 25,
                            ),
                            Rectangles().rectangles(clr: Colors.indigo),
                            const SizedBox(
                              width: 25,
                            ),
                            Rectangles().rectangles(clr: Colors.purple),
                            const SizedBox(
                              width: 25,
                            ),
                            Rectangles().rectangles(clr: Colors.green),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              'SET COUNT :',
                              style: Styles().normalS(
                                fontW: FontWeight.normal,
                                fontS: 17,
                                color: AppColors.black,
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 5.0,
                                      ),
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          color: Colors.black,
                                          onPressed: () {
                                            data.decrementquantity();
                                          },
                                          icon: const Icon(Icons.remove),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${data.quantity}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 5.0,
                                      ),
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          color: Colors.black,
                                          onPressed: data.incrementquantity,
                                          icon: const Icon(Icons.add),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              'MATERIAL :',
                              style: Styles().normalS(
                                fontW: FontWeight.normal,
                                fontS: 17,
                                color: AppColors.black,
                              ),
                            ),
                            Text(
                              ' SAMPLE',
                              style: Styles().normalS(
                                fontW: FontWeight.w500,
                                fontS: 20,
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Description:',
                          style: Styles().normalS(
                            fontW: FontWeight.normal,
                            fontS: 18,
                            color: AppColors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled iining essentially unchanged. ',
                          style: Styles().normalS(
                            fontW: FontWeight.normal,
                            fontS: 16,
                            color: AppColors.black,
                          ),
                          textDirection: TextDirection.ltr,
                          maxLines: 4,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: w,
                          child: Button().button(
                            action: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Cart(),
                                ),
                              );
                            },
                            txt: 'ADD TO CART',
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
