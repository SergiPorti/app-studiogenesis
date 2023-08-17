import 'package:app_studiogenesis/domain/models/exception/failure.dart';
import 'package:app_studiogenesis/domain/models/ticket/ticket.dart';
import 'package:app_studiogenesis/domain/models/user/auth_user.dart';
import 'package:app_studiogenesis/domain/models/user/user.dart';
import 'package:dartz/dartz.dart';

abstract class ApiDataSourceInterface {
  Future<Either<Failure, List<Ticket>>> getTickets();

  Future<Either<Failure, AuthUser>> login(Map<String, String> userData);

  Future<Either<Failure, User>> me();

  Future<Either<Failure, AuthUser>> register(Map<String, String> userData);

  Future<Either<Failure, List<Ticket>>> searchTicket(String query);
  Future<Either<Failure, List<Ticket>>> deleteTicket(Map<String, int> data);
  Future<Either<Failure, String>> logout();
}
