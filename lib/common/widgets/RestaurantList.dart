import 'package:flutter/material.dart';
import 'package:mesan_mobile/common/const/Const.dart';
import 'package:mesan_mobile/common/const/Types.dart';
import 'package:mesan_mobile/common/routes/Routers.dart';
import 'package:mesan_mobile/common/widgets/Container.dart';

class RestaurantList extends StatelessWidget {
  final List<Restaurant> restoList;
  RestaurantList({this.restoList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: restoList.length,
        itemBuilder: (BuildContext context, int index) {
          return restaurantListItem(context, restoList[index]);
        });
  }

  Widget restaurantListItem(BuildContext context, Restaurant resto) {
    String openTime = resto.openTime.substring(0, resto.openTime.length - 3);
    String closeTime = resto.closeTime.substring(0, resto.closeTime.length - 3);

    return GestureDetector(
      onTap: ()=> Navigator.of(context).pushNamed(bookingMenuList,arguments: ScreenArguments(restaurant: resto)),
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 140.0,
              padding: const EdgeInsets.symmetric(vertical: contentPadding),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Image.network(resto.storePhoto,
                        height: 100.0, width: 100.0, fit: BoxFit.cover),
                  ),
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                resto.storeName,
                                style: TextStyle(
                                    fontSize: 16.0, fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      margin: const EdgeInsets.only(right: 5.0),
                                        child: Icon(
                                      Icons.access_time,
                                      size: 14.0,
                                      color: Colors.grey,
                                    )),
                                    Text(
                                      openTime + " - " + closeTime,
                                      style:
                                          TextStyle(fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Text(resto.distance.toString().substring(0, 4) + " km")
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            ItemSeparator()
          ],
        ),
      ),
    );
  }
}
