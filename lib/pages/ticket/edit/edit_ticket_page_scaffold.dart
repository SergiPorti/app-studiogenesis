import 'package:app_studiogenesis/domain/models/ticket/ticket.dart';
import 'package:app_studiogenesis/generated/l10n.dart';
import 'package:app_studiogenesis/pages/language/language_manager.dart';
import 'package:app_studiogenesis/pages/ticket/edit/edit_ticket_page.dart';
import 'package:app_studiogenesis/pages/ticket/ticket_manager.dart';
import 'package:app_studiogenesis/pages/widgets/appbar/app_bar_default.dart';
import 'package:app_studiogenesis/pages/widgets/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditTicketPageScaffold extends StatelessWidget {
  final Ticket ticket;
  const EditTicketPageScaffold(this.ticket, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.generalBackground,
      appBar: AppBarDefault(title: Text(S.of(context).editTicket)),
      body: MultiProvider(providers: [
        ChangeNotifierProvider<LanguageManager>(
            create: (context) => LanguageManager()),
        ChangeNotifierProvider<TicketManager>(
            create: (context) => TicketManager())
      ], child: EditTicketPage(ticket: ticket)),
    );
  }
}
