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
    ["4", "15:55 ~ 16:35", "40분", "20", "통합과학"],
  ];

  final List<List<String>> regularExam = [
    ["교시", "시간", " "],
    ["1", "08:50 ~ 09:40", "50분"],
    ["2", "10:00 ~ 10:50", "50분"],
    ["3", "11:10 ~ 12:00", "50분"],
  ];

  bool isRegularExam = false;
  List<List<String>> currentTimeTable = [];

  @override
  void initState() {
    super.initState();
    currentTimeTable = firstGrade;
  }

  bool isCurrentTimeSlot(String timeSlot) {
    final times = timeSlot.trim().split('~');
    if (times.length != 2) return false;

    final now = DateTime.now();
    final currentTime =
        DateTime(now.year, now.month, now.day, now.hour, now.minute);

    // Parse start time
    final startTimeParts = times[0].trim().split(':');
    final startTime = DateTime(now.year, now.month, now.day,
        int.parse(startTimeParts[0]), int.parse(startTimeParts[1]));

    // Parse end time
    final endTimeParts = times[1].trim().split(':');
    final endTime = DateTime(now.year, now.month, now.day,
        int.parse(endTimeParts[0]), int.parse(endTimeParts[1]));

    return currentTime.isAfter(startTime) && currentTime.isBefore(endTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DigitalClock(
                      showSeconds: true,
                      isLive: true,
                      textScaleFactor: 3,
                      datetime: DateTime.now(),
                    ),
                    if (isRegularExam)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          DateTime.now().toString().substring(0, 10),
                          style: const TextStyle(fontSize: 30),
                        ),
                      )
                    else
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "학교 코드: 11186",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Table(
                        columnWidths: const <int, TableColumnWidth>{
                          0: FixedColumnWidth(60),
                          1: FlexColumnWidth(),
                          2: FixedColumnWidth(80),
                          3: FixedColumnWidth(80),
                          4: FixedColumnWidth(110),
                        },
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        border: TableBorder.all(),
                        children: List<TableRow>.generate(
                          currentTimeTable.length,
                          (index) => TableRow(
                            decoration: index == 0
                                ? BoxDecoration(
                                    color: Colors.grey[300],
                                  )
                                : isCurrentTimeSlot(currentTimeTable[index][1])
                                    ? const BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 255, 139, 139),
                                      )
                                    : null,
                            children: List.generate(
                              currentTimeTable[0].length,
                              (columnIndex) => TableCell(
                                child: Center(
                                  child: Text(
                                    currentTimeTable[index][columnIndex],
                                    style: columnIndex == 4 &&
                                            currentTimeTable[index][columnIndex]
                                                    .length >=
                                                4
                                        ? const TextStyle(fontSize: 25)
                                        : const TextStyle(fontSize: 30),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 0,
            child: VerticalDivider(
              color: Colors.grey,
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),
          ),
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
                    const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text("타종과 수 초의 차이가 있을 수 있으므로 시계는 보조적으로 사용하세요"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.08,
        decoration: BoxDecoration(
          color: Colors.grey[100],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: currentTimeTable == firstGrade
                        ? Colors.grey[300]
                        : Colors.grey[100],
                  ),
                  onPressed: () {
                    setState(() {
                      currentTimeTable = firstGrade;
                      isRegularExam = false;
                    });
                  },
                  child: const Text('1학년')),
            ),
            const VerticalDivider(
              color: Colors.grey,
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),
            TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: currentTimeTable == secondThirdGrade
                      ? Colors.grey[300]
                      : Colors.grey[100],
                ),
                onPressed: () {
                  setState(() {
                    currentTimeTable = secondThirdGrade;
                    isRegularExam = false;
                  });
                },
                child: const Text('2,3학년')),
            const VerticalDivider(
              color: Colors.grey,
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),
            TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: currentTimeTable == regularExam
                      ? Colors.grey[300]
                      : Colors.grey[100],
                ),
                onPressed: () {
                  setState(() {
                    currentTimeTable = regularExam;
                    isRegularExam = true;
                  });
                },
                child: const Text('정기고사')),
          ],
        ),
      ),
    );
  }
}
