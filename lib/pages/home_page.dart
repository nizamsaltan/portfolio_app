import 'dart:developer';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_app/responsive_layout.dart';
import 'package:portfolio_app/utils/button_animations.dart';
import 'package:portfolio_app/utils/long_texts.dart';
import 'package:portfolio_app/utils/text_styles.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

late ScrollController _scrollController;

double spancing = 75;

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // initialize scroll controllers
    _scrollController = ScrollController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width < 710) {
      currentDevice = DeviceTypes.mobile;
    } else if (width < 1200) {
      currentDevice = DeviceTypes.tablet;
    } else {
      currentDevice = DeviceTypes.desktop;
    }
    return Scaffold(
      body: WebSmoothScroll(
        controller: _scrollController,
        scrollOffset: 50,
        animationDuration: 300,
        curve: Curves.decelerate,
        child: SingleChildScrollView(
            physics: currentDevice == DeviceTypes.desktop
                ? const NeverScrollableScrollPhysics()
                : null,
            controller: _scrollController,
            child: ResponsiveLayout(
              desktopPage: homeDesktopPage(context),
              tabletPage: homeTabletPage(context),
              mobilePage: homeMobilePage(context),
            )),
      ),
    );
  }
}

// *** PAGES ***

Widget homeDesktopPage(BuildContext context) {
  return Stack(
    children: [
      Image(
        image: const AssetImage("assets/images/home_page_bg.jpg"),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      topBar(context),
      helloScreen(context),
      scrollDownToSeeMore(context),
      Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height),
          SizedBox(height: spancing),
          aboutScreen(context),
          SizedBox(height: spancing),
          mySkillsScreen(context),
          SizedBox(height: spancing),
          contactScreen(context),
          SizedBox(height: spancing),
          bottomPanel(),
        ],
      ),
    ],
  );
}

Widget homeTabletPage(BuildContext context) {
  return Stack(
    children: [
      Image(
        image: const AssetImage("assets/images/home_page_bg.jpg"),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      topBar(context),
      helloScreen(context),
      scrollDownToSeeMore(context),
      Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height),
          SizedBox(height: spancing),
          aboutScreen(context),
          SizedBox(height: spancing),
          mySkillsScreen(context),
          SizedBox(height: spancing),
          contactScreen(context),
          SizedBox(height: spancing),
          bottomPanel(),
        ],
      ),
    ],
  );
}

Widget homeMobilePage(BuildContext context) {
  return Stack(
    children: [
      Image(
        image: const AssetImage("assets/images/home_page_bg.jpg"),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      topBar(context),
      helloScreen(context),
      scrollDownToSeeMore(context),
      Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height),
          SizedBox(height: spancing),
          aboutScreen(context),
          SizedBox(height: spancing),
          mySkillsScreen(context),
          SizedBox(height: spancing),
          contactScreen(context),
          SizedBox(height: spancing),
          bottomPanel(),
        ],
      ),
    ],
  );
}

// ***** WIGDETS *****

Widget topBar(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      topBarButton('Home', () {
        final position = _scrollController.position.minScrollExtent;
        _scrollController.animateTo(
          position,
          duration: const Duration(seconds: 1),
          curve: Curves.easeOut,
        );
      }),
      topBarButton('Blog', () {
        _openMediumProfile();
      }),
      topBarButton('About', () {
        double position = MediaQuery.of(context).size.height;
        _scrollController.animateTo(
          position,
          duration: const Duration(seconds: 1),
          curve: Curves.easeOut,
        );
      }),
      topBarButton('Contact', () {
        double position = MediaQuery.of(context).size.height + 1480;
        _scrollController.animateTo(
          position,
          duration: const Duration(seconds: 1),
          curve: Curves.easeOut,
        );
      }),
    ]),
  );
}

Widget topBarButton(String text, Function? onPressed) {
  return OnHoverButton(
    builder: ((isHovered) {
      Color color =
          isHovered ? const Color.fromARGB(255, 219, 219, 219) : Colors.white;
      return CupertinoButton(
        onPressed: () {
          onPressed!();
        },
        child: Text(text,
            style: currentDevice == DeviceTypes.mobile
                ? standardTextStyle.copyWith(color: color, fontSize: 20)
                : lowerTextStyle.copyWith(color: color, fontSize: 20)),
      );
    }),
    transfrom: Matrix4.identity()
      ..scale(1.05)
      ..translate(0, 2, 0),
  );
}

