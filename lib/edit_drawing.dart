import 'package:drawnig_flutter/main.dart';
import 'package:drawnig_flutter/model/json_drawing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:drawnig_flutter/app_colors.dart';
import 'package:drawnig_flutter/globalvariable.dart';
import 'package:drawnig_flutter/model/drawing_board_page.dart';
import 'package:drawnig_flutter/model/image_save.dart';
import 'package:drawnig_flutter/model/tool_drawing.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

void main() {
  runApp(EditDrawingApp());
}

class EditDrawingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DrawingAppPage(), // เปลี่ยนชื่อคลาสเป็น DrawingAppPage
    );
  }
}

Future<void> _getJsonList() async {
  print((await drawingController.getImageData())?.buffer.asInt8List());
}

class DrawingAppPage extends StatefulWidget {
  @override
  _DrawingAppPageState createState() => _DrawingAppPageState();
}

class _DrawingAppPageState extends State<DrawingAppPage> {
  @override
  void initState() {
    //ฟั่งที่จะทำงานเมื่อเริ่มโปรแกรมหรือเริ่มหน้า
    super.initState();
    _resetState();
    GetJsonDrawing(editFileName); //ส่งชื่อไฟล์สำหรับการแก้ไขรูป
  }

  void _resetState() {
    //รีเช็ต drawingController
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
    saveDrawing(
        context: context,
        globalKey: globalKey,
        newDrawing: false); //ส่งข้อมูลต่างๆไปยังการ save
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            MdiIcons.arrowLeftCircle,
            color: ColorPalette.white,
            size: 40,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MainPage(),
              ),
            );
          },
        ),
        title: const Text(
          'Drawing Board Edit',
          style:
              TextStyle(color: ColorPalette.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: ColorPalette.black,
        actions: [
          ZoomTapAnimation(
            //กำหนดอนิเมชั่นการกด
            end: 0.8,
            begin: 1,
            child: IconButton(
              icon: Icon(
                MdiIcons.contentSaveAll,
                color: ColorPalette.grey,
              ),
              onPressed: _saveDrawing,
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            child:
                DrawingBoardPage(), // เรียกใช้ DrawingBoardPage จากที่กำหนดไว้ จาก drawing_board_page.dart
          ),
          Positioned(
            //ตำแหน่งเครื่องเมื่อ
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(2),
              width: MediaQuery.of(context).size.width,
              color: ColorPalette.toolBg,
              child: ToolDrawing(),
            ),
          ),
        ],
      ),
    );
  }
}
