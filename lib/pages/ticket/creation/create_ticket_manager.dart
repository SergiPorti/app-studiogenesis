import 'package:app_studiogenesis/domain/models/ticket/ticket.dart';
import 'package:app_studiogenesis/domain/services/ticket/ticket_service.dart';
import 'package:flutter/material.dart';

class CreateTicketManager with ChangeNotifier {
  final TicketService service = TicketService();
  String _ticketName = "";
  String _ticketDescription = "";
  String _eventDate = "";

  double _ticketPrice = 0.0;

  Ticket? _ticket;

  bool _showInputs = false;
  bool _errorTicketName = false;
  bool _errorTicketDescription = false;
  bool _errorEventDate = false;
  bool _errorTicketPrice = false;

  CreateTicketState _currentState = OnAccessPageState();

  String get ticketName => _ticketName;
  String get ticketDescription => _ticketDescription;
  String get eventDate => _eventDate;

  double get ticketPrice => _ticketPrice;

  bool get showInptus => _showInputs;
  bool get errorTicketName => _errorTicketName;
  bool get errorTicketDescription => _errorTicketDescription;
  bool get errorEventDate => _errorEventDate;
  bool get errorTicketPrice => _errorTicketPrice;

  CreateTicketState get currentState => _currentState;

  onChangeInputState() {
    _showInputs = !_showInputs;
    if (_showInputs) {
      _currentState = OnShowCreateTicketInputsState();
    } else {
      if (_ticket != null) {
        _currentState = OnTicketCreated(_ticket);
      } else {
        _currentState = OnAccessPageState();
      }
    }
    notifyListeners();
  }

  onTicketNameChanged(String value) {
    _ticketName = value;
  }

  onTicketDescriptionChanged(String value) {
    _ticketDescription = value;
  }

  onEventDateChosen(DateTime value) {
    _eventDate = value.toString();
  }

  onTicketPriceChanged(String value) {
    _ticketPrice = double.parse(value);
  }

  checkIfCanCreateTicket() {
    if (_ticketName.isEmpty) {
      _errorTicketName = true;
    } else {
      _errorTicketName = false;
    }

    if (_ticketDescription.isEmpty) {
      _errorTicketDescription = true;
    } else {
      _errorTicketDescription = false;
    }

    if (_eventDate.isEmpty) {
      _errorEventDate = true;
    } else {
      _errorEventDate = false;
    }

    if (_ticketPrice == 0.0) {
      _errorTicketPrice = true;
    } else {
      _errorTicketPrice = false;
    }
    notifyListeners();
  }

  createTicket() async {
    checkIfCanCreateTicket();
    if (!_errorEventDate &&
        !_errorTicketDescription &&
        !_errorTicketName &&
        !_errorTicketPrice) {
      Map<String, dynamic> map = {};
      map["name"] = _ticketName;
      map["description"] = _ticketDescription;
      map["event_date"] = _eventDate;
      map["price"] = _ticketPrice;

      final res = await service.createTicket(map);

      res.fold(
          (l) => _currentState = OnTicketErrorCreated(
              message: l.message, extensionMessage: l.extensionMessage), (r) {
        _ticket = r;
        _showInputs = !_showInputs;
        _restartInputs();
        _currentState = OnTicketCreated(r);
      });
      notifyListeners();
    }
  }

  _restartInputs() {
    _eventDate = "";
    _ticketName = "";
    _ticketDescription = "";
    _ticketPrice = 0.0;
  }
}

abstract class CreateTicketState {}

class OnTicketCreated extends CreateTicketState {
  final Ticket? ticket;
  OnTicketCreated(this.ticket);
}

class OnLoadingState extends CreateTicketState {}

class OnAccessPageState extends CreateTicketState {}

class OnTicketErrorCreated extends CreateTicketState {
  final String message;
  final String? extensionMessage;
  OnTicketErrorCreated({required this.message, this.extensionMessage});
}

class OnShowCreateTicketInputsState extends CreateTicketState {}
