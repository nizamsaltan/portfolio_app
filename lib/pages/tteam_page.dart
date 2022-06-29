// ignore_for_file: constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_app/responsive_layout.dart';
import 'package:portfolio_app/utils/button_animations.dart';
import 'package:portfolio_app/utils/colors.dart';
import 'package:portfolio_app/utils/long_texts.dart';
import 'package:portfolio_app/utils/text_styles.dart';
import 'package:rive/rive.dart';

class TTeamPage extends StatefulWidget {
  const TTeamPage({Key? key}) : super(key: key);

  @override
  State<TTeamPage> createState() => _TTeamPageState();
}

late ScrollController _scrollController;
late double _width;
late double _height;

class _TTeamPageState extends State<TTeamPage> {
  @override
  void initState() {
    // initialize scroll controllers
    _scrollController = ScrollController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _height = MediaQuery.of(context).size.height;
    if (_width < 710) {
      currentDevice = DeviceTypes.mobile;
    } else if (_width < 1200) {
      currentDevice = DeviceTypes.tablet;
    } else {
      currentDevice = DeviceTypes.desktop;
    }
    return Scaffold(
      backgroundColor: tteamBackgroundColor,
      body: SingleChildScrollView(
        physics: currentDevice == DeviceTypes.desktop
            ? const NeverScrollableScrollPhysics()
            : null,
        controller: _scrollController,
        child: Listener(
          onPointerSignal: (PointerSignalEvent event) {
            if (event is PointerScrollEvent) {
              //print(event.scrollDelta.dy.toInt().clamp(-1, 1));
              _goNextPage(event.scrollDelta.dy.toInt().clamp(-1, 1));
            }
          },
          child: ResponsiveLayout(
            desktopPage: _tteamMain(context),
            tabletPage: _tteamMain(context),
            mobilePage: _tteamMain(context),
          ),
        ),
      ),
    );
  }
}

Widget _tteamMain(BuildContext context) {
  return Column(
    children: [
      _homeScreen(context),
      _aboutTeamScreen(context),
      _mapScreen(context),
      _motivationScreen(context),
      Container(
        color: Colors.black,
        height: _height,
      ),
      Container(
        color: tteamBackgroundColor,
        height: _height,
      ),
      Container(
        color: Colors.red,
        height: _height,
      ),
      Container(
        color: Colors.blue,
        height: _height,
      ),
    ],
  );
}

enum Pages {
  Home,
  Team,
  Project,
}

Widget _menuBars(Pages page) {
  return SizedBox(
    height: _height,
    width: _width,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _menuButton('Home', page == Pages.Home, 0),
        _menuButton('Team', page == Pages.Team, _height),
        _menuButton('Project', page == Pages.Project, _height * 3),
      ],
    ),
  );
}

Widget _menuButton(String name, bool isSelected, double position) {
  _currentScrollPosition = position;
  return OnHoverButton(
    builder: ((isHovered) {
      Color color =
          isHovered ? const Color.fromARGB(255, 219, 219, 219) : Colors.white;
      return CupertinoButton(
        onPressed: () {
          _scrollController.animateTo(
            position,
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeOut,
          );
        },
        child: SizedBox(
          width: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                name,
                style: ttLowerTextStyle.copyWith(fontSize: 20, color: color),
              ),
              const SizedBox(width: 8),
              Icon(Icons.circle,
                  size: 12,
                  color: isSelected ? ttHeaderTextStyle.color : Colors.white),
              const SizedBox(width: 10),
            ],
          ),
        ),
      );
    }),
    transfrom: Matrix4.identity()..translate(-5, 0, 0),
  );
}

Widget _pageIndicator(String header, double textWidth) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(100, 50, 0, 0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset('assets/images/tteam_logo.png', height: 40),
        const SizedBox(height: 30),
        Text(header, style: ttHeaderTextStyle.copyWith(fontSize: 42)),
        SizedBox(
            width: textWidth,
            child: Divider(
              thickness: 4,
              color: ttHeaderTextStyle.color,
            )),
      ],
    ),
  );
}

