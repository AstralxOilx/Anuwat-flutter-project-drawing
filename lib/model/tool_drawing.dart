import 'package:drawnig_flutter/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:drawnig_flutter/globalvariable.dart';
import 'package:flutter_drawing_board/paint_contents.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ToolDrawing extends StatefulWidget {
  @override
  _ToolDrawingState createState() => _ToolDrawingState();
}

class _ToolDrawingState extends State<ToolDrawing> {
  ToolType _activeTool = ToolType.pencil; //กำหนดตัวแปร ToolType ให้เป็นปากกา
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                //สร้างเครื่องมือ ปากกา
                Tooltip(
                  message: "Pencil",
                  child: IconButton(
                    icon: Icon(MdiIcons.pencil),
                    color: _activeTool ==
                            ToolType
                                .pencil //เช็คว่าเลือกไหมถ้าใช่ ให้เป็นสีที่เลือก
                        ? selectedColor
                        : ColorPalette.darkGrey,
                    onPressed: () {
                      setState(() {
                        //ใช้  setState เพื่อ อัปเดตการเลือกการแสดงผล
                        drawingController.setPaintContent(
                            SimpleLine()); //กำหนดให้เครื่องมือเป็น SimpleLine คือเส้นการวาดทั่วไป
                        _activeTool = ToolType.pencil;
                        drawingController.setStyle(
                          //กำหนดสไตล์ ของเส้น
                          color:
                              selectedColor, //กำหนดสี ให้เป็นสีที่เลือกจาก selectedColor
                          strokeWidth:
                              strokeWidth, //กำหนดขนาดเส้นให้เป็นการเลือกจาก strokeWidth
                          isAntiAlias: true, //โหมดป้องกันรอยหยัก
                          style: PaintingStyle
                              .stroke, //มีแบบ PaintingStyle.fill ลงสีทึบ
                        );
                      });
                    },
                  ),
                ),
                Tooltip(
                  message: "Eraser",
                  child: IconButton(
                    icon: Icon(MdiIcons.eraserVariant),
                    color: _activeTool ==
                            ToolType
                                .eraser //เช็คว่าเลือกไหมถ้าใช่ ให้เป็นสีที่เลือก
                        ? ColorPalette.primary
                        : ColorPalette.darkGrey,
                    onPressed: () {
                      setState(() {
                        _activeTool = ToolType.eraser;
                        setState(() {
                          drawingController.setPaintContent(
                              Eraser()); //กำหนดให้เครื่องมือเป็น ยางลบ
                        });
                      });
                    },
                  ),
                ),
                Tooltip(
                    message: "StrokeWidth",
                    child: Container(
                      width: 100,
                      child: Slider(
                        //สไลล์
                        value: strokeWidth,
                        min: 0, //ค่าของสไลล์ต่ำสุด
                        max: 20, //สูงสุด
                        divisions:
                            20, //การช่วง เช่น ในค่ามากสุด 0- 20 แบ่งเป็น 20 จากตัวค่า 1,2,3,4...20 แต่ถ้าเป็น 40 จะได้ 0.5,1,1.5,2...20
                        onChanged: (value) {
                          setState(() {
                            strokeWidth =
                                value; //กำหนด strokeWidth ให้ทำกับค่าที่เลือกจาก  สไลล์
                            drawingController.setStyle(
                              color: selectedColor,
                              strokeWidth:
                                  strokeWidth, //กำนาดขนาดเส้นเป็น strokeWidth
                              isAntiAlias: true,
                              style: PaintingStyle.stroke,
                            );
                          });
                        },
                        label: strokeWidth.toStringAsFixed(2),
                      ),
                    )),
                SizedBox(
                  width: 50,
                  child: Tooltip(
                    message: "Selete Color",
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        //กำสไตล์ให้ Tooltip ElevatedButton
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      onPressed:
                          _openColorPicker, //เรียกใช้ฟังชั่น _openColorPicker
                      child: Icon(MdiIcons.palette, //กำสไตล์ให้ icon
                          size: 30,
                          color: selectedColor),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 50,
                  child: Tooltip(
                    message: "Undo",
                    child: IconButton(
                      icon: Icon(MdiIcons.undo),
                      color: ColorPalette.darkGrey,
                      onPressed: () {
                        setState(() {
                          drawingController
                              .undo(); //กำหนดเครื่องมือให้เป็น undo
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: Tooltip(
                    message: "Redo",
                    child: IconButton(
                      icon: Icon(MdiIcons.redo),
                      color: ColorPalette.darkGrey,
                      onPressed: () {
                        setState(() {
                          drawingController
                              .redo(); //กำหนดเครื่องมือให้เป็น redo
                        });
                      },
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }

  void _openColorPicker() {
    //ฟังชั่นในการเลือกสี
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //เป็น popup เด้นขึ้นมา
          title: Text('Select a color'),
          content: SingleChildScrollView(
            //ทำให้เลือนได้
            child: BlockPicker(
              //ถาดสีจาก package flutter_colorpicker
              pickerColor: selectedColor, // สีที่แสดงตอนเริ่ม
              onColorChanged: (Color color) {
                setState(() {
                  //กำหนด setState
                  selectedColor = color; //กำหนดสีให้เป็นสีที่เลือก
                  drawingController.setStyle(
                    color: selectedColor, //กำหนดสี
                    strokeWidth: strokeWidth,
                    isAntiAlias: true,
                    style: PaintingStyle.stroke,
                  );
                });
              },
            ),
          ),
          actions: <Widget>[
            // actions กำหนด ข้อความ Done เป็น TextButton เมือกด ปิดหน้า selectedColor หรือ ย้อนกลับมาหน้าวาดรูป
            TextButton(
              child: Text('Done'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
