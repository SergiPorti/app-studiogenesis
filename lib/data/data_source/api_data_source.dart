import 'package:app_studiogenesis/data/data_source/api_client.dart';
import 'package:app_studiogenesis/data/data_source/api_data_source_interface.dart';
import 'package:app_studiogenesis/domain/models/exception/failure.dart';
import 'package:app_studiogenesis/domain/models/ticket/ticket.dart';
import 'package:app_studiogenesis/domain/models/user/auth_user.dart';
import 'package:app_studiogenesis/domain/models/user/user.dart';
import 'package:dartz/dartz.dart';

class ApiDataSource implements ApiDataSourceInterface {
  final ApiClient apiClient = ApiClient();

  @override
  Future<Either<Failure, AuthUser>> login(Map<String, String> userData) async {
    final res = await apiClient.post('login', userData);

    return res.fold((l) => Left(l), (r) {
      final AuthUser authUser = AuthUser.fromJson(r);
      return Right(authUser);
    });
  }

  @override
  Future<Either<Failure, User>> me() async {
    final res = await apiClient.get('me');
    return res.fold((l) => Left(l), (r) {
      final User user = User.fromJson(r);
      return Right(user);
    });
  }

  @override
  Future<Either<Failure, AuthUser>> register(
      Map<String, String> userData) async {
    final res = await apiClient.post('register', userData);

    return res.fold((l) => Left(l), (r) {
      final AuthUser authUser = AuthUser.fromJson(r);
      return Right(authUser);
    });
  }

  @override
  Future<Either<Failure, List<Ticket>>> searchTicket(String query) async {
    final res = await apiClient.get('tickets/search?pharam=$query');

    return res.fold((l) => Left(l), (r) {
      final List<Ticket> tickets = [];
      (r["tickets"] as List)
          .map((value) => Ticket.fromJson(value))
          .toList()
          .forEach((ticket) => tickets.add(ticket));
      return Right(tickets);
    });
  }

  @override
  Future<Either<Failure, List<Ticket>>> getTickets() async {
    final res = await apiClient.get('tickets');
    return res.fold((l) => Left(l), (r) {
      final List<Ticket> tickets = [];
      (r["tickets"] as List)
          .map((value) => Ticket.fromJson(value))
          .toList()
          .forEach((ticket) => tickets.add(ticket));
      return Right(tickets);
    });
  }

  @override
  Future<Either<Failure, List<Ticket>>> deleteTicket(
      Map<String, int> data) async {
    final res = await apiClient.delete('tickets/delete', data);

    return res.fold((l) => Left(l), (r) {
      final List<Ticket> tickets = [];
      (r["tickets"] as List)
          .map((value) => Ticket.fromJson(value))
          .toList()
          .forEach((ticket) => tickets.add(ticket));
      return Right(tickets);
    });
  }

  @override
  Future<Either<Failure, String>> logout() async {
    final res = await apiClient.post('logout', {});

    return res.fold((l) => Left(l), (r) => Right(r["message"] as String));
  }

  @override
  Future<Either<Failure, String>> updateTicket(Ticket ticket) async {
    final Map<String, dynamic> map = Ticket.toJson(ticket);
    final res = await apiClient.post("tickets/update", map);

    return res.fold((l) => Left(l), (r) => Right(r["message"] as String));
  }

  @override
  Future<Either<Failure, Ticket>> createTicket(
      Map<String, dynamic> ticketData) async {
    final res = await apiClient.post("tickets/create", ticketData);

    return res.fold((l) => Left(l), (r) {
      final Ticket ticket = Ticket.fromJson(r["ticket"]);
      return Right(ticket);
    });
  }
  
  @override
  Future<Either<Failure, User>> updatePassword(Map<String, String> userData) async {
    final res = await apiClient.post("update-password", userData);

    return res.fold((l) => Left(l), (r) {
      final User user = User.fromJson(r["user"]);
      return Right(user);
    });
  }
  
  @override
  Future<Either<Failure, User>> updateUser(Map<String, String> userData) async {
    final res = await apiClient.post("update", userData);

    return res.fold((l) => Left(l), (r) {
      final User user = User.fromJson(r["user"]);
      return Right(user);
    });
  }
}
