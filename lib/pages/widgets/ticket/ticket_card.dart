import 'package:app_studiogenesis/domain/models/ticket/ticket.dart';
import 'package:app_studiogenesis/pages/Tickets/ticket_manager.dart';
import 'package:app_studiogenesis/pages/language/language_manager.dart';
import 'package:app_studiogenesis/pages/widgets/utils/app_colors.dart';
import 'package:app_studiogenesis/pages/widgets/utils/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TicketCard extends StatelessWidget {
  final Ticket ticket;
  const TicketCard(this.ticket, {super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TicketManager>(
      builder: (context, manager, child) {
        return Container(
          decoration: BoxDecoration(
              color: AppColors.lightBackground,
              borderRadius: BorderRadius.circular(AppDimensions.xmain),
              boxShadow: [
                BoxShadow(
                    color: Colors.white.withOpacity(0.4),
                    blurRadius: AppDimensions.xmain,
                    spreadRadius: 2)
              ]),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: AppDimensions.main,
              horizontal: AppDimensions.main,
            ),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 6,
                          child: Text(
                            ticket.name,
                            style: TextStyle(
                                fontSize: AppDimensions.large,
                                fontWeight: FontWeight.w700,
                                color: Colors.black),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Text(_formatDate(context, ticket.eventDate),
                              style: TextStyle(
                                  fontSize: AppDimensions.main,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400)),
                        )
                      ],
                    ),
                    SizedBox(height: AppDimensions.xmain),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 6,
                          child: Text(
                            ticket.description,
                            style: TextStyle(
                                fontSize: AppDimensions.label,
                                color: AppColors.secondaryDisabledText,
                                fontWeight: FontWeight.w400),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Text('${ticket.price.toString()}€',
                              style: TextStyle(
                                  fontSize: AppDimensions.main,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400)),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(height: AppDimensions.xmain),
                const Divider(
                  height: 1,
                ),
                SizedBox(height: AppDimensions.xmain),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.edit,
                        color: AppColors.editIconColor,
                        size: 28,
                      ),
                    ),
                    SizedBox(width: AppDimensions.main),
                    InkWell(
                      onTap: () => manager.deleteTicket(ticket.id),
                      child: const Icon(
                        Icons.delete_outline_outlined,
                        color: AppColors.deleteIconColor,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatDate(BuildContext context, DateTime date) {
    final currentLocale = Provider.of<LanguageManager>(context, listen: false)
        .getCurrentLocale(context);
    return DateFormat.yMd(currentLocale).format(date);
  }
}
