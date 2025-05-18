import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:tafaling/core/types/typedef.dart';
import 'package:tafaling/core/utils/failure_mapper.dart';
import 'package:tafaling/features/onboarding/data/data_sources/onboarding_local_datasource.dart';
import 'package:tafaling/features/onboarding/domain/entities/onboarding_info_entity.dart';
import 'package:tafaling/features/onboarding/domain/repositories/onboarding_info_repository.dart';

class OnboardingInfoRepositoryImpl implements OnboardingInfoRepository {
  final OnboardingLocalDataSource localDataSource;

  OnboardingInfoRepositoryImpl({required this.localDataSource});

  @override
  ResultFuture<void> setOnboardingSeen(bool seen) async {
    try {
      localDataSource.setOnboardingSeen(seen);
      return Right(null);
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  ResultFuture<bool> getOnboardingSeen() async {
    try {
      return Right(await localDataSource.hasSeenOnboarding());
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }

  @override
  ResultFuture<List<OnboardingInfoEntity>> getOnboardingInfos(
    BuildContext context,
  ) async {
    try {
      return Right(await localDataSource.getOnboardingInfos(context));
    } catch (e) {
      return Left(FailureMapper.fromException(e));
    }
  }
}
