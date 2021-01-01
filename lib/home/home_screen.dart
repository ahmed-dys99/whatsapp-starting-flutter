import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:whatsapp/home/home_tabs.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _scrollViewController;
  bool _showAppbar = true;
  bool isScrollingDown = false;

  @override
  void initState() {
    super.initState();
    _scrollViewController = ScrollController();
    _scrollViewController.addListener(() {
      if (_scrollViewController.position.userScrollDirection == ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          setState(() {
            _showAppbar = false;
          });
        }
      }
      if (_scrollViewController.position.userScrollDirection == ScrollDirection.forward) {
        if (isScrollingDown) {
          isScrollingDown = false;
          setState(() {
            _showAppbar = true;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    _scrollViewController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            AnimatedContainer(
              height: _showAppbar ? 76 : 0,
              duration: Duration(milliseconds: 100),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                  bottom: 10.0,
                ),
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Image.asset('assets/logo.png', width: _showAppbar ? 35 : 0, height: _showAppbar ? 35 : 0),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      'Whatsapp',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontFamily: 'Objectivity',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  titleSpacing: 1,
                  actions: [
                    SizedBox(
                      width: 42,
                      child: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(
                      width: 40,
                      child: IconButton(
                        icon: Icon(Icons.message),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(
                      width: 40,
                      child: IconButton(
                        icon: Icon(Icons.more_vert),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
