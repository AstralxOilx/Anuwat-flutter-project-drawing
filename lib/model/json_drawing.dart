import 'dart:convert';
import 'dart:io';

import 'package:drawnig_flutter/globalvariable.dart';
import 'package:drawnig_flutter/model/drawing_model.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:flutter_drawing_board/paint_contents.dart';

Future<void> GetJsonDrawing(String name) async {
  // กำหนดพาธของไฟล์ JSON ที่จะอ่าน (เปลี่ยนพาธตามต้องการ)
  final directory = Directory.systemTemp; // ใช้ไดเรกทอรี temp ของระบบ
  final filePath = '${directory.path}/${name}.json';
  final file = File(filePath);
  drawingController = DrawingController();
  // ตรวจสอบว่าไฟล์มีอยู่หรือไม่
  if (await file.exists()) {
    // อ่านข้อมูลจากไฟล์
    String jsonString = await file.readAsString();

    // แปลงข้อมูล JSON เป็น Dart object
    final List<dynamic> jsonData = jsonDecode(jsonString);

    // แสดงข้อมูล JSON
    print(jsonData);

    // final List<dynamic> jsonData = jsonDecode(jsonString);
    final List<Simple> drawings =
        jsonData.map((item) => Simple.fromJson(item)).toList();
        //แปลงข้อมูลจาก json ที่ได้มาเพื่อทำให้ข้อมูลที่ได้ ตรงกันกับ ฟังชั่น addContent ของ flutter_drawing_board
    for (var drawing in drawings) { 
      final Map<String, dynamic> _testLineSimple = {
        "type": drawing.type,
        "path": {
          "fillType": drawing.path.fillType,
          "steps": drawing.path.steps
              .map((step) => {
                    "type": step.type,
                    "x": step.x,
                    "y": step.y,
                  })
              .toList(),
        },
        "paint": {
          "blendMode": drawing.paint.blendMode,
          "color": drawing.paint.color,
          "filterQuality": drawing.paint.filterQuality,
          "invertColors": drawing.paint.invertColors,
          "isAntiAlias": drawing.paint.isAntiAlias,
          "strokeCap": drawing.paint.strokeCap,
          "strokeJoin": drawing.paint.strokeJoin,
          "strokeWidth": drawing.paint.strokeWidth,
          "style": drawing.paint.style,
        }
      };

      // print(_testLineSimple);

      // ตรวจสอบประเภทและแปลงเป็นวัตถุที่เหมาะสม
      if (_testLineSimple["type"] == "SimpleLine") {
        drawingController.addContent(SimpleLine.fromJson(_testLineSimple));
      } else if (_testLineSimple["type"] == "Eraser") {
        drawingController.addContent(Eraser.fromJson(_testLineSimple));
      }
    }

  } else {
    print('ไฟล์ JSON ไม่พบที่ $filePath');
  }
}
