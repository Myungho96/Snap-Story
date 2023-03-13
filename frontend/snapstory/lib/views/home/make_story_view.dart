import 'package:flutter/material.dart';

// 필요한 것
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:openai_client/openai_client.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'complete_story_view.dart';

const apiKey = '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';
const apiUrl = 'https://api.openai.com/v1/completions';

// dalle가 만든 이미지 리스트
final List<String> imgList = [];

// complete_story_view로 넘어갈 변수 2개
String story = ""; // chatGpt가 만든 스토리
String selectedImg = ""; // 선택한 이미지

class FairyTale {
  final String text;
  final String img;

  const FairyTale(this.text, this.img);
}

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(item, fit: BoxFit.cover, width: 1000.0),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                      ),
                    ),
                  ],
                )),
          ),
        ))
    .toList();

class MakeStory extends StatefulWidget {
  const MakeStory({Key? key}) : super(key: key);

  @override
  State<MakeStory> createState() => _MakeStoryState();
}

class _MakeStoryState extends State<MakeStory> {
  // chatGPT에게 물어볼 질문 생성 함수
  Future<String> generateText(String obj) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey'
      },
      body: jsonEncode({
        "model": "text-davinci-003",
        'prompt':
            'make a instructive story about $obj in 7 sentence for kids. And give me one sentence about this storys image by using this templete: "image: your answer',
        'max_tokens': 1000,
        'temperature': 0,
        'top_p': 1,
        'frequency_penalty': 0,
        'presence_penalty': 0
      }),
    );

    Map<String, dynamic> newresponse =
        jsonDecode(utf8.decode(response.bodyBytes));

    return newresponse['choices'][0]['text'];
  }

  // dall-e 사용하기
  Future<String> askToDalle(String imgStr) async {
    // Create a new client.
    final client = OpenAIClient(
      configuration: const OpenAIConfiguration(
        apiKey: apiKey,
      ),
    );

    // Create an image.
    final image = await client.images
        .create(
          prompt: 'cute illust of a group of $imgStr',
          n: 4, // 원하는 이미지 개수
        )
        .data;

    for (int i = 0; i < 4; i++) {
      // 이미지 리스트에 추가
      imgList
          .add(image.data.toList().elementAt(i).props.elementAt(0).toString());
    }

    return (image.data
        .toList()
        .elementAt(1)
        .props
        .elementAt(0)
        .toString()); // 첫번째 elementAt에 들어가는 숫자가 달리가 불러오는 이미지 인덱스
  }

  // GPT 사용하기 (동화텍스트와 동화 이미지 경로를 반환)
  Future<List<String>> askToGpt() async {
    String obj = "coffee"; // 인식한 사물 이름 넣기
    String data = await generateText(obj); // 동화와 이미지 문장 만들기

    List<String> str = data.split("Image:");

    String fairytale = str[0]; // 동화 텍스트 저장
    story = fairytale; // 전역변수 story에 저장
    String imgStr = str[1]; // 이미지 텍스트 저장

    String imgPath = await askToDalle(imgStr); // 달리로 이미지 경로 생성

    return [fairytale, imgPath]; // 동화텍스트와 동화 이미지 경로를 반환
  }

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
            future: askToGpt(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
              if (snapshot.hasData == false) {
                return const CircularProgressIndicator();
              }
              //error가 발생하게 될 경우 반환하게 되는 부분
              else if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: const TextStyle(fontSize: 15),
                  ),
                );
              }
              // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 것이다.
              else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("멋진 동화가 완성되었습니다!"),
                      Text("원하는 동화 표지를 선택해주세요."),
                      CarouselSlider(
                        options: CarouselOptions(
                            aspectRatio: 2.0,
                            enlargeCenterPage: true,
                            enableInfiniteScroll: false,
                            initialPage: 0,
                            autoPlay: false,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _current = index;
                              });
                            }),
                        items: imageSliders,
                      ),

                      // Image.network(snapshot.data[1]),
                      OutlinedButton(
                          onPressed: () {

                            print(_current);
                            selectedImg = imgList[_current];
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CompleteStory(fairyTale: FairyTale(story, selectedImg)),
                              ),
                            );
                          },
                          child: const Text("이 표지로 결정"))
                    ],
                  ),
                );

              }
            }),
      )

    );
  }
}
