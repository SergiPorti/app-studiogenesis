import 'package:app_studiogenesis/di/locator.dart';
import 'package:app_studiogenesis/domain/models/ticket/ticket.dart';
import 'package:app_studiogenesis/generated/l10n.dart';
import 'package:app_studiogenesis/navigation/navigation_handler.dart';
import 'package:app_studiogenesis/pages/language/language_manager.dart';
import 'package:app_studiogenesis/pages/ticket/creation/create_ticket_manager.dart';
import 'package:app_studiogenesis/pages/widgets/error/custom_error_widget.dart';
import 'package:app_studiogenesis/pages/widgets/ticket/create_ticket_form.dart';
import 'package:app_studiogenesis/pages/widgets/ticket/ticket_card.dart';
import 'package:app_studiogenesis/pages/widgets/utils/app_colors.dart';
import 'package:app_studiogenesis/pages/widgets/utils/app_dimensions.dart';
import 'package:app_studiogenesis/pages/widgets/utils/main_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateTicketPage extends StatefulWidget {
  const CreateTicketPage({super.key});

  @override
  State<CreateTicketPage> createState() => _CreateTicketPageState();
}

class _CreateTicketPageState extends State<CreateTicketPage> {
  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CreateTicketManager>(
            create: (context) => CreateTicketManager()),
        ChangeNotifierProvider<LanguageManager>(
            create: (context) => LanguageManager())
      ],
      child: Consumer<CreateTicketManager>(
        builder: (context, manager, child) {
          final Widget principalBody = Padding(
            padding: EdgeInsets.all(AppDimensions.main),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: sizeHeight * 0.1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).createTicket,
                        style: TextStyle(
                            fontSize: AppDimensions.extraLarge,
                            color: AppColors.generalBorder,
                            fontWeight: FontWeight.w700),
                      ),
                      IconButton(
                          color: AppColors.secondaryBackgroundLogin,
                          onPressed: () => manager.onChangeInputState(),
                          icon: const Icon(
                            Icons.add_circle_outline,
                            color: AppColors.generalBorder,
                            size: 32,
                          ))
                    ],
                  ),
                ),
              ],
            ),
          );

          switch (manager.currentState.runtimeType) {
            case OnAccessPageState:
              return SingleChildScrollView(
                child: Column(
                  children: [
                    principalBody,
                    SizedBox(height: sizeHeight * 0.1),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: AppDimensions.main),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(AppDimensions.xmain),
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://media.tenor.com/XVWIZQh1Ge8AAAAC/make-a-ticket-ticket-tool.gif",
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const SizedBox(),
                          height: sizeHeight * 0.35,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    SizedBox(height: AppDimensions.extraLarge),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: AppDimensions.main),
                      child: MainButton(
                        expandWidth: true,
                        text: S.of(context).createTicket,
                        onPressed: () => manager.onChangeInputState(),
                      ),
                    )
                  ],
                ),
              );
            case OnLoadingState:
              return const Center(child: CircularProgressIndicator());
            case OnTicketErrorCreated:
              final String message =
                  (manager.currentState as OnTicketErrorCreated).message;
              final String? extensionMessage =
                  (manager.currentState as OnTicketErrorCreated)
                      .extensionMessage;
              return CustomErrorWidget(
                  message: message,
                  extensionMessage: extensionMessage,
                  onButtonPressed: () {
                    locator<NavigationHandler>().goToHomePage(context);
                  });
            case OnTicketCreated:
              final Ticket ticket =
                  (manager.currentState as OnTicketCreated).ticket!;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    principalBody,
                    SizedBox(height: AppDimensions.extraLarge),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: AppDimensions.main),
                      child: TicketCard(ticket, showIcons: false),
                    )
                  ],
                ),
              );
            case OnShowCreateTicketInputsState:
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    principalBody,
                    SizedBox(height: AppDimensions.extraLarge),
                    CreateTicketForm()
                  ],
                ),
              );
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
