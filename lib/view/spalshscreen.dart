import 'dart:async';

import 'package:covid_app/view/world_state.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({super.key});

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: Duration(seconds: 3), vsync: this)
        ..repeat();

        @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();

    Timer(
        Duration(seconds: 5),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => WorldState())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
                animation: _controller,
                child: Container(
                  height: 180,
                  //width: double.infinity,
                  child: Center(
                    child: Image(image: AssetImage('img/covids.png')),
                  ),
                ),
                builder: (BuildContext context, Widget? child) {
                  return Transform.rotate(
                      angle: _controller.value * 1.5 * math.pi, child: child);
                }),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Covid-19 \n Tracker App",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
