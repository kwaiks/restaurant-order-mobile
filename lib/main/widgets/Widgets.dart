import 'package:flutter/material.dart';
import 'package:mesan_mobile/common/const/Const.dart';
import 'package:mesan_mobile/common/const/Types.dart';
import 'package:mesan_mobile/common/routes/Routers.dart';
import 'package:mesan_mobile/common/widgets/Label.dart';

///Horizontal List Home
class RestaurantHorizontalList extends StatelessWidget {
  final List<Restaurant> list;

  ///define total Item
  final int itemCount = 5;

  RestaurantHorizontalList({this.list});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      child: new ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        itemBuilder: (BuildContext context, int index) {
          return horizontalItem(context, index, itemCount - 1, list[index]);
        },
      ),
    );
  }

  Widget horizontalItem(
      BuildContext context, int index, int itemTotal, Restaurant resto) {
    EdgeInsets getMargin() {
      if (index == 0) {
        return const EdgeInsets.only(
            left: 20.0, right: 10.0, top: 10.0, bottom: 10.0);
      } else if (index == itemTotal) {
        return const EdgeInsets.only(
            left: 10.0, right: 20.0, top: 10.0, bottom: 10.0);
      } else {
        return const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0);
      }
    }

    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(bookingMenuList,
          arguments: ScreenArguments(restaurant: resto)),
      child: new Container(
        width: 160.0,
        margin: getMargin(),
        padding: const EdgeInsets.all(10.0),
        decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: [
              new BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.2),
                  offset: Offset(0.0, 1.0),
                  blurRadius: 4.0)
            ]),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: new Image.network(resto.storePhoto,
                  height: 110.0, width: 140.0, fit: BoxFit.cover),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TitleLabel(label: resto.storeName, isHeader: false),
                    SubtitleLabel(
                        label:
                            '${resto.distance.toString().substring(0, 4)} km')
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//Label Widget
class ContentHeader extends StatelessWidget {
  final String text;
  final GestureTapCallback onTap;

  ContentHeader({this.text, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          bottom: contentPadding / 2,
          left: contentPadding,
          right: contentPadding),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(text,
              style: TextStyle(
                  color: Color(0xFF6F6F6F), fontWeight: FontWeight.w600)),
          GestureDetector(
              onTap: onTap,
              child:
                  Text('View All', style: TextStyle(color: Colors.redAccent)))
        ],
      ),
    );
  }
}
