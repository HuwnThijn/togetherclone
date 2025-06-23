import 'package:flutter/material.dart';
import 'package:lovejourney/gen/assets.gen.dart';

class DatePickerInput extends StatelessWidget {
  const DatePickerInput({
    super.key,
    this.selectedDate,
    this.onTap,
    this.placeholder = 'DD/MM/YYYY',
    this.enabled = true,
    this.borderColor,
    this.backgroundColor = Colors.white,
    this.borderRadius = 14.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
    this.iconColor,
    this.textColor,
    this.placeholderColor,
    this.fontSize = 16.0,
    this.leadingIcon,
    this.trailingIcon,
    this.dateFormat,
  });

  final DateTime? selectedDate;
  final VoidCallback? onTap;
  final String placeholder;
  final bool enabled;
  final Color? borderColor;
  final Color backgroundColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final Color? iconColor;
  final Color? textColor;
  final Color? placeholderColor;
  final double fontSize;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final String Function(DateTime)? dateFormat;

  @override
  Widget build(BuildContext context) {
    final bool hasDate = selectedDate != null;
    final Color defaultIconColor = hasDate 
        ? (iconColor ?? Colors.black) 
        : (placeholderColor ?? Colors.grey);
    final Color defaultTextColor = hasDate 
        ? (textColor ?? Colors.black) 
        : (placeholderColor ?? Colors.grey);

    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: borderColor ?? Colors.grey.withOpacity(0.5),
          ),
        ),
        child: Row(
          children: [
            // Leading icon
            leadingIcon ?? 
            AssetsClass.icons.calenderClock.svg(
              width: 24,
              height: 24,
              color: defaultIconColor,
            ),
            
            const SizedBox(width: 12),
            
            // Date text
            Expanded(
              child: Text(
                _getDisplayText(),
                style: TextStyle(
                  color: defaultTextColor,
                  fontSize: fontSize,
                ),
              ),
            ),
            
            // Trailing icon
            trailingIcon ??
            AssetsClass.icons.arrowDown.svg(
              width: 8,
              height: 8,
              color: defaultIconColor,
            ),
          ],
        ),
      ),
    );
  }

  String _getDisplayText() {
    if (selectedDate == null) {
      return placeholder;
    }
    
    if (dateFormat != null) {
      return dateFormat!(selectedDate!);
    }
    
    // Default format: DD/MM/YYYY
    return "${selectedDate!.day.toString().padLeft(2, '0')}/"
           "${selectedDate!.month.toString().padLeft(2, '0')}/"
           "${selectedDate!.year}";
  }
}