Widget helloScreen(BuildContext context) {
  return Column(children: [
    SizedBox(height: (MediaQuery.of(context).size.height / 2) - 100),
    Text('Hello;',
        style: standardTextStyle.copyWith(
            fontSize: 100, fontWeight: FontWeight.w600)),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('I\'m Nizam Saltan, ',
            style: lowerTextStyle.copyWith(fontSize: 18)),
        AnimatedTextKit(
          repeatForever: true,
          animatedTexts: [
            TypewriterAnimatedText(
              'App Developer',
              speed: const Duration(milliseconds: 100),
              textStyle: lowerTextStyle.copyWith(fontSize: 18),
            ),
            TypewriterAnimatedText(
              'Game Developer',
              speed: const Duration(milliseconds: 100),
              textStyle: lowerTextStyle.copyWith(fontSize: 18),
            ),
            TypewriterAnimatedText(
              'Web Developer',
              speed: const Duration(milliseconds: 100),
              textStyle: lowerTextStyle.copyWith(fontSize: 18),
            )
          ],
        ),
      ],
    ),
  ]);
}

Widget scrollDownToSeeMore(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height - 100),
          Text('Scroll Down To See More',
              style: standardTextStyle.copyWith(fontSize: 16)),
          const SizedBox(height: 10),
          Icon(CupertinoIcons.down_arrow, color: standardTextStyle.color),
        ],
      ),
    ],
  );
}

Widget aboutScreen(BuildContext context) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
          width: 1600,
          child: Row(
            children: [
              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Who am I',
                        style: headerTextStyle.copyWith(
                            color: Colors.black, fontSize: 40)),
                    const SizedBox(height: 35),
                    SizedBox(
                        width: 800,
                        child: Text(aboutStr,
                            style: lowerTextStyle.copyWith(
                                color: Colors.black, fontSize: 20))),
                    SizedBox(height: spancing),
                    Text('What I Do',
                        style: headerTextStyle.copyWith(
                            color: Colors.black, fontSize: 40)),
                    const SizedBox(height: 35),
                    skillTree(const Icon(CupertinoIcons.gamecontroller_fill),
                        'Game Development', gameDevelopmentStr, 23, context),
                    const SizedBox(height: 25),
                    skillTree(const Icon(CupertinoIcons.device_phone_portrait),
                        'App Development', appDevelopmentStr, 41, context),
                    const SizedBox(height: 25),
                    skillTree(const Icon(Icons.web_rounded), 'Web Development',
                        webDevelopmentStr, 38, context),
                    const SizedBox(height: 50),
                    CupertinoButton(
                        padding: const EdgeInsets.all(0.0),
                        child: Text('Let\'s make something special.',
                            style: standardTextStyle.copyWith(
                                color: const Color.fromARGB(255, 67, 122, 68),
                                fontSize: 20)),
                        onPressed: () {
                          double position =
                              MediaQuery.of(context).size.height + 1480;
                          _scrollController.animateTo(
                            position,
                            duration: const Duration(seconds: 1),
                            curve: Curves.easeOut,
                          );
                        })
                  ],
                ),
              ),
              if (currentDevice == DeviceTypes.desktop)
                Expanded(
                    flex: 3,
                    child:
                        Image.asset('assets/images/about_bg.png', height: 450)),
            ],
          )),
    ),
  );
}

Widget skillTree(Icon icon, String text, String description, double distance,
    BuildContext context) {
  if (currentDevice == DeviceTypes.mobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            icon,
            const SizedBox(width: 10),
            Text(text,
                style: standardTextStyle.copyWith(
                    color: Colors.black, fontSize: 24)),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            const SizedBox(width: 10),
            const Icon(CupertinoIcons.arrow_turn_down_right),
            const SizedBox(width: 5),
            SizedBox(
              width: MediaQuery.of(context).size.width - 80,
              child: Text(description,
                  style: lowerTextStyle.copyWith(
                      color: Colors.black, fontSize: 18)),
            ),
          ],
        )
      ],
    );
  } else {
    return OnHoverButton(
      builder: ((isHovered) {
        return SizedBox(
          width: 700,
          child: Row(
            children: [
              icon,
              const SizedBox(width: 10),
              Text(text,
                  style: standardTextStyle.copyWith(
                      color: Colors.black, fontSize: 24)),
              SizedBox(width: distance),
              Text(description,
                  style: lowerTextStyle.copyWith(
                      color: Colors.black, fontSize: 18))
            ],
          ),
        );
      }),
      transfrom: Matrix4.identity()..translate(0, -7, 0),
    );
  }
}

