import 'package:snapstory/constants/routes.dart';
import 'package:snapstory/views/drawing_quiz/drawing.dart';
import 'package:flutter/material.dart';

class DrawingTaleList extends StatefulWidget {
  const DrawingTaleList({Key? key}) : super(key: key);

  @override
  State<DrawingTaleList> createState() => DrawingTaleListState();
}

class DrawingTaleListState extends State<DrawingTaleList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.2,
                top: MediaQuery.of(context).size.width * 0.3),
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/main/bg-main2.png'),
              ),
            ),
            child: ListView(
              children: [
                IconButton(
                  padding: EdgeInsets.all(10),
                  iconSize: MediaQuery.of(context).size.height * 0.2,
                  icon: Image.asset(
                      "assets/quizTaleList/btn-quiz-cinderella.png"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DrawingView(1)));
                  },
                ),
                IconButton(
                  padding: EdgeInsets.all(10),
                  iconSize: MediaQuery.of(context).size.height * 0.2,
                  icon:
                      Image.asset("assets/quizTaleList/btn-quiz-snowwhite.png"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DrawingView(2)));
                  },
                ),
                IconButton(
                  padding: EdgeInsets.all(10),
                  iconSize: MediaQuery.of(context).size.height * 0.2,
                  icon: Image.asset(
                      "assets/quizTaleList/btn-quiz-sleepingbeauty.png"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DrawingView(3)));
                  },
                ),
                IconButton(
                  padding: EdgeInsets.all(10),
                  iconSize: MediaQuery.of(context).size.height * 0.2,
                  icon:
                      Image.asset("assets/quizTaleList/btn-quiz-rapunzel.png"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DrawingView(4)));
                  },
                ),
                IconButton(
                  padding: EdgeInsets.all(10),
                  iconSize: MediaQuery.of(context).size.height * 0.2,
                  icon: Image.asset(
                      "assets/quizTaleList/btn-quiz-beautyandbeast.png"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DrawingView(5)));
                  },
                ),
              ],
            ),
          ),

          // 상단 버튼
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Align(
              alignment: Alignment.topCenter,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 도움말 - 튜토리얼
                    IconButton(
                        iconSize: MediaQuery.of(context).size.width * 0.25,
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/main/btn-help.png',
                        )),
                    // 나가기
                    IconButton(
                        iconSize: MediaQuery.of(context).size.width * 0.25,
                        onPressed: () {
                          Navigator.of(context).pushNamed(mainRoute);
                        },
                        icon: Image.asset(
                          'assets/main/btn-quit.png',
                        )),
                  ]),
            ),
          ),

          // 하단 바
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.1,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32)),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/aiTale/bottom_bar.png'),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
