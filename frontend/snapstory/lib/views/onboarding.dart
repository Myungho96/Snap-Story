import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:snapstory/main.dart';

// 앱 처음 시작할 때 튜토리얼 페이지
class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
            title: '',
            body: 'tutorial 1',
            image: Image.asset('assets/tuto/(1)intro.gif'),
            decoration: getPageDecoration()
        ),
        PageViewModel(
            title: '',
            body: 'tutorial 2',
            image: Image.asset('assets/tuto/(2)aitale.gif'),
            decoration: getPageDecoration()
        ), PageViewModel(
            title: '',
            body: 'tutorial 3',
            image: Image.asset('assets/tuto/(3)aitale.gif'),
            decoration: getPageDecoration()
        ),
        PageViewModel(
            title: '',
            body: 'tutorial 4',
            image: Image.asset('assets/tuto/(4)quiztale.gif'),
            decoration: getPageDecoration()
        ),
        PageViewModel(
            title: '',
            body: 'tutorial 5',
            image: Image.asset('assets/tuto/(5)my.gif'),
            decoration: getPageDecoration()
        ),

      ],
      done: const Text('done'),
      onDone: () {
        // 메인 페이지로 이동
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      },
      next: const Icon(Icons.arrow_forward),
      showSkipButton: true,
      skip: const Text('skip'),
      dotsDecorator: DotsDecorator(
          color: Colors.grey,
          size: const Size(6.5, 10),
          activeSize: const Size(22, 10),
          activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24)
          ),
          activeColor: Colors.orange
      ),
      curve: Curves.bounceOut
      ,
    );
  }

  // IntroductionScreen 꾸미기
  PageDecoration getPageDecoration() {
    return const PageDecoration(
        titleTextStyle: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold
        ),
        bodyTextStyle: TextStyle(
            fontSize: 18,
            color: Colors.blue
        ),
        imagePadding: EdgeInsets.only(top: 40),

    );
  }
}
