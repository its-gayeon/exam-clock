import 'package:flutter/material.dart';
import 'package:one_clock/one_clock.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TimeTable and Clock',
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Colors.black,
          onPrimary: Color.fromARGB(255, 255, 139, 139),
          secondary: Color.fromARGB(255, 106, 175, 255),
          onSecondary: Colors.black,
          error: Colors.red,
          onError: Colors.white,
          // background: Colors.white,
          // onBackground: Colors.black,
          surface: Colors.white,
          onSurface: Colors.black,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<List<String>> secondThirdGrade = [
    ["교시", "시간", " ", "문항수", "과목"],
    ["1", "08:30 ~ 09:50", "80분", "45", "국어"],
    ["2", "10:10 ~ 11:50", "100분", "30", "수학"],
    ["3", "13:00 ~ 14:13", "70분", "45", "영어"],
    ["4", "14:30 ~ 15:00", "30분", "20", "한국사"],
    ["4", "15:08 ~ 15:38", "30분", "20", "탐구1선택"],
    ["4", "15:40 ~ 16:10", "30분", "20", "탐구2선택"],
  ];

  final List<List<String>> firstGrade = [
    ["교시", "시간", " ", "문항수", "과목"],
    ["1", "08:30 ~ 09:50", "80분", "45", "국어"],
    ["2", "10:10 ~ 11:50", "100분", "30", "수학"],
    ["3", "13:00 ~ 14:13", "70분", "45", "영어"],
    ["4", "14:30 ~ 15:00", "30분", "20", "한국사"],
    ["4", "15:08 ~ 15:48", "40분", "20", "통합사회"],
    ["4", "15:50 ~ 16:20", "40분", "20", "통합과학"],
  ];

  final List<List<String>> regularExam = [
    ["교시", "시간", " "],
    ["1", "08:50 ~ 09:40", "50분"],
    ["2", "10:00 ~ 10:50", "50분"],
    ["3", "11:10 ~ 12:00", "50분"],
  ];

  bool isRegularExam = false;
  List<List<String>> currentTimeTable = [];

  // 위젯 생성 시 실행될 함수 - 기본 시간표는 1학년
  @override
  void initState() {
    super.initState();
    currentTimeTable = firstGrade;
  }

  // [ 시간표 | 시계 ]
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // 왼쪽 - 시간표
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5, // 전체 화면의 50%
            child: const SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "시간표",
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 중앙 - 세로선
          const SizedBox(
            width: 0,
            child: VerticalDivider(
              color: Colors.grey,
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),
          ),

          // 오른쪽 - 시계
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AnalogClock(
                      isLive: true,
                      showSecondHand: true,
                      showTicks: true,
                      showDigitalClock: false,
                      showAllNumbers: true,
                      height: MediaQuery.of(context).size.height * 0.73,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      // 하단 - 시간표 선택 버튼
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.08, // 전체 화면의 8%
        decoration: BoxDecoration(
          color: Colors.grey[100],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // 1학년 버튼
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: currentTimeTable == firstGrade
                        ? Colors.grey[300]
                        : Colors.grey[100],
                  ),
                  onPressed: () {
                    print("1학년");
                    setState(() {
                      currentTimeTable = firstGrade;
                      isRegularExam = false;
                    });
                  },
                  child: const Text('1학년')),
            ),

            // 구분선
            const VerticalDivider(
              color: Colors.grey,
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),

            // 2,3학년 버튼
            TextButton(
                onPressed: () {
                  print("2,3학년");
                },
                child: const Text('2,3학년')),

            // 구분선
            const VerticalDivider(
              color: Colors.grey,
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),

            // 정기고사 버튼
            TextButton(
                onPressed: () {
                  print("정기고사");
                },
                child: const Text('정기고사')),
          ],
        ),
      ),
    );
  }
}
