import 'package:app_studiogenesis/domain/models/ticket/ticket.dart';
import 'package:app_studiogenesis/domain/services/ticket/ticket_service.dart';
import 'package:flutter/material.dart';

class EditTicketManager with ChangeNotifier {
  EditTicketManager(Ticket ticket) : _ticket = ticket {
    _init();
  }

  Ticket _ticket;

  EditTicketState _currentState = OnTicketOpen();

  String _firstTicketName = "";
  String _firstTicketDescription = "";
  double _firstTicketPrice = 0.0;

  final TicketService service = TicketService();

  Ticket get ticket => _ticket;

  EditTicketState get currentState => _currentState;

  _init() {
    _firstTicketName = _ticket.name;
    _firstTicketDescription = _ticket.name;
    _firstTicketPrice = _ticket.price;
    notifyListeners();
  }

  onChangeTicketName(String value) {
    if (value.isNotEmpty) {
      _ticket = _ticket.copyWith(name: value);
    } else {
      _ticket = _ticket.copyWith(name: _firstTicketName);
    }
    notifyListeners();
  }

  onChangeDescriptionName(String value) {
    if (value.isNotEmpty) {
      _ticket = _ticket.copyWith(description: value);
    } else {
      _ticket = _ticket.copyWith(description: _firstTicketDescription);
    }
    notifyListeners();
  }

  onChangeEventDate(DateTime value) {
    _ticket = _ticket.copyWith(eventDate: value);
    notifyListeners();
  }

  onChangePrice(String value) {
    if (value.isNotEmpty) {
      double price = double.parse(value);
      _ticket = _ticket.copyWith(price: price);
    } else {
      _ticket = _ticket.copyWith(price: _firstTicketPrice);
    }

    notifyListeners();
  }

  onUpdateButtonPressed() async {
    _currentState = OnLoadingState();
    notifyListeners();

    final res = await service.updateTicket(_ticket);

    res.fold(
        (l) => _currentState = OnErrorUpdate(
            message: l.message, extensionMessage: l.extensionMessage),
        (r) => _currentState = OnUpdateTicketSuccesState(r));
    notifyListeners();
  }
}

abstract class EditTicketState {}

class OnTicketOpen extends EditTicketState {}

class OnErrorUpdate extends EditTicketState {
  final String message;
  final String? extensionMessage;
  OnErrorUpdate({required this.message, this.extensionMessage});
}

class OnUpdateTicketSuccesState extends EditTicketState {
  final String message;
  OnUpdateTicketSuccesState(this.message);
}

class OnLoadingState extends EditTicketState {}
