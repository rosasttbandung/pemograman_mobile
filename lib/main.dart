import 'dart:async';
import 'package:flutter/material.dart';

// Nama : Rosa
//NPM   : 20552011186

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  CalculatorAppState createState() => CalculatorAppState();
}

class CalculatorAppState extends State<MyApp> {
  final double _padding = 16.0;
  final double _buttonFontSize = 24.0;

  final Color _primarySwatchColor = Colors.blue;
  final Color _textColorWhite = Colors.white;
  final Color _buttonColorWhite = Colors.white;
  final Color _buttonHighlightColor = Colors.blue;
  final Color _buttonColorGrey = Colors.grey;

  late int valueA;
  late int valueB;

  late String operator;

  var sbValue = new StringBuffer();

  @override
  void initState() {
    sbValue.write("0");
    operator = "";
    super.initState();
  }

  void appendValue(String str) {
    setState(() {
      bool doCalculate = false;
      // jika setelah karakter operator itu tidak boleh ada inputan bilangan 0.
      String strValue = sbValue.toString();
      String lastCharacter = strValue.substring(strValue.length - 1);
      if (str == "0" &&
          (lastCharacter == "/" ||
              lastCharacter == "x" ||
              lastCharacter == "-" ||
              lastCharacter == "+")) {
        return;
      }
      // jika nilai yang diinput merupakan 0 dan nilai pada widget AutoSizeText juga 0 maka, jangan masukkan nilai tersebut.
      else if (str == "0" && sbValue.toString() == "0") {
        return;
      } else if (str == "=") {
        doCalculate = true;
      } else if (str == "/" || str == "x" || str == "-" || str == "+") {
        if (operator.isEmpty) {
          operator = str;
        } else {
          doCalculate = true;
        }
      }
      if (!doCalculate) {
        //  jika ternyata nilai awalnya 0 dan kemudian input bilangan lagi maka, seharusnya nilai 0 tadi kita clear dan masukkan bilangan yang baru.
        if (sbValue.toString() == "0" && str != "0") {
          sbValue.clear();
        }
        sbValue.write(str);
      } else {
        List<String> values = sbValue.toString().split(operator);
        if (values.length == 2 &&
            values[0].isNotEmpty &&
            values[1].isNotEmpty) {
          valueA = int.parse(values[0]);
          valueB = int.parse(values[1]);
          sbValue.clear();
          int total = 0;
          switch (operator) {
            case "/":
              total = valueA ~/ valueB;
              break;
            case "x":
              total = valueA * valueB;
              break;
            case "-":
              total = valueA - valueB;
              break;
            case "+":
              total = valueA + valueB;
          }
          sbValue.write(total);
          // jika bilangan pertama, operator, dan bilangan kedua sudah terpenuhi lalu si pengguna tap button operator lagi maka, itu akan melakukan perhitungan dan didepannya sudah ditambahkan dengan operator yang terbaru.
          if (str == "/" || str == "x" || str == "-" || str == "+") {
            operator = str;
            sbValue.write(str);
          } else {
            operator = "";
          }
        } // kita bisa mengganti-ganti operatornya tanpa perlu hapus karakter terakhir pada operator
        else {
          String strValue = sbValue.toString();
          String lastCharacter = strValue.substring(strValue.length - 1);
          if (str == "/" || str == "x" || str == "-" || str == "+") {
            operator = "";
            sbValue.clear();
            sbValue
                .write(strValue.substring(0, strValue.length - 1) + "" + str);
            operator = str;
          } // optional
          // saat sebelum input bilangan kedua lalu tap button "=" maka operator dihapus
          else if (str == "=" &&
              (lastCharacter == "/" ||
                  lastCharacter == "x" ||
                  lastCharacter == "-" ||
                  lastCharacter == "+")) {
            operator = "";
            sbValue.clear();
            sbValue.write(strValue.substring(0, strValue.length - 1));
          }
        }
      }
    });
  }

  void deleteValue() {
    setState(() {
      String strValue = sbValue.toString();
      if (strValue.length > 0) {
        String lastCharacter = strValue.substring(strValue.length - 1);
        if (lastCharacter == "/" ||
            lastCharacter == "x" ||
            lastCharacter == "-" ||
            lastCharacter == "+") {
          operator = "";
        }
        strValue = strValue.substring(0, strValue.length - 1);
        sbValue.clear();
        sbValue.write(strValue.length == 0 ? "0" : strValue);
      }
    });
  }

