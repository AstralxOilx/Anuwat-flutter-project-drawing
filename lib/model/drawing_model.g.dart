// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drawing_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaintData _$PaintDataFromJson(Map<String, dynamic> json) => PaintData(
      blendMode: (json['blendMode'] as num).toInt(),
      color: (json['color'] as num).toInt(),
      filterQuality: (json['filterQuality'] as num).toInt(),
      invertColors: json['invertColors'] as bool,
      isAntiAlias: json['isAntiAlias'] as bool,
      strokeCap: (json['strokeCap'] as num).toInt(),
      strokeJoin: (json['strokeJoin'] as num).toInt(),
      strokeWidth: (json['strokeWidth'] as num).toDouble(),
      style: (json['style'] as num).toInt(),
    );

Map<String, dynamic> _$PaintDataToJson(PaintData instance) => <String, dynamic>{
      'blendMode': instance.blendMode,
      'color': instance.color,
      'filterQuality': instance.filterQuality,
      'invertColors': instance.invertColors,
      'isAntiAlias': instance.isAntiAlias,
      'strokeCap': instance.strokeCap,
      'strokeJoin': instance.strokeJoin,
      'strokeWidth': instance.strokeWidth,
      'style': instance.style,
    };

StepData _$StepDataFromJson(Map<String, dynamic> json) => StepData(
      type: json['type'] as String,
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
    );

Map<String, dynamic> _$StepDataToJson(StepData instance) => <String, dynamic>{
      'type': instance.type,
      'x': instance.x,
      'y': instance.y,
    };

PathData _$PathDataFromJson(Map<String, dynamic> json) => PathData(
      fillType: (json['fillType'] as num).toInt(),
      steps: (json['steps'] as List<dynamic>)
          .map((e) => StepData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PathDataToJson(PathData instance) => <String, dynamic>{
      'fillType': instance.fillType,
      'steps': instance.steps,
    };

Simple _$SimpleFromJson(Map<String, dynamic> json) => Simple(
      type: json['type'] as String,
      path: PathData.fromJson(json['path'] as Map<String, dynamic>),
      paint: PaintData.fromJson(json['paint'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SimpleToJson(Simple instance) => <String, dynamic>{
      'type': instance.type,
      'path': instance.path,
      'paint': instance.paint,
    };