Widget _homeScreen(BuildContext context) {
  return Stack(
    children: [
      _menuBars(Pages.Home),
      SizedBox(
        height: _height,
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 700,
                width: 700,
                child: RiveAnimation.asset('assets/riv/moving_cube.riv',
                    animations: ["main"]),
              ),
              Row(
                children: [
                  SizedBox(width: _width / 2 - 600),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: _height / 2 - 225),
                        Text(
                          'Welcome',
                          style: ttHeaderTextStyle.copyWith(fontSize: 100),
                        ),
                        SizedBox(
                          width: 450,
                          child: Divider(
                            thickness: 4,
                            color: ttHeaderTextStyle.color,
                          ),
                        ),
                        Text(
                          'we were waiting for you too',
                          style: lowerTextStyle.copyWith(fontSize: 25),
                        ),
                        const SizedBox(height: 200),
                        Container(
                          height: 60,
                          width: 200,
                          color: ttHeaderTextStyle.color,
                          child: CupertinoButton(
                              padding: EdgeInsets.zero,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 7),
                                    Text('Find Out More',
                                        style: lowerTextStyle.copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18)),
                                    const SizedBox(
                                        width: 110,
                                        child: Divider(
                                            thickness: 2, color: Colors.black)),
                                  ]),
                              onPressed: () => _goNextPage(1)),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ]),
      ),
    ],
  );
}

Widget _aboutTeamScreen(BuildContext context) {
  return Stack(
    children: [
      _menuBars(Pages.Team),
      SizedBox(
        height: _height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/tteam_logo.png',
              height: 64,
              width: 64,
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Who ',
                  style: ttSecondaryHeaderTextStyle,
                ),
                Text(
                  'We',
                  style: ttSecondaryHeaderTextStyle.copyWith(
                      color: ttHeaderTextStyle.color),
                ),
                Text(
                  ' Are',
                  style: ttSecondaryHeaderTextStyle,
                ),
              ],
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: 700,
                child: Text(
                  ttTeamAboutTheme,
                  style: ttStandardTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    ],
  );
}

Widget _mapScreen(BuildContext context) {
  return SizedBox(
    height: _height,
    child: Stack(
      children: [
        _menuBars(Pages.Team),
        _pageIndicator('Map', 90),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/tteam_map.jpg',
                width: _width / 1.3,
              )
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _motivationScreen(BuildContext context) {
  return SizedBox(
    height: _height,
    child: Stack(
      children: [
        _menuBars(Pages.Team),
        Image.asset(
          'assets/images/tteam_motivation_bg.jpg',
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Column(
          children: [
            const SizedBox(height: 50),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Success',
                          style: ttSecondaryHeaderTextStyle.copyWith(
                              fontSize: 40, letterSpacing: 1.2),
                        ),
                        SizedBox(
                            width: 180,
                            child: Divider(
                                indent: 0,
                                endIndent: 0,
                                height: 0,
                                thickness: 4,
                                color: ttHeaderTextStyle.color)),
                      ],
                    ),
                    Text(
                      ' happens to those',
                      style: ttSecondaryHeaderTextStyle.copyWith(
                          fontSize: 40, letterSpacing: 1.2),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text('who work for it.',
                    style: ttSecondaryHeaderTextStyle.copyWith(
                        fontSize: 40, letterSpacing: 1.2)),
              ],
            )
          ],
        )
      ],
    ),
  );
}

double _currentScrollPosition = 0;
void _goNextPage(int index) {
  // index: 1, -1 (1: down, -1: up)
  _currentScrollPosition += (_height * index);
  _scrollController.animateTo(
    _currentScrollPosition,
    duration: const Duration(milliseconds: 700),
    curve: Curves.easeOut,
  );
}
