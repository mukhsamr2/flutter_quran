import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int nilai = 100;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Quran"),
        ),
        body: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Image(
                image: AssetImage('images/2.png'),
              ),
            ),
            Column(
              children: [
                Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: const Color.fromARGB(255, 187, 187, 187),
                    )),
                    height: 150,
                    child: Center(
                      child: Text(
                        nilai.toString(),
                        style: const TextStyle(fontSize: 70),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Nilai(
                        text: 'DIKETUK',
                        minus: () => salah(4),
                        plus: () => ulangi(4),
                      ),
                      Nilai(
                        text: 'BERHENTI LAMA',
                        minus: () => salah(2),
                        plus: () => ulangi(2),
                      ),
                      Nilai(
                        text: 'DIBERITAHU',
                        minus: () => salah(5),
                        plus: () => ulangi(5),
                      ),
                      Nilai(
                        text: 'SALAH TAJWID',
                        minus: () => salah(3),
                        plus: () => ulangi(3),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: TextField(
                          maxLines: 3, //or null
                          decoration: InputDecoration.collapsed(
                            border: UnderlineInputBorder(),
                            hintText: "Catatan",
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () => {},
                            style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.grey),
                            ),
                            label: const Text('Kembali'),
                            icon: const Icon(
                              Icons.arrow_back,
                              size: 20,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => {},
                            style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.green),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Text('Lanjut'),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  ulangi(int plus) => setState(() => {nilai = nilai + plus});
  salah(int minus) => setState(() => {nilai = nilai - minus});
}

class Nilai extends StatefulWidget {
  final String text;
  final void Function() minus;
  final void Function() plus;

  const Nilai({
    Key? key,
    required this.text,
    required this.minus,
    required this.plus,
  }) : super(key: key);

  @override
  State<Nilai> createState() => _NilaiState();
}

class _NilaiState extends State<Nilai> {
  int badge = 0;
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Visibility(
          visible: isVisible,
          child: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: ElevatedButton(
              onPressed: () {
                widget.plus();
                setState(() {
                  badge--;
                  if (badge < 1) isVisible = false;
                });
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(Colors.yellow.shade800)),
              child: const Center(
                child: Icon(
                  Icons.refresh,
                  size: 25,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              widget.minus();
              setState(() {
                badge++;
                if (badge > 0) isVisible = true;
              });
            },
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.blue.shade800),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.text),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Badge(
                    shape: BadgeShape.square,
                    badgeColor: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(3),
                    badgeContent: Text(
                      badge.toString(),
                      style: TextStyle(
                        color: Colors.red.shade800,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
