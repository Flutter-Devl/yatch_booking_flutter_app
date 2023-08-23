import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String buttonText;
  final String navigationString;
  final bool navToBack;
  const SubmitButton(
      {super.key,
      required this.buttonText,
      required this.navigationString,
      required this.navToBack});
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "hero",
      child: GestureDetector(
        child: Container(
          padding:
              const EdgeInsets.only(left: 20, top: 10, right: 10, bottom: 10),
          margin:
              const EdgeInsets.only(left: 0, top: 10, right: 10, bottom: 10),
          height: 60,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xff002244)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                buttonText,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none),
              ),
              Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  child: Icon(
                    navToBack
                        ? const IconData(0xeab5, fontFamily: 'icofont')
                        : const IconData(0xeaa0, fontFamily: 'icofont'),
                    color: Colors.black,
                  ))
            ],
          ),
        ),
        onTap: () {
          {
            if (navToBack) {
              Navigator.pop(context);
            } else if (navigationString.isNotEmpty) {
              Navigator.pushNamed(context, navigationString);
            }
          }
        },
      ),
    );
  }
}
