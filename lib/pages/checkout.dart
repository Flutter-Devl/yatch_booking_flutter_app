// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:yatch_booking_flutter_app/model/yatch.dart';
import 'package:yatch_booking_flutter_app/utils/submit_Button.dart';

class Checkout extends StatefulWidget {
  final Yatch? model;
  String price = "";
  Checkout({super.key, this.model});

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> with TickerProviderStateMixin {
  int no = 1;
  bool masterCardEnable = true;
  bool visaEnable = false;
  late AnimationController _controllerMasterCard;
  late AnimationController _controllerVisaCard;
  late Animation<double> _animationMasterCard;
  late Animation<double> _animationVisaCard;

  @override
  void initState() {
    widget.price = widget.model?.price ?? '';
    _controllerMasterCard = _createAnimationController();
    _controllerVisaCard = _createAnimationController();
    _animationMasterCard = _controllerMasterCard.drive(
        Tween<double>(begin: .8, end: 1)
            .chain(CurveTween(curve: Curves.easeIn)));
    _animationVisaCard = _controllerVisaCard.drive(
        Tween<double>(begin: .8, end: 1)
            .chain(CurveTween(curve: Curves.easeIn)));
    super.initState();
  }

  AnimationController _createAnimationController() {
    return AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1560bd),
        title: const Text(
          'Checkout',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 30),
          _buildQuantitySection(),
          const SizedBox(height: 90),
          _middleSection(),
          const SizedBox(height: 60),
          const SubmitButton(
              buttonText: 'Return', navToBack: true, navigationString: ''),
        ],
      ),
    );
  }

  Widget _buildQuantitySection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildQuantityColumn(),
        Container(height: 60, width: 2, color: Colors.grey),
        _buildTotalColumn(),
      ],
    );
  }

  Widget _buildQuantityColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Days',
          style: TextStyle(fontSize: 12),
        ),
        const SizedBox(height: 10),
        _buildQuantityControl(),
      ],
    );
  }

  Widget _buildQuantityControl() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 36,
      width: 110,
      decoration: BoxDecoration(
        color: const Color(0xff1a5ddd),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildQuantityButton("-", () {
            setState(() {
              if (no > 1) {
                --no;
                int i = int.tryParse(widget.model?.price ?? '')! * no;
                widget.price = i.toString();
              }
            });
          }),
          Text(
            no.toString(),
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          _buildQuantityButton("+", () {
            setState(() {
              no = no + 1;
              int i = int.tryParse(widget.model?.price ?? '')! * no;
              widget.price = i.toString();
            });
          }),
        ],
      ),
    );
  }

  Widget _buildQuantityButton(String label, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 26,
        width: 26,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildTotalColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Total',
          style: TextStyle(fontSize: 12),
        ),
        const SizedBox(height: 10),
        Container(
          alignment: FractionalOffset.centerLeft,
          width: 100,
          child: Text(
            '\$${widget.price}',
            style: const TextStyle(fontSize: 20),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _middleSection() {
    return Column(
      children: <Widget>[
        const Text(
          'Payment Cards',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        Row(
          children: <Widget>[
            ScaleTransition(
              scale: _animationMasterCard,
              alignment: Alignment.center,
              child: _buildPaymentCardContainer(
                '**** 2019',
                '\$${widget.price}',
                'Platinum',
                'assets/image/masterCardLogo.png',
                masterCardEnable,
                () {
                  setState(() {
                    masterCardEnable = true;
                    visaEnable = false;
                    _controllerMasterCard.forward();
                    _controllerVisaCard.reverse();
                  });
                },
              ),
            ),
            const SizedBox(width: 20),
            ScaleTransition(
              scale: _animationVisaCard,
              child: _buildPaymentCardContainer(
                '**** 3456',
                '\$${widget.price}',
                'Platinum',
                'assets/image/visaCardLogo.png',
                visaEnable,
                () {
                  setState(() {
                    visaEnable = true;
                    masterCardEnable = false;
                    _controllerMasterCard.reverse();
                    _controllerVisaCard.forward();
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPaymentCardContainer(
    String cardNumber,
    String totalAmount,
    String cardType,
    String cardImage,
    bool isEnabled,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 260,
        width: MediaQuery.of(context).size.width / 2 - 28,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(vertical: 30),
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color:
                  isEnabled ? const Color(0xffd1d1e1) : const Color(0xFFFFFFFF),
              blurRadius: 10,
              offset: const Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(20),
          color: isEnabled ? const Color(0xff1a5ddd) : const Color(0xfff5f3fb),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              cardNumber,
              style: TextStyle(
                color: isEnabled ? Colors.white : Colors.black,
                fontSize: 18,
              ),
            ),
            Text(
              totalAmount,
              style: TextStyle(
                color: isEnabled ? Colors.white : Colors.black,
                fontSize: 24,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  cardType,
                  style: TextStyle(
                    color: isEnabled ? Colors.white54 : Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Image.asset(cardImage, height: isEnabled ? 20 : 15),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  dispose() {
    _controllerMasterCard.dispose();
    super.dispose();
  }
}