Widget mySkillsScreen(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: SizedBox(
      width: 1600,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('My Skills',
                style: headerTextStyle.copyWith(
                    color: Colors.black, fontSize: 40)),
            const SizedBox(height: 35),
            Row(
              children: [
                if (currentDevice != DeviceTypes.mobile)
                  const Icon(CupertinoIcons.dot_square),
                const SizedBox(width: 10),
                SizedBox(
                  width: currentDevice == DeviceTypes.mobile
                      ? MediaQuery.of(context).size.width - 50
                      : 630,
                  child: Text(myFirstSkill,
                      style: lowerTextStyle.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                if (currentDevice != DeviceTypes.mobile)
                  const Icon(CupertinoIcons.dot_square),
                const SizedBox(width: 10),
                SizedBox(
                  width: currentDevice == DeviceTypes.mobile
                      ? MediaQuery.of(context).size.width - 50
                      : 630,
                  child: Text(mySecondSkill,
                      style: lowerTextStyle.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 40),
            skillSlider('Unity', 0.95, Colors.greenAccent, context),
            const SizedBox(height: 40),
            skillSlider('Flutter', 0.7, Colors.blueAccent, context),
            const SizedBox(height: 40),
            skillSlider('Unreal Engine', 0.4, Colors.purpleAccent, context),
          ]),
    ),
  );
}

Widget skillSlider(
    String name, double value, Color sliderColor, BuildContext context) {
  return OnHoverButton(
    builder: ((isHovered) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(name, style: standardTextStyle.copyWith(color: Colors.black)),
        const SizedBox(height: 10),
        NonInteracliableSlider(
          value: value,
          sliderColor: sliderColor,
          width: currentDevice == DeviceTypes.mobile
              ? MediaQuery.of(context).size.width - 40
              : 500,
        )
      ]);
    }),
    transfrom: Matrix4.identity()
      ..scale(1.1)
      ..translate(0, -4, 0),
  );
}

Widget contactScreen(BuildContext context) {
  double inputFieldWidth = currentDevice == DeviceTypes.mobile
      ? MediaQuery.of(context).size.width - 40
      : 610;
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: SizedBox(
      width: 1600,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Contact With Me',
                style: headerTextStyle.copyWith(color: Colors.black),
              ),
              const SizedBox(height: 30),
              if (currentDevice != DeviceTypes.desktop)
                Text(
                  'My Social Accounts',
                  style: standardTextStyle.copyWith(
                      color: Colors.black, fontSize: 20),
                ),
              if (currentDevice != DeviceTypes.desktop)
                const SizedBox(height: 35),
              if (currentDevice != DeviceTypes.desktop) contactChannels(),
              if (currentDevice != DeviceTypes.desktop)
                const SizedBox(height: 50),
              SizedBox(
                width: inputFieldWidth,
                child: Text(
                  contactStr,
                  style: lowerTextStyle.copyWith(
                      color: Colors.black, fontSize: 20),
                ),
              ),
              const SizedBox(height: 40),
              if (currentDevice != DeviceTypes.mobile)
                Row(children: [
                  inputField('Name', 50, 300, false),
                  const SizedBox(width: 10),
                  inputField('Email', 50, 300, false)
                ]),
              if (currentDevice == DeviceTypes.mobile)
                inputField('Name', 50, inputFieldWidth, false),
              if (currentDevice == DeviceTypes.mobile)
                const SizedBox(height: 10),
              if (currentDevice == DeviceTypes.mobile)
                inputField('Email', 50, inputFieldWidth, false),
              const SizedBox(height: 10),
              inputField('Headline', 50, inputFieldWidth, false),
              const SizedBox(height: 10),
              inputField('Message', 200, inputFieldWidth, true),
              const SizedBox(height: 20),
              // SUBMIT BUTTON
              SizedBox(
                width: inputFieldWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OnHoverButton(
                      builder: (bool isHovered) {
                        final color = isHovered
                            ? Colors.black
                            : const Color.fromARGB(255, 49, 49, 49);
                        return CupertinoButton(
                            onPressed: () {},
                            padding: EdgeInsets.zero,
                            child: Container(
                              color: color,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 12),
                                child: Text('Submit',
                                    style:
                                        lowerTextStyle.copyWith(fontSize: 22)),
                              ),
                            ));
                      },
                      transfrom: Matrix4.identity(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (currentDevice == DeviceTypes.desktop) const SizedBox(width: 100),
          if (currentDevice == DeviceTypes.desktop) contactChannels(),
        ],
      ),
    ),
  );
}

