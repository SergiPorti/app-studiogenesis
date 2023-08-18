import 'package:app_studiogenesis/domain/models/ticket/ticket.dart';
import 'package:app_studiogenesis/generated/l10n.dart';
import 'package:app_studiogenesis/pages/language/language_manager.dart';
import 'package:app_studiogenesis/pages/ticket/edit/edit_ticket_manager.dart';
import 'package:app_studiogenesis/pages/widgets/input_text.dart';
import 'package:app_studiogenesis/pages/widgets/popup/default_popup.dart';
import 'package:app_studiogenesis/pages/widgets/ticket/ticket_card.dart';
import 'package:app_studiogenesis/pages/widgets/error/custom_error_widget.dart';
import 'package:app_studiogenesis/pages/widgets/utils/app_colors.dart';
import 'package:app_studiogenesis/pages/widgets/utils/app_dimensions.dart';
import 'package:app_studiogenesis/pages/widgets/utils/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditTicketPage extends StatelessWidget {
  final Ticket ticket;
  EditTicketPage({required this.ticket, super.key});

  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;
    //TODO: Image
    return ChangeNotifierProvider<EditTicketManager>(
      create: (context) => EditTicketManager(ticket),
      child: Consumer<EditTicketManager>(builder: (context, manager, child) {
        _formatDate(context, manager.ticket.eventDate);

        switch (manager.currentState.runtimeType) {
          case OnTicketOpen:
            return SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.all(AppDimensions.main),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).preview,
                    style: TextStyle(
                      fontSize: AppDimensions.large,
                      fontWeight: FontWeight.w600,
                      color: AppColors.loginDisabledText,
                    ),
                  ),
                  SizedBox(height: AppDimensions.main),
                  TicketCard(
                    manager.ticket,
                    showIcons: false,
                  ),
                  SizedBox(height: sizeHeight * 0.07),
                  InputText(
                    inputBackgroundColor: Colors.transparent,
                    inputBorderColor: AppColors.secondaryBackgroundLogin,
                    label: S.of(context).ticketName,
                    placeHolder: S.of(context).writeNewTicketName,
                    onChangedText: (value) => manager.onChangeTicketName(value),
                  ),
                  SizedBox(height: AppDimensions.main),
                  InputText(
                    inputBackgroundColor: Colors.transparent,
                    inputBorderColor: AppColors.secondaryBackgroundLogin,
                    label: S.of(context).description,
                    placeHolder: S.of(context).writeNewDescription,
                    onChangedText: (value) =>
                        manager.onChangeDescriptionName(value),
                  ),
                  SizedBox(height: AppDimensions.main),
                  InputText(
                    label: S.of(context).eventDate,
                    inputBackgroundColor: Colors.transparent,
                    inputBorderColor: AppColors.secondaryBackgroundLogin,
                    placeHolder: S.of(context).chooseeEventDate,
                    sufixIcon: const Icon(
                      Icons.calendar_month_outlined,
                      size: 32,
                      color: Colors.white,
                    ),
                    controller: _dateController,
                    readOnly: true,
                    onTap: () => _displayDatePicker(context, manager),
                  ),
                  SizedBox(height: AppDimensions.main),
                  InputText(
                    inputBackgroundColor: Colors.transparent,
                    inputBorderColor: AppColors.secondaryBackgroundLogin,
                    label: S.of(context).ticketPrice,
                    placeHolder: S.of(context).writeTicketPrice,
                    textInputType: TextInputType.number,
                    onChangedText: (value) => manager.onChangePrice(value),
                  ),
                  SizedBox(height: AppDimensions.extraLarge),
                  MainButton(
                      text: S.of(context).updateTicket,
                      expandWidth: true,
                      onPressed: () {
                        debugPrint('Tapppppeed');
                        manager.onUpdateButtonPressed();
                      })
                ],
              ),
            ));
          case OnLoadingState:
            return const Center(child: CircularProgressIndicator());
          case OnErrorUpdate:
            final String message =
                (manager.currentState as OnErrorUpdate).message;
            final String? extensionMessage =
                (manager.currentState as OnErrorUpdate).extensionMessage;
            return CustomErrorWidget(
              message: message,
              extensionMessage: extensionMessage,
              onButtonPressed: () => Navigator.maybePop(context),
            );
          case OnUpdateTicketSuccesState:
            final String message =
                (manager.currentState as OnUpdateTicketSuccesState).message;
            return defaultPopup(context,
                title: S.of(context).congratulations,
                description: message,
                mainButtonText: S.of(context).goBack, mainbuttonPressed: () {
              Navigator.pop(context);
            });

          default:
            return const Center(child: CircularProgressIndicator());
        }
      }),
    );
  }

  _formatDate(BuildContext context, DateTime date) {
    final String currentLocale =
        Provider.of<LanguageManager>(context).getCurrentLocale(context);
    _dateController.text = DateFormat.yMd(currentLocale).format(date);
  }

  _displayDatePicker(BuildContext context, EditTicketManager manager) async {
    final languageManager =
        Provider.of<LanguageManager>(context, listen: false);
    final String currentLocale = languageManager.getCurrentLocale(context);
    final LocaleType localeType = languageManager.getLocaleType(currentLocale);

    final selectedDate = await DatePicker.showDatePicker(context,
        locale: localeType, minTime: DateTime(1900));

    if (selectedDate != null) {
      manager.onChangeEventDate(selectedDate);
      _dateController.text = DateFormat.yMd(currentLocale).format(selectedDate);
    }
  }
}
