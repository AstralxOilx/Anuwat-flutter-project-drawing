
import 'package:drawnig_flutter/main.dart';
import 'package:drawnig_flutter/model/image_save.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:drawnig_flutter/app_colors.dart';
import 'package:drawnig_flutter/globalvariable.dart';
import 'package:drawnig_flutter/model/drawing_board_page.dart';
import 'package:drawnig_flutter/model/tool_drawing.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

void main() {
  runApp(DrawingApp());
}

class DrawingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:
          DrawingAppPage(), // เปลี่ยนชื่อคลาสให้ตรงกับ StatefulWidget ที่ถูกต้อง
    );
  }
}

class DrawingAppPage extends StatefulWidget {
  // เปลี่ยนชื่อคลาส StatefulWidget เป็น DrawingAppPage
  @override
  _DrawingAppPageState createState() => _DrawingAppPageState();
}

class _DrawingAppPageState extends State<DrawingAppPage> {
  @override
  void initState() {
    super.initState();
    drawingController = DrawingController(); //กำหนด drawingController เป็นค่าเริ่มต้น
    _resetState();
  }

  void _resetState() { //รีเช็ต การกระดานวาด
    drawingController.setStyle(
      color: selectedColor,
      strokeWidth: strokeWidth,
      isAntiAlias: true,
      style: PaintingStyle.stroke,
    );
  }

  void _saveDrawing() {
    // เพิ่ม drawingController ลงในลิสต์
    savedControllers.add(drawingController);
    // บันทึกภาพตามที่คุณต้องการ
    saveDrawing(context: context, globalKey: globalKey, newDrawing: true); //ส่งข้อมูลต่างๆไปยังการ save
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( //appbar
        leading: IconButton(
          icon: Icon(
            MdiIcons.arrowLeftCircle,
            color: ColorPalette.white,
            size: 40,
          ),
          onPressed: () { //ปุ่มย้อนกลับ
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MainPage(),
              ),
            );
          },
        ),
        title: const Text(
          'Drawing Board',
          style:
              TextStyle(color: ColorPalette.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: ColorPalette.black,
        actions: [
          ZoomTapAnimation(//กำหนดอนิเมชั่นการกดเป็นการซูมเมื่อกด จาก แพกเก็จ ZoomTapAnimation
            end: 0.8, // เมื่อกดย่อ icon = 0.8
            begin: 1,//เริ่มต้นของขนาด icon
            child: IconButton( //ปุ่ม save
              icon: Icon(
                MdiIcons.contentSaveAll,
                color: ColorPalette.grey, // ใช้สีพื้นหลังจาก ColorPalette
              ),
              onPressed: _saveDrawing, //เรียกใช้ฟั่งชั่น save
            ),
          )
        ],
      ),
      body: Stack( //Stack ใช้ในการจัด  Positioned ของหน้าจอต่างๆ เช่น ตำแหน่งเครื่องมือ
        children: [
          Positioned(
            child: DrawingBoardPage(),//เรียกใช้ กระดานวาด จาก  drawing_board_page.dart ที่สร้างไว้

          ),
          Positioned( //กำหนดตำแหนน่งของเครื่องมือ
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(2),
              width: MediaQuery.of(context).size.width,
              color: ColorPalette.toolBg, // ใช้สีพื้นหลังจาก ColorPalette
              child: ToolDrawing(),//เรียกใช้เครื่องมือ tool_drawing.dart ที่เตรียมไว้
            ),
          ),
        ],
      ),
    );
  }
}
