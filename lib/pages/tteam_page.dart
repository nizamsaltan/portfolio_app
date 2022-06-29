import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_app/responsive_layout.dart';
import 'package:portfolio_app/utils/colors.dart';
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
  return Stack(
    children: [
      _menuBars(),
      Column(
        children: [
          _homeScreen(context),
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
      ),
    ],
  );
}

Widget _menuBars() {
  return SizedBox(
    height: _height,
    width: _width,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _menuButton('Home', true, 0),
        _menuButton('Team', false, _height)
      ],
    ),
  );
}

Widget _menuButton(String name, bool isSelected, double position) {
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
            style: ttLowerTextStyle.copyWith(fontSize: 20),
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
}

Widget _homeScreen(BuildContext context) {
  return SizedBox(
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
  );
}

void _goNextPage(int index) {
  // index: 1, -1 (1: down, -1: up)
  final position = _scrollController.offset + (_height * index);
  _scrollController.animateTo(
    position,
    duration: const Duration(milliseconds: 700),
    curve: Curves.easeOut,
  );
}
