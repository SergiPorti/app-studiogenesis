import 'package:app_studiogenesis/generated/l10n.dart';
import 'package:app_studiogenesis/pages/language/language_manager.dart';
import 'package:app_studiogenesis/pages/ticket/creation/create_ticket_manager.dart';
import 'package:app_studiogenesis/pages/widgets/input_text.dart';
import 'package:app_studiogenesis/pages/widgets/utils/app_colors.dart';
import 'package:app_studiogenesis/pages/widgets/utils/app_dimensions.dart';
import 'package:app_studiogenesis/pages/widgets/utils/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreateTicketForm extends StatelessWidget {
  CreateTicketForm({super.key});

  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer2<CreateTicketManager, LanguageManager>(
      builder: (context, manager, languageManager, child) {
        _checkDate(context, manager, languageManager);
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: AppDimensions.main),
          child: Column(
            children: [
              InputText(
                inputBackgroundColor: Colors.transparent,
                inputBorderColor: AppColors.secondaryBackgroundLogin,
                label: S.of(context).ticketName,
                placeHolder: S.of(context).writeNewTicketName,
                initialValue: manager.ticketName,
                errorText: manager.errorTicketName
                    ? S.of(context).fieldCanNotBeEmpty
                    : null,
                onChangedText: (value) => manager.onTicketNameChanged(value),
              ),
              SizedBox(height: AppDimensions.main),
              InputText(
                inputBackgroundColor: Colors.transparent,
                inputBorderColor: AppColors.secondaryBackgroundLogin,
                label: S.of(context).description,
                placeHolder: S.of(context).writeNewDescription,
                initialValue: manager.ticketDescription,
                errorText: manager.errorTicketDescription
                    ? S.of(context).fieldCanNotBeEmpty
                    : null,
                onChangedText: (value) =>
                    manager.onTicketDescriptionChanged(value),
              ),
              SizedBox(height: AppDimensions.main),
              InputText(
                label: S.of(context).eventDate,
                inputBackgroundColor: Colors.transparent,
                inputBorderColor: AppColors.secondaryBackgroundLogin,
                placeHolder: S.of(context).chooseeEventDate,
                errorText: manager.errorEventDate
                    ? S.of(context).fieldCanNotBeEmpty
                    : null,
                sufixIcon: const Icon(
                  Icons.calendar_month_outlined,
                  size: 32,
                  color: Colors.white,
                ),
                controller: _dateController,
                readOnly: true,
                onTap: () =>
                    _displayDatePicker(context, manager, languageManager),
              ),
              SizedBox(height: AppDimensions.main),
              InputText(
                inputBackgroundColor: Colors.transparent,
                inputBorderColor: AppColors.secondaryBackgroundLogin,
                label: S.of(context).ticketPrice,
                initialValue: manager.ticketPrice != 0.0
                    ? manager.ticketPrice.toString()
                    : null,
                errorText: manager.errorTicketPrice
                    ? S.of(context).fieldCanNotBeEmpty
                    : null,
                placeHolder: S.of(context).writeTicketPrice,
                textInputType: TextInputType.number,
                onChangedText: (value) => manager.onTicketPriceChanged(value),
              ),
              SizedBox(height: AppDimensions.extraLarge),
              MainButton(
                  text: S.of(context).createTicket,
                  expandWidth: true,
                  onPressed: () => manager.createTicket())
            ],
          ),
        );
      },
    );
  }

  _checkDate(BuildContext context, CreateTicketManager manager,
      LanguageManager languageManager) {
    if (manager.eventDate.isNotEmpty) {
      final String currentLocale = languageManager.getCurrentLocale(context);
      final DateTime date = DateTime.parse(manager.eventDate);
      final String dateFormatted = DateFormat.yMd(currentLocale).format(date);
      _dateController.text = dateFormatted;
    }
  }

  _displayDatePicker(BuildContext context, CreateTicketManager manager,
      LanguageManager languageManager) async {
    final String currentLocale = languageManager.getCurrentLocale(context);
    final LocaleType localeType = languageManager.getLocaleType(currentLocale);

    final selectedDate = await DatePicker.showDatePicker(context,
        locale: localeType, minTime: DateTime(1900));

    if (selectedDate != null) {
      final String dateFormatted =
          DateFormat.yMd(currentLocale).format(selectedDate);
      manager.onEventDateChosen(selectedDate);
      _dateController.text = dateFormatted;
    }
  }
}
