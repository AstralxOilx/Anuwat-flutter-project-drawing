import 'package:drawnig_flutter/globalvariable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';

void main() {
  runApp(DrawingBoardPage());
}

class DrawingBoardPage extends StatefulWidget {
  @override
  _DrawingBoardPageState createState() => _DrawingBoardPageState();
}

class _DrawingBoardPageState extends State<DrawingBoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return RepaintBoundary(
            //ใช้ในการบันทึกรูปที่เขียน
            key: globalKey, //key ที่ใช้ในการบันทึกรูป
            child: DrawingBoard(
              controller: drawingController, //ตัว controller สำหรับการวาด
              background: Container(
                width: constraints.maxWidth, //กำหนดขนาด กระดานวาด
                height: constraints.maxHeight,
                color: Colors.white, //กำหนดสีพื้นหลังกระดานวาด
              ),
              showDefaultTools: false, //ปิดการใช้ เครื่องมือพื้นฐาน ต่างๆ
              showDefaultActions: false,
            ),
          );
        },
      ),
    );
  }
}
