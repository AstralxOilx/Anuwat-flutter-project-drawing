import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:drawnig_flutter/globalvariable.dart';
import 'package:drawnig_flutter/main.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<void> saveDrawing( //ฟังชั่นในการ save รูป
    {required BuildContext context, //กำหนดให้รับ param  context  globalKey newDrawing
    required GlobalKey globalKey,
    required bool newDrawing}) async { //กำหนดเป็น async
  try {
    //กำหนดตัวแปรในการ บันทึกรูป
    final boundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage(); //รับรูปจาก boundary ที่กำหนดใน การวาด
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);//บันทึกรูปเป็น  Byte 
    final buffer = byteData!.buffer.asUint8List();

    final directory = await getTemporaryDirectory(); //ดึงที่อยูรูปภาพ  directory
    final now = DateTime.now(); //กำหนดเวลาเพื่อมาตั้งชื่อรูป
    final timestamp =
        '${now.year}-${now.month}-${now.day}_${now.hour}-${now.minute}-${now.second}';
    final path = '${directory.path}/drawing_image_$timestamp.png'; //กำหนดตำแหน่ง บันทึกรูปภาพ
    final file = File(path); //กำหนดไฟล์ที่อยุ่
    await file.writeAsBytes(buffer); //เขียนไฟล์

    final result = await PhotoManager.editor.saveImage( //บันทึกรูป จาก 'package:photo_manager/photo_manager.dart'
      file.readAsBytesSync(), //อ่านไฟล์
      filename: '/drawing_image_$timestamp.png',//ชื่อไฟล์
    );

    if (result != null) { //เช็คว่า มีรูปไหม
      ScaffoldMessenger.of(context).showSnackBar(//แสดงข้อความเมื่อบันทึกสำเร็จ
        SnackBar(content: Text('Save image')),
      );

      // print(savedControllers[0].toString());


      if (newDrawing == true) { //เช็คว่าเป็นรูปใหม่หรือรูปที่แก้ไข 
        // สร้างวันที่และเวลาปัจจุบัน
        final now = DateTime.now();
        final formatter = DateFormat('yyyyMMdd_HHmmss');
        final dateTimeString = formatter.format(now);
        _SaveJsonListNew(dateTimeString); //ถ้าเป็นรูปใหม่บันทึกไฟล์ json พร้อมตั้งชื่อใหม่
      } else {
        _SaveJsonListNew(editFileName); //ถ้าไม่ ชื่อชื่อเดิม
      }

      Future.delayed(Duration(seconds: 2), () { //delay 2 วิเพื่อแสดงข้อความ จาก ScaffoldMessenger
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Main()), // เปลี่ยนเป็นหน้าที่ต้องการ
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar( //บันทึกรูปไม่สำเร็จ
        SnackBar(content: Text('Failed to save image')),
      );
    }
  } catch (e) { //catch ข้อผิดพาด
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to save image: $e')),
    );
  }
}


//ฟังชั่นในการ save json 
Future<void> _SaveJsonListNew(String name) async {
  try {
    // รับข้อมูล JSON จาก DrawingController
    String jsonString = const JsonEncoder.withIndent('  ')
        .convert(drawingController.getJsonList());

    // กำหนดพาธสำหรับบันทึกไฟล์ (เปลี่ยนพาธตามต้องการ)
    final directory = Directory.systemTemp; // ใช้ไดเรกทอรี temp ของระบบ
    final filePath = '${directory.path}/$name.json';

    // สร้างไฟล์และเขียนข้อมูล JSON ลงในไฟล์
    final file = File(filePath);
    await file.writeAsString(jsonString);

    print('ข้อมูล JSON ถูกบันทึกลงในไฟล์ที่ $filePath');
  } catch (e) {
    print('เกิดข้อผิดพลาดในการบันทึกข้อมูล JSON: $e');
  }
}
