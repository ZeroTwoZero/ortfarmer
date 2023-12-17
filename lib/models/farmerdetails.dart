import 'package:ortfarmer/models/crophealthstatus.dart';
import 'package:ortfarmer/models/cropstatus.dart';
import 'package:ortfarmer/models/evaluation.dart';
import 'package:ortfarmer/models/gender.dart';
import 'package:ortfarmer/models/soiltype.dart';
import 'package:ortfarmer/models/typeenum.dart';
import 'package:ortfarmer/models/yieldacceptability.dart';

class FarmerDetails {
  final String name,
      address,
      mobile,
      surveynumber,
      district,
      block,
      village,
      crop,
      culture,
      populationStudy,
      yield,
      pincode;
  final int age, farmSize;
  final DateTime dateOfSowing, yieldDate, dateOfFlowering;
  final Evaluation evaluation;
  final CropStatus cropStatus;
  final YieldAcceptability yieldAcceptability;
  final Gender gender;
  final TypeEnum type;
  final SoilType soilType;
  final String? photo1, photo2;
  final CropHealthStatus cropHealthStatus;
  FarmerDetails(
    this.name,
    this.address,
    this.age,
    this.mobile,
    this.surveynumber,
    this.district,
    this.block,
    this.village,
    this.crop,
    this.culture,
    this.dateOfSowing,
    this.evaluation,
    this.populationStudy,
    this.dateOfFlowering,
    this.cropStatus,
    this.yieldDate,
    this.yield,
    this.yieldAcceptability,
    this.gender,
    this.cropHealthStatus,
    this.farmSize,
    this.type,
    this.soilType,
    this.pincode, {
    this.photo1,
    this.photo2,
  });
}
