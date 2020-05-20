import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mesan_mobile/common/const/Types.dart';

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }
  return result;
}

class CarouselSliderWidget extends StatefulWidget {
  final List<Carousel> carouselList;
  final double height;
  final bool enlargeCenterImage;
  CarouselSliderWidget({this.carouselList, this.height = 120.0, this.enlargeCenterImage = false});
  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<CarouselSliderWidget> {
  int _carouselIndex = 0; //Carousel Position
  List<Widget> carouselItems = [];

  @override
  void initState() {
    buildSlider();
    super.initState();
  }

  buildSlider() {
    carouselItems = List<Widget>.generate(widget.carouselList.length, (i) {
      return carouselItem(
          widget.carouselList[i].desc, widget.carouselList[i].link);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CarouselSlider(
            enlargeCenterPage: widget.enlargeCenterImage,
            height: widget.height,
            autoPlay: true,
            pauseAutoPlayOnTouch: Duration(seconds: 3),
            onPageChanged: (index) {
              setState(() {
                _carouselIndex = index;
              });
            },
            items: carouselItems),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
                children: map<Widget>(
                 widget.carouselList,
              (index, any) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _carouselIndex == index
                          ? Color.fromRGBO(229, 57, 53, 0.9)
                          : Color.fromRGBO(0, 0, 0, 0.2)),
                );
              },
            )),
          ),
      ],
    );
  }

  /// Carousel Item
  Widget carouselItem(String desc, String link) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(children: <Widget>[
          Image.asset(link, fit: BoxFit.cover, width: double.infinity),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(200, 0, 0, 0),
                    Color.fromARGB(0, 0, 0, 0)
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                desc,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  /// Carousel Pointer
  Widget carouselPointerItem(index) {
    return Container(
      width: _carouselIndex == index ? 10.0 : 3.0,
      height: _carouselIndex == index ? 2.0 : 1.0,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 1.0),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: _carouselIndex == index
              ? Color.fromRGBO(0, 0, 0, 0.9)
              : Color.fromRGBO(0, 0, 0, 0.4)),
    );
  }

}
