import 'package:app_studiogenesis/domain/models/ticket/ticket.dart';
import 'package:app_studiogenesis/domain/services/ticket/ticket_service.dart';
import 'package:flutter/material.dart';

class TicketManager with ChangeNotifier {
  TicketManager() {
    _init();
  }

  final TicketService _service = TicketService();

  TicketManagerState _currentState = LoadingState();

  String _lastQuery = "";

  TicketManagerState get currentState => _currentState;
  String get lastQuery => _lastQuery;

  _init() {
    getTickets();
  }

  getTickets() async {
    _currentState = LoadingState();
    notifyListeners();
    final res = await _service.getTickets();

    res.fold(
        (l) => _currentState = OnErrorState(
            message: l.message, extensionMessage: l.extensionMessage),
        (r) => _currentState = OnTicketsAchievedState(r));

    notifyListeners();
  }

  deleteTicket(int ticketId) async {
    _currentState = LoadingState();
    notifyListeners();

    final res = await _service.deleteTicket(ticketId);
    res.fold(
        (l) => _currentState = OnErrorState(
            message: l.message, extensionMessage: l.extensionMessage),
        (r) => _currentState = OnTicketsAchievedState(r));

    notifyListeners();
  }

  searchTicket(String query) async {
    if ((query.length < 3 && query.isNotEmpty) || query == _lastQuery) {
      return null;
    }
    _lastQuery = query;

    final res = await _service.searchTicket(query);

    res.fold(
        (l) => _currentState = OnErrorState(
            message: l.message, extensionMessage: l.extensionMessage),
        (r) => _currentState = OnTicketsAchievedState(r));
    notifyListeners();
  }
}

abstract class TicketManagerState {}

class OnTicketsAchievedState extends TicketManagerState {
  final List<Ticket> tickets;
  OnTicketsAchievedState(this.tickets);
}

class OnErrorState extends TicketManagerState {
  final String message;
  final String? extensionMessage;
  OnErrorState({required this.message, this.extensionMessage});
}

class LoadingState extends TicketManagerState {}
