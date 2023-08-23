// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:yatch_booking_flutter_app/model/yatch.dart';
import 'package:yatch_booking_flutter_app/utils/submit_Button.dart';
import 'package:yatch_booking_flutter_app/utils/text_style.dart';

class Detail extends StatefulWidget {
  final Yatch? yatch;
  const Detail({super.key, this.yatch});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1560bd),
      body: _body(),
    );
  }

  Widget _body() {
    return Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 20, left: 20),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                child: const Icon(
                  IconData(0xeab5, fontFamily: 'icofont'),
                  color: Colors.white,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 50),
                  Text(
                    widget.yatch?.name ?? '',
                    style: headerTextStyle,
                  ),
                  const Text(
                    'Yatch',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                  const SizedBox(height: 50),
                  RichText(
                    text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(
                              text: '\$${widget.yatch?.price}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                decoration: TextDecoration.none,
                              )),
                          const TextSpan(
                              text: ' / day',
                              style: TextStyle(
                                color: Colors.white60,
                                fontSize: 10,
                                decoration: TextDecoration.none,
                              )),
                        ]),
                  ),
                  const SizedBox(height: 70),
                  _rotatedBox('Length', widget.yatch?.lenght ?? ''),
                  const SizedBox(height: 20),
                  _rotatedBox('Width', widget.yatch?.height ?? ''),
                  const SizedBox(height: 20),
                  _rotatedBox('Draft', widget.yatch?.draft ?? ''),
                ],
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    margin: const EdgeInsets.only(top: 50),
                    width: 180,
                    alignment: FractionalOffset.centerRight,
                    height: 520,
                    child: RotatedBox(
                      quarterTurns: 4,
                      child: Image.asset(
                        widget.yatch?.detailImage ?? '',
                        fit: BoxFit.contain,
                      ),
                    ),
                  )),
            ],
          ),
          const SizedBox(height: 50),
          SubmitButton(
            buttonText: 'Pay now',
            navigationString: 'checkout/${widget.yatch?.id}',
            navToBack: false,
          )
        ],
      ),
    );
  }

  Widget _rotatedBox(String text, String length) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white54),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RichText(
            text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                      text: length,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        decoration: TextDecoration.none,
                      )),
                  const TextSpan(
                      text: ' m',
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 15,
                        decoration: TextDecoration.none,
                      )),
                ]),
          ),
          Text(
            text,
            style: const TextStyle(color: Colors.white60, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
