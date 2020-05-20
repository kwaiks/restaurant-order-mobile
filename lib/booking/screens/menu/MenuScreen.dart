import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mesan_mobile/common/api/CarouselAPI.dart';
import 'package:mesan_mobile/common/const/Const.dart';
import 'package:mesan_mobile/common/const/Types.dart';
import 'package:mesan_mobile/common/widgets/ClickableIcon.dart';
import 'package:mesan_mobile/common/widgets/Container.dart';
import 'package:mesan_mobile/common/widgets/PromoCarousel.dart';

class BookingMenuListScreen extends StatefulWidget {
  final Restaurant resto;
  BookingMenuListScreen({this.resto});
  @override
  _BookingMenuListScreenState createState() => _BookingMenuListScreenState();
}

class _BookingMenuListScreenState extends State<BookingMenuListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
                  child: Stack(
      children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 200,
                child: Stack(
                  children: <Widget>[
                    Image.network(
                      widget.resto.storePhoto,
                      height: 200.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          margin: const EdgeInsets.all(contentPadding),
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(97, 97, 97, 0.6),
                              borderRadius: BorderRadius.circular(4.0)),
                          child: Text('Show Gallery',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12.0)),
                        ))
                  ],
                ),
              ),
              ContentContainer(
                  horizontalPadding: true,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                flex: 4,
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      widget.resto.storeName,
                                      style: TextStyle(
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(top: 10.0),
                                        child: Text(widget.resto.storeAddress,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w300))),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Icon(
                                            Icons.access_time,
                                            size: 12.0,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5.0),
                                            child: Text(widget.resto.openTime
                                                    .substring(0, 5) +
                                                ' - ' +
                                                widget.resto.closeTime
                                                    .substring(0, 5), style: TextStyle(fontWeight: FontWeight.w300)),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                  flex: 1, child: 
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        ClickableIcon(
                                          icon: MdiIcons.mapMarker,
                                          size: 16,
                                          onTap: ()=>print('aw')
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left:8.0),
                                          child: ClickableIcon(
                                            icon: MdiIcons.share, 
                                            size: 16,
                                            onTap: ()=>print('aw')
                                          ),
                                        )
                                      ],
                                    )
                                  )
                                )
                            ])
                      ])),
                      ContentContainer(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text('Promotions And Events', style:TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                            ),
                            Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: FutureBuilder<List<Carousel>>(
                          future: fetchCarouselList(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<Carousel> carousels = snapshot.data;
                              return CarouselSliderWidget(
                                  carouselList: carousels,
                                  height: 200.0,
                                  enlargeCenterImage: true,);
                            }
                            return Container();
                          })),
                          ]
                        )
                      ),
                      ContentContainer(
                        horizontalPadding: true,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Promo Menu', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold))
                          ],
                        ),
                      )
            ],
          ),
          Container()
      ],
    ),
        ));
  }
}
