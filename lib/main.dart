import 'dart:io';

import 'package:drawnig_flutter/app_colors.dart';
import 'package:drawnig_flutter/drawing.dart';
import 'package:drawnig_flutter/edit_drawing.dart';
import 'package:drawnig_flutter/globalvariable.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

void main() {
  runApp(Main());
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    _loadFileNames();
  }

  List<String> _fileNames = [];
  Future<void> _loadFileNames() async {
    //โหลดชื่อไฟล์ json ที่บบันทึกไว้
    try {
      final directory = Directory.systemTemp; // ใช้ไดเรกทอรี temp ของระบบ
      final files = directory.listSync();

      setState(() {
        _fileNames = files
            .where((file) => file is File && file.path.endsWith('.json'))
            .map((file) {
          final fileNameWithExtension = file.uri.pathSegments.last;
          // แยกชื่อไฟล์จากนามสกุล
          final fileName = fileNameWithExtension.split('.').first;
          return fileName;
        }).toList();
      });
    } catch (e) {
      print('เกิดข้อผิดพลาดในการดึงรายชื่อไฟล์: $e');
    }
  }

  //ฟังชั่นในการ ลบ ไฟล์ json ที่บันทึกไว้
  Future<void> _deleteFile(String fileName) async {
    try {
      final directory = Directory.systemTemp; // ใช้ไดเรกทอรี temp ของระบบ
      final filePath = '${directory.path}/$fileName.json';
      final file = File(filePath);

      // ตรวจสอบว่าไฟล์มีอยู่หรือไม่
      if (await file.exists()) {
        await file.delete();
        print('ไฟล์ $fileName.json ถูกลบเรียบร้อยแล้ว');
        // อัปเดตรายชื่อไฟล์หลังจากลบ
        await _loadFileNames();
      } else {
        print('ไฟล์ $fileName.json ไม่พบ');
      }
    } catch (e) {
      print('เกิดข้อผิดพลาดในการลบไฟล์: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.black,
        title: const Text('Drawing',
            style: TextStyle(
                color: ColorPalette.white, fontWeight: FontWeight.bold)),
      ),
      body: ListView.builder(
        itemCount: _fileNames.length,
        itemBuilder: (context, index) {
          return ListTile(
              //แสดง list ไฟล์ ใช้ ListTile ที่ให้สำมารถเลือนได้
              title: Container(
            padding: EdgeInsets.all(10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: ColorPalette.black,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: ColorPalette.black,
                  ),
                  child: TextButton.icon(
                    //เมื่อกดเลือกไฟล์ที่จะแก้ไข
                    onPressed: () {
                      editFileName =
                          _fileNames[index]; //กำหนดชื่อไฟล์ที่จะใช้ในการแก้ไข
                      Navigator.pushReplacement(
                        //ลิ้งไปหน้าแก้ไข
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditDrawingApp(),
                        ),
                      );
                    },
                    icon: Icon(
                      MdiIcons.imageEdit,
                      color: ColorPalette.white.withOpacity(0.8),
                    ),
                    label: Text(
                      //แสดงชื่อไฟล์ที่จะแก้ไข
                      _fileNames[index],
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(color: ColorPalette.white),
                    ),
                  ),
                ),
                Container(
                  //การลบ
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: ColorPalette.grey.withOpacity(0.3),
                  ),
                  child: IconButton(
                      onPressed: () {
                        _deleteFile(_fileNames[index]); //ลบไฟล์ทีี่เลือก
                      },
                      icon: Icon(
                        //แสดง  iconการลบ
                        MdiIcons.deleteAlert,
                        color: ColorPalette.red.withOpacity(0.8),
                        size: 28,
                      )),
                )
              ],
            ),
          ));
        },
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked, //ปุ่มการสร้างหน้าวาด
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushReplacement(
                //ลิ้งไปหน้าการวาด
                context,
                MaterialPageRoute(builder: (context) => DrawingApp()));
          },
          backgroundColor: ColorPalette.black,
          foregroundColor: ColorPalette.white,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(22)), // กำหนดขอบโค้ง
          ),
          child: const ZoomTapAnimation(
              end: 0.8,
              begin: 1,
              child: Icon(
                Icons.add_to_photos_rounded,
                size: 30,
              ))),
      bottomNavigationBar: const BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: ColorPalette.black,
        notchMargin: 15, //การเว้นตรงกลาง สำหรับ floatingActionButtonLocation
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [],
        ),
      ),
    );
  }
}
