import 'package:flutter/material.dart';
import 'package:mesan_mobile/common/DummyData.dart';
import 'package:mesan_mobile/common/api/CarouselAPI.dart';
import 'package:mesan_mobile/common/api/RestaurantAPI.dart';
import 'package:mesan_mobile/common/const/Const.dart';
import 'package:mesan_mobile/common/const/Types.dart';
import 'package:mesan_mobile/common/routes/Routers.dart';
import 'package:mesan_mobile/common/widgets/PromoCarousel.dart';
import 'package:mesan_mobile/common/widgets/Container.dart';
import 'package:mesan_mobile/common/widgets/Label.dart';
import 'package:mesan_mobile/main/widgets/Widgets.dart';

class HomeFragment extends StatefulWidget {
  @override
  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation _colorTween;
  List<Widget> categoryList = [];

  @override
  void initState() {
    buildCategoryList();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));
    _colorTween = ColorTween(end: Colors.white).animate(_animationController);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  //AppBar visibility
  bool _scrollListener(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.axis == Axis.vertical) {
      _animationController.animateTo(scrollInfo.metrics.pixels / 100);
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NotificationListener<ScrollNotification>(
        onNotification: _scrollListener,
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 40.0,
                ),
                Padding(
                    padding: const EdgeInsets.only(top: contentPadding),
                    child: FutureBuilder<List<Carousel>>(
                        future: fetchCarouselList(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<Carousel> carousels = snapshot.data;
                            return CarouselSliderWidget(
                                carouselList: carousels);
                          }
                          return Container();
                        })),
                ContentContainer(
                  child: Container(
                    height: 100,
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: categoryList,
                    ),
                  ),
                ),
                ContentContainer(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(
                            left: 20.0, bottom: 10.0, right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            TitleLabel(
                              label: 'NEAR YOU',
                            ),
                            Text('View All',
                                style: TextStyle(color: Colors.redAccent))
                          ],
                        ),
                      ),
                      new FutureBuilder<List<Restaurant>>(
                        future: fetchRestaurantByNearest(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<Restaurant> restoLists = snapshot.data;
                            return new RestaurantHorizontalList(
                                list: restoLists);
                          }
                          return Container();
                        },
                      )
                    ],
                  ),
                ),
                ContentContainer(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new ContentHeader(text: 'TOP PICKS', onTap: () {}),
                      new FutureBuilder<List<Restaurant>>(
                        future: fetchRestaurantTopPicks(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<Restaurant> restoList = snapshot.data;
                            return new RestaurantHorizontalList(
                                list: restoList);
                          }
                          return Container();
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                )
              ],
            )),
            new Positioned(
              //Place it at the top, and not use the entire screen
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) => AppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: _colorTween.value,
                    elevation: 0,
                    title: GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, searchByNameRoute),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        height: 40,
                        margin: EdgeInsets.all(10),
                        decoration: new BoxDecoration(
                            color: Color(0xFFf0f0f0),
                            borderRadius: BorderRadius.circular(8)),
                        child: new Row(
                          children: <Widget>[
                            Icon(
                              Icons.search,
                              color: Colors.black38,
                              size: 20,
                            ),
                            Text(
                              'Search',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black38),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void buildCategoryList() {
    categoryList = List<Widget>.generate(category.length, (val) {
      return new GestureDetector(
        onTap: () => Navigator.pushNamed(context, searchByCategoryRoute,
                      arguments: ScreenArguments(category: category[val]['cat'])),
        child: new Container(
          height: 120,
          width: 90,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: new BoxDecoration(
                        color: Color(0xFFE57373),
                        borderRadius: BorderRadius.circular(50)),
                    child: new Icon(
                      category[val]['icon'],
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                ),
              new Text(category[val]['cat'],
                  textAlign: TextAlign.center,
                  style: new TextStyle(fontWeight: FontWeight.w300))
            ],
          ),
        ),
      );
    });
  }
}
