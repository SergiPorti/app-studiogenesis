import 'package:app_studiogenesis/domain/models/exception/failure.dart';
import 'package:app_studiogenesis/domain/models/ticket/ticket.dart';
import 'package:dartz/dartz.dart';

abstract class TicketServiceInterface {
  Future<Either<Failure, List<Ticket>>> searchTicket(String query);
  Future<Either<Failure, List<Ticket>>> getTickets();
  Future<Either<Failure, List<Ticket>>> deleteTicket(int ticketId);
}
