import 'package:json_annotation/json_annotation.dart';

part 'drawing_model.g.dart';


//หน้าในการ แปลงไฟล์ json เป็น obj ของ dart โดยใช้ json_serializable
@JsonSerializable()
class PaintData { //ค่าต่างๆในไฟล์ json ที่วาด เช่น สี ขนาดเส้น 
  final int blendMode;
  final int color;
  final int filterQuality;
  final bool invertColors;
  final bool isAntiAlias;
  final int strokeCap;
  final int strokeJoin;
  final double strokeWidth;
  final int style;

  PaintData({
    required this.blendMode,
    required this.color,
    required this.filterQuality,
    required this.invertColors,
    required this.isAntiAlias,
    required this.strokeCap,
    required this.strokeJoin,
    required this.strokeWidth,
    required this.style,
  });

  factory PaintData.fromJson(Map<String, dynamic> json) => _$PaintDataFromJson(json);
  Map<String, dynamic> toJson() => _$PaintDataToJson(this);
}

@JsonSerializable()
class StepData { //ประเภท //ตำแหน่ง x y
  final String type;
  final double x;
  final double y;

  StepData({
    required this.type,
    required this.x,
    required this.y,
  });

  factory StepData.fromJson(Map<String, dynamic> json) => _$StepDataFromJson(json);
  Map<String, dynamic> toJson() => _$StepDataToJson(this);
}

@JsonSerializable()
class PathData {
  final int fillType;
  final List<StepData> steps;

  PathData({
    required this.fillType,
    required this.steps,
  });

  factory PathData.fromJson(Map<String, dynamic> json) => _$PathDataFromJson(json); //แปลงข้อมูลต่างๆ
  Map<String, dynamic> toJson() => _$PathDataToJson(this);
}

@JsonSerializable()
class Simple {
  final String type;
  final PathData path;
  final PaintData paint;

  Simple({
    required this.type,
    required this.path,
    required this.paint,
  });

  factory Simple.fromJson(Map<String, dynamic> json) => _$SimpleFromJson(json);
  Map<String, dynamic> toJson() => _$SimpleToJson(this);
}
