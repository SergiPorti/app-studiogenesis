import 'package:app_studiogenesis/data/data_source/api_data_source.dart';
import 'package:app_studiogenesis/domain/models/exception/failure.dart';
import 'package:app_studiogenesis/domain/models/ticket/ticket.dart';
import 'package:app_studiogenesis/domain/services/interfaces/ticket/ticket_service_interface.dart';
import 'package:dartz/dartz.dart';

class TicketService implements TicketServiceInterface {
  final ApiDataSource api = ApiDataSource();
  @override
  Future<Either<Failure, List<Ticket>>> searchTicket(String query) async {
    final res = await api.searchTicket(query);
    return res.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, List<Ticket>>> getTickets() async {
    final res = await api.getTickets();
    return res.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, List<Ticket>>> deleteTicket(int ticketId) async {
    Map<String, int> map = {};
    map["id"] = ticketId;

    final res = await api.deleteTicket(map);
    return res.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, String>> updateTicket(Ticket ticket) async {
    final res = await api.updateTicket(ticket);

    return res.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, Ticket>> createTicket(
      Map<String, dynamic> ticketData) async {
    final res = await api.createTicket(ticketData);

    return res.fold((l) => Left(l), (r) => Right(r));
  }
}
