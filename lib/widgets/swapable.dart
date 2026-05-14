import 'package:fec_app2/screen_pages/notices.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

// ignore: must_be_immutable
class SwappableButton extends StatelessWidget {
  bool isFinished = false;
  SwappableButton({required this.isFinished, super.key});

  @override
  Widget build(BuildContext context) {
    return SwipeableButtonView(
      buttonText: 'SLIDE TO PAYMENT',
      buttonWidget: Container(
        decoration: const BoxDecoration(color: Colors.transparent),
        child: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.grey,
        ),
      ),
      activeColor: const Color(0xFF009C41),
      isFinished: isFinished,
      onWaitingProcess: () {
        Future.delayed(const Duration(seconds: 2), () {
          // setState(() { });
          isFinished = true;
        });
      },
      onFinish: () async {
        await Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade, child: const NoticesScreen()));

        // setState(() {  });
        isFinished = false;
      },
    );
  }
}