Widget contactChannels() {
  if (currentDevice == DeviceTypes.desktop) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        contactButton(
          _openMail,
          'assets/images/email_icon.png',
          'nizamsaltan@protonmail.com',
        ),
        const SizedBox(height: 30),
        contactButton(
          _openFiverrProfile,
          'assets/images/fiverr_icon.png',
          '@nizamsaltan',
        ),
        const SizedBox(height: 30),
        contactButton(
          _openGithubProfile,
          'assets/images/github_icon.png',
          '@rafrach',
        ),
        const SizedBox(height: 30),
        contactButton(
          _openMediumProfile,
          'assets/images/medium_icon.png',
          '@nizamsaltan',
        ),
      ],
    );
  } else {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        contactButton(
          _openMail,
          'assets/images/email_icon.png',
          'nizamsaltan@protonmail.com',
        ),
        const SizedBox(width: 20),
        contactButton(
          _openFiverrProfile,
          'assets/images/fiverr_icon.png',
          '@nizamsaltan',
        ),
        const SizedBox(width: 20),
        contactButton(
          _openGithubProfile,
          'assets/images/github_icon.png',
          '@rafrach',
        ),
        const SizedBox(width: 20),
        contactButton(
          _openMediumProfile,
          'assets/images/medium_icon.png',
          '@nizamsaltan',
        ),
        /*
      const SizedBox(height: 30),
      contactButton(
        _openInstagramProfile,
        'assets/images/instagram_icon.png',
        '@niizamsaltan',
      )
      */
      ],
    );
  }
}

Widget contactButton(Function? onPressed, String iconPath, String text) {
  return OnHoverButton(
    builder: ((isHovered) {
      return CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            onPressed!();
          },
          child: Row(
            children: [
              Image.asset(iconPath, height: 48),
              if (currentDevice == DeviceTypes.desktop)
                const SizedBox(width: 15),
              if (currentDevice == DeviceTypes.desktop)
                AnimatedOpacity(
                  opacity: isHovered ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: SelectableText(text,
                      style: standardTextStyle.copyWith(color: Colors.black)),
                ),
            ],
          ));
    }),
    transfrom: Matrix4.identity()
      ..scale(1)
      ..translate(10, 0, 0),
  );
}

Widget inputField(
    String placeholder, double height, double width, bool isLong) {
  return Container(
    height: height,
    width: width,
    color: const Color.fromARGB(255, 212, 212, 212),
    child: TextField(
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.zero),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        hintText: placeholder,
        hintStyle: lowerTextStyle.copyWith(color: Colors.black, fontSize: 22),
        labelStyle: standardTextStyle.copyWith(color: Colors.black),
      ),
      cursorColor: Colors.black,
      cursorWidth: 1.5,
      maxLines: isLong ? null : 1,
      minLines: isLong ? 9 : 1,
      keyboardType: isLong ? TextInputType.multiline : TextInputType.text,
    ),
  );
}

Widget bottomPanel() {
  return Container(
    height: 100,
    color: const Color.fromARGB(255, 44, 44, 44),
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          'Copyright (c) 2022 Nizam Saltan. All rights Reserved',
          style: lowerTextStyle,
        ),
      ),
    ),
  );
}

// ignore: must_be_immutable
class NonInteracliableSlider extends StatelessWidget {
  NonInteracliableSlider(
      {Key? key,
      required this.value,
      this.backgroundColor = const Color.fromARGB(255, 202, 202, 202),
      this.sliderColor = const Color.fromARGB(255, 124, 124, 124),
      this.width = 500,
      this.height = 7})
      : super(key: key);

  double value;
  double width;
  double height;
  Color backgroundColor;
  Color sliderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: backgroundColor,
      child: Row(
        children: [
          Container(
            width: width * value,
            height: height,
            color: sliderColor,
            child: const Text(''),
          ),
        ],
      ),
    );
  }
}

void _openFiverrProfile() async {
  final Uri url =
      Uri.parse('https://www.fiverr.com/nizamsaltan?up_rollout=false');
  if (!await launchUrl(url)) throw 'Could not launch $url';
  log('message');
}

void _openMediumProfile() async {
  final Uri url = Uri.parse('https://medium.com/@NizamSaltan/');
  if (!await launchUrl(url)) throw 'Could not launch $url';
  log('message');
}

void _openGithubProfile() async {
  final Uri url = Uri.parse('https://github.com/Rafrach');
  if (!await launchUrl(url)) throw 'Could not launch $url';
  log('message');
}

void _openMail() async {
  final Uri url = Uri.parse('mailto:${'nizamsaltan@protonmail.com'}');
  if (!await launchUrl(url)) throw 'Could not launch $url';
  log('message');
}
