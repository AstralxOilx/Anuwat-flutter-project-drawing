import 'dart:convert';
import 'dart:io';
import 'package:drawnig_flutter/globalvariable.dart';
import 'package:drawnig_flutter/main.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<void> saveDrawing({
  required BuildContext context,
  required bool newDrawing,
}) async {
  try {
    // รับข้อมูลภาพจาก DrawingController
    final byteData = await drawingController.getImageData();

    // ตรวจสอบว่า byteData เป็น null หรือไม่
    if (byteData != null) {
      final buffer =
          byteData.buffer.asUint8List(); // แปลง ByteData เป็น Uint8List

      // ดึงที่อยู่ของ directory ที่ใช้ในการบันทึกรูป
      final directory = await getTemporaryDirectory();
      final now = DateTime.now(); // รับวันที่และเวลา
      final timestamp =
          '${now.year}-${now.month}-${now.day}_${now.hour}-${now.minute}-${now.second}';
      final path =
          '${directory.path}/drawing_image_$timestamp.png'; // กำหนดเส้นทางไฟล์
      final file = File(path); // สร้างไฟล์ที่เส้นทางกำหนด
      await file.writeAsBytes(buffer); // เขียนข้อมูลลงในไฟล์

      // ใช้ PhotoManager ในการบันทึกรูปลงในอัลบั้มภาพ
      final result = await PhotoManager.editor.saveImage(
        buffer, // ใช้ buffer ที่ได้จาก getImageData
        filename: '/drawing_image_$timestamp.png', // ตั้งชื่อไฟล์
      );

      if (result != null) {
        // เช็คว่าการบันทึกสำเร็จหรือไม่
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Save image')),
        );

        // ตรวจสอบว่าเป็นรูปใหม่หรือไม่
        if (newDrawing) {
          // สร้างวันที่และเวลาปัจจุบัน
          final formatter = DateFormat('yyyyMMdd_HHmmss');
          final dateTimeString = formatter.format(DateTime.now());
          _SaveJsonListNew(dateTimeString); // บันทึก JSON พร้อมชื่อใหม่
        } else {
          _SaveJsonListNew(editFileName); // บันทึก JSON ด้วยชื่อเดิม
        }

        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Main()), // เปลี่ยนหน้าหลังจากบันทึก
          );
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save image')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to retrieve image data')),
      );
    }
  } catch (e) {
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