  void clearValue() {
    setState(() {
      operator = "";
      sbValue.clear();
      sbValue.write("0");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalkulator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Kalkulator",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              key: Key("expanded_bagian_atas"),
              flex: 1,
              child: Container(
                key: Key("expanded_container_bagian_atas"),
                width: double.infinity,
                height: double.infinity,
                padding: EdgeInsets.all(_padding),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [],
                ),
              ),
            ),
            Expanded(
              key: Key("expanded_bagian_bawah"),
              flex: 1,
              child: Column(
                key: Key("expanded_column_bagian_bawah"),
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: MaterialButton(
                            color: _buttonColorWhite,
                            highlightColor: _buttonHighlightColor,
                            child: Text(
                              "C",
                              style: TextStyle(
                                  color: _primarySwatchColor,
                                  fontSize: _buttonFontSize),
                            ),
                            onPressed: () {
                              clearValue();
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: MaterialButton(
                            color: _buttonColorWhite,
                            highlightColor: _buttonHighlightColor,
                            child: Icon(
                              Icons.backspace,
                              color: _buttonColorGrey,
                            ),
                            onPressed: () {
                              deleteValue();
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: MaterialButton(
                            color: _buttonColorWhite,
                            highlightColor: _buttonHighlightColor,
                            child: Text(
                              "/",
                              style: TextStyle(
                                color: _buttonColorGrey,
                                fontSize: _buttonFontSize,
                              ),
                            ),
                            onPressed: () {
                              appendValue("/");
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: MaterialButton(
                            color: _buttonColorWhite,
                            highlightColor: _buttonHighlightColor,
                            child: Text(
                              "7",
                              style: TextStyle(
                                color: _buttonColorGrey,
                                fontSize: _buttonFontSize,
                              ),
                            ),
                            onPressed: () {
                              appendValue("7");
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: MaterialButton(
                            color: _buttonColorWhite,
                            highlightColor: _buttonHighlightColor,
                            child: Text(
                              "8",
                              style: TextStyle(
                                color: _buttonColorGrey,
                                fontSize: _buttonFontSize,
                              ),
                            ),
                            onPressed: () {
                              appendValue("8");
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: MaterialButton(
                            color: _buttonColorWhite,
                            highlightColor: _buttonHighlightColor,
                            child: Text(
                              "9",
                              style: TextStyle(
                                color: _buttonColorGrey,
                                fontSize: _buttonFontSize,
                              ),
                            ),
                            onPressed: () {
                              appendValue("9");
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: MaterialButton(
                            color: _buttonColorWhite,
                            highlightColor: _buttonHighlightColor,
                            child: Text(
                              "x",
                              style: TextStyle(
                                color: _buttonColorGrey,
                                fontSize: _buttonFontSize,
                              ),
                            ),
                            onPressed: () {
                              appendValue("x");
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: MaterialButton(
                            color: _buttonColorWhite,
                            highlightColor: _buttonHighlightColor,
                            child: Text(
                              "4",
                              style: TextStyle(
                                color: _buttonColorGrey,
                                fontSize: _buttonFontSize,
                              ),
                            ),
                            onPressed: () {
                              appendValue("4");
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: MaterialButton(
                            color: _buttonColorWhite,
                            highlightColor: _buttonHighlightColor,
                            child: Text(
                              "5",
                              style: TextStyle(
                                color: _buttonColorGrey,
                                fontSize: _buttonFontSize,
                              ),
                            ),
                            onPressed: () {
                              appendValue("5");
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: MaterialButton(
                            color: _buttonColorWhite,
                            highlightColor: _buttonHighlightColor,
                            child: Text(
                              "6",
                              style: TextStyle(
                                color: _buttonColorGrey,
                                fontSize: _buttonFontSize,
                              ),
                            ),
                            onPressed: () {
                              appendValue("6");
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: MaterialButton(
                            color: _buttonColorWhite,
                            highlightColor: _buttonHighlightColor,
                            child: Text(
                              "-",
                              style: TextStyle(
                                color: _buttonColorGrey,
                                fontSize: _buttonFontSize,
                              ),
                            ),
                            onPressed: () {
                              appendValue("-");
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: MaterialButton(
                            color: _buttonColorWhite,
                            highlightColor: _buttonHighlightColor,
                            child: Text(
                              "1",
                              style: TextStyle(
                                color: _buttonColorGrey,
                                fontSize: _buttonFontSize,
                              ),
                            ),
                            onPressed: () {
                              appendValue("1");
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: MaterialButton(
                            color: _buttonColorWhite,
                            highlightColor: _buttonHighlightColor,
                            child: Text(
                              "2",
                              style: TextStyle(
                                color: _buttonColorGrey,
                                fontSize: _buttonFontSize,
                              ),
                            ),
                            onPressed: () {
                              appendValue("2");
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: MaterialButton(
                            color: _buttonColorWhite,
                            highlightColor: _buttonHighlightColor,
                            child: Text(
                              "3",
                              style: TextStyle(
                                color: _buttonColorGrey,
                                fontSize: _buttonFontSize,
                              ),
                            ),
                            onPressed: () {
                              appendValue("3");
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: MaterialButton(
                            color: _buttonColorWhite,
                            highlightColor: _buttonHighlightColor,
                            child: Text(
                              "+",
                              style: TextStyle(
                                color: _buttonColorGrey,
                                fontSize: _buttonFontSize,
                              ),
                            ),
                            onPressed: () {
                              appendValue("+");
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: MaterialButton(
                            color: _buttonColorWhite,
                            highlightColor: _buttonHighlightColor,
                            child: Text(
                              "0",
                              style: TextStyle(
                                color: _buttonColorGrey,
                                fontSize: _buttonFontSize,
                              ),
                            ),
                            onPressed: () {
                              appendValue("0");
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: MaterialButton(
                            color: _primarySwatchColor,
                            highlightColor: _buttonHighlightColor,
                            child: Text(
                              "=",
                              style: TextStyle(
                                color: _textColorWhite,
                                fontSize: _buttonFontSize,
                              ),
                            ),
                            onPressed: () {
                              appendValue("=");
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
