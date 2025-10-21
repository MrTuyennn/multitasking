import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multitasking/app/extensions/build_context_extension.dart';
import 'package:multitasking/app/l10n/l10n.dart';
import 'package:multitasking/presentation/bloc/translate/translate_cubit.dart';

class PopupMenuTranslate extends StatefulWidget {
  const PopupMenuTranslate({super.key});

  @override
  State<PopupMenuTranslate> createState() => _PopupMenuTranslateState();
}

class _PopupMenuTranslateState extends State<PopupMenuTranslate> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TranslateCubit, TranslateState>(
      builder: (context, state) {
        return PopupMenuButton<String>(
          icon: Text(context.locale.languageCode),
          position: PopupMenuPosition.under,
          onSelected: (String result) {
            context.read<TranslateCubit>().changeTranslate(Locale(result));
          },
          itemBuilder: (BuildContext context) {
            return L10n.all.map<PopupMenuEntry<String>>((locale) {
              final code = locale.languageCode;
              final country = locale.countryCode ?? '';
              final label = country.isEmpty ? code : '$code-$country';
              final isSelected =
                  context.locale.languageCode == code &&
                  context.locale.countryCode == locale.countryCode;
              return PopupMenuItem<String>(
                value: locale.languageCode.toString(),
                child: Row(
                  children: [
                    Text(label),
                    if (isSelected) const Icon(Icons.done),
                  ],
                ),
              );
            }).toList();
          },
        );
      },
    );
  }
}
