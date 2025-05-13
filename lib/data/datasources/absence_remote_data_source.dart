import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import '../models/absence_model.dart';
import '../models/member_model.dart';

abstract class AbsenceRemoteDataSource {
  Future<List<AbsenceModel>> getAbsences();
  Future<AbsenceModel> getAbsenceById(String id);
  Future<List<MemberModel>> getMembers();
}

@Injectable(as: AbsenceRemoteDataSource)
class AbsenceRemoteDataSourceImpl implements AbsenceRemoteDataSource {
  @override
  Future<List<AbsenceModel>> getAbsences() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    
    final jsonString = await rootBundle.loadString('assets/absences.json');
    final jsonData = json.decode(jsonString);
    final List<dynamic> absencesJson = jsonData['payload'];
    return absencesJson.map((json) => AbsenceModel.fromJson(json)).toList();
  }

  @override
  Future<AbsenceModel> getAbsenceById(String id) async {
    await Future.delayed(const Duration(milliseconds: 400));
    
    final absences = await getAbsences();
    return absences.firstWhere((absence) => absence.id.toString() == id);
  }

  @override
  Future<List<MemberModel>> getMembers() async {
    await Future.delayed(const Duration(milliseconds: 400));
    
    final jsonString = await rootBundle.loadString('assets/members.json');
    final jsonData = json.decode(jsonString);
    final List<dynamic> membersJson = jsonData['payload'];
    return membersJson.map((json) => MemberModel.fromJson(json)).toList();
  }
} 