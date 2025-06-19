import 'package:flutter/material.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/cores/config.dart';
import 'package:lovejourney/cores/shared.dart';
import 'package:lovejourney/l10n/l10n.dart';

class ChangedLanguageBottomsheet extends StatefulWidget {
  const ChangedLanguageBottomsheet({super.key});

  @override
  State<ChangedLanguageBottomsheet> createState() =>
      _ChangedLanguageBottomsheetState();
}

class _ChangedLanguageBottomsheetState
    extends State<ChangedLanguageBottomsheet> {
  String selectedLanguage = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedLanguage = Shared.instance.languageCode.languageCode;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.all(15),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              spacing: 15,
              children: [
                Text(
                  context.l10n.language,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Builder(builder: (context) {
                  final list = Shared.instance.listLanguage.entries.toList();
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: list.length,
                    itemBuilder: (context, index) => _buildItem(list[index]),
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(height: 10),
                  );
                }),
                Row(
                  spacing: 10,
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            context.l10n.cancel,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: AppColors.accentDark,
                                ),
                          )),
                    ),
                    Expanded(
                      child: TextButton(
                          onPressed: () =>
                              Navigator.pop(context, selectedLanguage),
                          style: TextButton.styleFrom(
                            backgroundColor: AppColors.accentDark,
                          ),
                          child: Text(
                            context.l10n.choose,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: Colors.white,
                                ),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(MapEntry<String, Map<String, String>> item) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedLanguage = item.key;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          spacing: 10,
          children: [
            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage(item.value['flag']!), fit: BoxFit.cover),
              ),
            ),
            Expanded(
              child: Text(
                '${item.value['name']}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            if (item.key == selectedLanguage)
              Icon(
                Icons.check,
                color: AppColors.accentDark,
              )
          ],
        ),
      ),
    );
  }
}
