import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:yatch_booking_flutter_app/model/yatch_model.dart';

class HomePageBody extends StatefulWidget {
  final YatchModel yatchModel;

  const HomePageBody(this.yatchModel, {super.key});
  @override
  _HomePageBodyState createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  @override
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget? child, YatchModel model) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xff1560bd),
            title: const Text(
              'Yatch',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      width: 180,
                      child: CarouselSlider(
                        items: List.generate(widget.yatchModel.allYatch.length,
                            ((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return GestureDetector(
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: _slideBox(
                                      widget.yatchModel.allYatch[i].image ?? '',
                                      widget.yatchModel.allYatch[i].price ?? '',
                                      widget.yatchModel.allYatch[i].name ?? ''),
                                ),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, 'detail/${i + 1}');
                                },
                              );
                            },
                          );
                        })).toList(),
                        options: CarouselOptions(
                          height: 370.0,
                          initialPage: 0,
                          reverse: false,
                          aspectRatio: 16 / 9,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _slideBox(String img, String rupee, String name) {
    return Container(
      margin: const EdgeInsets.only(right: 5, top: 10, bottom: 20),
      padding: const EdgeInsets.only(top: 20, left: 0, bottom: 20),
      width: 240,
      decoration: BoxDecoration(
          boxShadow: const <BoxShadow>[
            BoxShadow(
                color: Color(0xffd1d1e1), blurRadius: 10, offset: Offset(0, 10))
          ],
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xff1560bd)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(width: 20),
          Image.asset(
            img,
            height: 100,
            width: 200,
            alignment: FractionalOffset.centerLeft,
            fit: BoxFit.cover,
          ),
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            title: Text(
              name,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
            subtitle: const Text(
              'Yatch',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          Row(
            children: <Widget>[
              const Text('     \$',
                  style: TextStyle(color: Colors.white60, fontSize: 15)),
              Text(' $rupee',
                  style: const TextStyle(color: Colors.white, fontSize: 15)),
              const Text(' / Day',
                  style: TextStyle(color: Colors.white60, fontSize: 15)),
            ],
          )
        ],
      ),
    );
  }
}
