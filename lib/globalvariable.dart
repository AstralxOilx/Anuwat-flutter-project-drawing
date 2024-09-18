import 'package:flutter/material.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';

List<DrawingController> savedControllers =
    []; //ตัวแปรที่ไว้เก็บการ save drawingControllers
final GlobalKey globalKey = GlobalKey(); //key ในการบันทึกรูป
DrawingController drawingController =
    DrawingController(); //ตัวแปร drawingController
DrawingController jsonCon =
    DrawingController(); //ตัวแปรที่ไว้เก็บ json ของ drawingController ที่โหลดมาจากการบันทึก
String editFileName =
    ""; //ตัวแปรที่ไว้เก็บชื่อ ไฟล์ json ที่จะใช้ในการแก้ไขรูปวาด

// bool isActive = false; //ไว้ ในการเช็คว่าเลือก เครื่องมือในการวาดตัวไหน
Color selectedColor = Colors.blue; //ตัวแปรในการเลือกสีในการวาด
double strokeWidth = 2.0; //ตัวแปรขนาดของเส้นในการวาด

enum ToolType {
  //ตัวแปรที่ไว้เก็บประเภทของเครื่องมือ
  none,
  eraser,
  strokeWidth,
  pencil
}
