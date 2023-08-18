import 'package:app_studiogenesis/domain/models/ticket/ticket.dart';
import 'package:app_studiogenesis/pages/ticket/ticket_manager.dart';
import 'package:app_studiogenesis/pages/language/language_manager.dart';
import 'package:app_studiogenesis/pages/widgets/filter/search_tickets_widget.dart';
import 'package:app_studiogenesis/pages/widgets/ticket/ticket_card.dart';
import 'package:app_studiogenesis/pages/widgets/ticket/ticket_error_widget.dart';
import 'package:app_studiogenesis/pages/widgets/utils/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TicketsPage extends StatelessWidget {
  const TicketsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LanguageManager>(
            create: (context) => LanguageManager()),
        ChangeNotifierProvider<TicketManager>(
            create: (context) => TicketManager())
      ],
      child: Consumer<TicketManager>(
        builder: (context, manager, child) {
          switch (manager.currentState.runtimeType) {
            case LoadingState:
              return const Center(child: CircularProgressIndicator());
            case OnErrorState:
              final String message =
                  (manager.currentState as OnErrorState).message;
              final String? extensionMessage =
                  (manager.currentState as OnErrorState).extensionMessage;

              return TicketErrorWidget(
                message: message,
                extensionMessage: extensionMessage,
                onButtonPressed: () => manager.getTickets(),
              );
              
            case OnTicketsAchievedState:
              final List<Ticket> tickets =
                  (manager.currentState as OnTicketsAchievedState).tickets;
              return SingleChildScrollView(
                  child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: AppDimensions.large,
                    horizontal: AppDimensions.main),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SearchTicketsWidget(),
                    SizedBox(height: AppDimensions.main),
                    const Divider(height: 1),
                    SizedBox(height: AppDimensions.large),
                    ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        primary: false,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final ticket = tickets[index];
                          return TicketCard(
                            ticket,
                            onDeleteButtonPressed: () =>
                                manager.deleteTicket(ticket.id),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: AppDimensions.main),
                        itemCount: tickets.length)
                  ],
                ),
              ));
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
