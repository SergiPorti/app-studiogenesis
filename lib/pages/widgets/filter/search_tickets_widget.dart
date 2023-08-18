import 'package:app_studiogenesis/generated/l10n.dart';
import 'package:app_studiogenesis/pages/ticket/ticket_manager.dart';
import 'package:app_studiogenesis/pages/widgets/input_text.dart';
import 'package:app_studiogenesis/pages/widgets/utils/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchTicketsWidget extends StatefulWidget {
  const SearchTicketsWidget({super.key});

  @override
  State<SearchTicketsWidget> createState() => _SearchTicketsWidgetState();
}

class _SearchTicketsWidgetState extends State<SearchTicketsWidget> {
  bool isFilterTicketsPressed = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Consumer<TicketManager>(
      builder: (context, manager, child) {
        return GestureDetector(
          onTap: () {
            setState(() {
              isFilterTicketsPressed = !isFilterTicketsPressed;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.linear,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimensions.xmain)),
            width: isFilterTicketsPressed ? size.width : 100,
            height: isFilterTicketsPressed ? 88 : 30,
            child: isFilterTicketsPressed
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InputText(
                        enabled: true,
                        placeHolder: S.of(context).searchTicket,
                        initialValue: manager.lastQuery,
                        prefixIcon: const Icon(
                          Icons.search,
                          size: 32,
                          color: Colors.grey,
                        ),
                        onChangedText: (value) => manager.searchTicket(value),
                      ),
                      SizedBox(height: AppDimensions.small),
                      const Icon(
                        Icons.arrow_drop_up,
                        color: Colors.yellow,
                        size: 32,
                      )
                    ],
                  )
                : Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      children: [
                        Container(
                          decoration: !isFilterTicketsPressed
                              ? const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.yellow, width: 1)),
                                )
                              : null,
                          child: Text(
                            S.of(context).filter,
                            style: TextStyle(
                                fontSize: AppDimensions.large,
                                color: Colors.yellow),
                          ),
                        ),
                        SizedBox(width: AppDimensions.small),
                        const Icon(
                          Icons.arrow_drop_down,
                          size: 28,
                          color: Colors.yellow,
                        )
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
