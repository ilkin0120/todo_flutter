import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  /// [CustomButton] widget is s customizable button widget.
  ///
  /// It accepts various parameters such as the button label, icon, style,
  ///
  /// and behavior to allow for flexibility and customization.
  ///
  /// [label] and [onClick] are required
  const CustomButton({
    Key? key,
    this.padding,
    this.reverse = false,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.loading = false,
    this.enabled = true,
    this.margin,
    this.width,
    this.spaceMargin,
    this.height,
    this.icon,
    this.buttonStyle,
    required this.label,
    required this.onClick,
  }) : super(key: key);

  /// The label text to display on the button
  final Text label;

  /// Whether the button is currently in a loading state.
  ///
  /// If `true` it can't be clicked. Default is `false`.
  final bool loading;

  /// Whether the button is currently enabled and can be clicked.
  ///
  /// Default is `true`.
  final bool enabled;

  /// The callback function to execute when the button is clicked.
  final VoidCallback onClick;

  /// Whether to display the icon.
  ///
  /// If `true` before the label text otherwise after.
  final bool reverse;

  /// Optional custom decoration for the button
  final BoxDecoration? buttonStyle;

  /// Optional padding for the button content
  final EdgeInsets? padding;

  /// Optional icon to display on the button
  final Icon? icon;

  /// Optional height for the button
  final double? height;

  /// Optional width for the button
  final double? width;

  /// How to align the button content along the main axis (horizontal). Default is [MainAxisAlignment.center]
  final MainAxisAlignment mainAxisAlignment;

  // How much space the button should take up along the main axis. Default is [MainAxisSize.max]
  final MainAxisSize mainAxisSize;

  /// Optional space between the icon and label text
  final double? spaceMargin;

  /// Optional margin for the button
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // Remove the splash effect when the button is clicked
      splashColor: Colors.transparent,
      // Remove the highlight effect when the button is pressed
      highlightColor: Colors.transparent,
      // Execute the callback function only if the button is enabled and not loading
      onTap: () => (enabled && !loading) ? onClick() : null,
      child: Container(
        margin: margin,
        width: width,
        height: height,
        padding: padding,
        decoration: buttonStyle,
        child: _content(context),
      ),
    );
  }

  Widget _getIcon() {
    // If an icon is provided, return it, otherwise return SizedBox
    return icon ?? const SizedBox();
  }

  Widget _content(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Display the icon before the label text if reverse is false
        if (!reverse) _getIcon(),
        if (spaceMargin != null)
          SizedBox(
            width: spaceMargin,
          ),
        label,
        // Display the icon after the label text if reverse is true
        if (reverse) _getIcon(),
      ],
    );
  }
}
