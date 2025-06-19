// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/cores/config.dart';
import 'package:lovejourney/cores/models/select_item_model.dart';

class ListSelectWidget extends StatefulWidget {
  const ListSelectWidget({
    super.key,
    this.intiialIndex,
    required this.list,
    this.onChanged,
  });

  final int? intiialIndex;
  final List<SelectItemModel> list;

  final Function(int index)? onChanged;

  @override
  State<ListSelectWidget> createState() => _ListSelectWidgetState();
}

class _ListSelectWidgetState extends State<ListSelectWidget> {
  String selectKey = '';

  final weightButton = (Device.width / 3) - 10;

  @override
  void initState() {
    super.initState();
    if (widget.intiialIndex != null) {
      selectKey = widget.list[widget.intiialIndex!].name;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 10,
        children: List.generate(
          widget.list.length,
          (index) => GestureDetector(
            onTap: () => setState(() {
              selectKey = widget.list[index].name;
              widget.onChanged?.call(index);
            }),
            child: Container(
              height: 150,
              width: weightButton,
              decoration: BoxDecoration(
                color: theme.cardColor.withValues(alpha: .15),
                borderRadius: BorderRadius.circular(Configs.commonRadius),
                border: Border.all(
                  color: selectKey == widget.list[index].name
                      ? AppColors.accentDark
                      : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      spacing: 5,
                      children: [
                        Text(
                          widget.list[index].name,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          widget.list[index].price,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              minimumSize: Size.zero,
                              backgroundColor: Color(0xff9137FF),
                            ),
                            child: Text(
                              '3 Days Trial',
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(color: Colors.white),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
