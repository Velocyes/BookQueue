import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CustomButtonOptions {
  const CustomButtonOptions({
    this.textStyle,
    this.elevation,
    this.height,
    this.width,
    this.padding,
    this.color,
    this.disabledColor,
    this.disabledTextColor,
    this.splashColor,
    this.iconSize,
    this.iconColor,
    this.iconPadding,
    this.borderRadius,
    this.borderSide,
  });

  final TextStyle textStyle;
  final double elevation;
  final double height;
  final double width;
  final EdgeInsetsGeometry padding;
  final Color color;
  final Color disabledColor;
  final Color disabledTextColor;
  final Color splashColor;
  final double iconSize;
  final Color iconColor;
  final EdgeInsetsGeometry iconPadding;
  final double borderRadius;
  final BorderSide borderSide;
}

class CustomButton extends StatelessWidget {
  CustomButton(
      {Key key,
      @required this.text,
      @required this.onPressed,
      this.icon,
      this.iconData,
      @required this.options,
      this.showLoadingIndicator = true,
      @required this.tag})
      : super(key: key);

  final String text;
  final Widget icon;
  final IconData iconData;
  final Function() onPressed;
  final CustomButtonOptions options;
  final bool showLoadingIndicator;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomButtonController>(
        init: CustomButtonController(
          this.text,
          this.icon,
          this.iconData,
          this.onPressed,
          this.options,
          this.showLoadingIndicator,
        ),
        tag: this.tag,
        builder: (controller) {
          Widget textWidget = controller.loading.value
              ? Center(
                  child: Container(
                    width: 23,
                    height: 23,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        controller.options.textStyle.color ?? Colors.white,
                      ),
                    ),
                  ),
                )
              : AutoSizeText(
                  controller.text,
                  style: controller.options.textStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                );

          final onPressed = controller.showLoadingIndicator
              ? () async {
                  if (controller.onPressed != null) {
                    if (controller.loading.value) {
                      return;
                    }
                    await controller.loadingToggle();
                    try {
                      await controller.onPressed();
                    } finally {
                      await controller.loadingToggle();
                    }
                  }
                }
              : () async {
                  if (controller.onPressed != null) {
                    await controller.onPressed();
                  }
                };

          if (controller.icon != null || controller.iconData != null) {
            textWidget = Flexible(child: textWidget);
            return Container(
              height: controller.options.height,
              width: controller.options.width,
              child: RaisedButton.icon(
                icon: Padding(
                  padding: controller.options.iconPadding ?? EdgeInsets.zero,
                  child: controller.icon ??
                      FaIcon(
                        controller.iconData,
                        size: controller.options.iconSize,
                        color: controller.options.iconColor ??
                            controller.options.textStyle.color,
                      ),
                ),
                label: textWidget,
                onPressed: onPressed,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(controller.options.borderRadius),
                  side: controller.options.borderSide ?? BorderSide.none,
                ),
                color: controller.options.color,
                colorBrightness: ThemeData.estimateBrightnessForColor(
                    controller.options.color),
                textColor: controller.options.textStyle.color,
                disabledColor: controller.options.disabledColor,
                disabledTextColor: controller.options.disabledTextColor,
                elevation: controller.options.elevation,
                splashColor: controller.options.splashColor,
              ),
            );
          }

          return Container(
            height: controller.options.height,
            width: controller.options.width,
            child: RaisedButton(
              onPressed: onPressed,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    controller.options.borderRadius ?? 28),
                side: controller.options.borderSide ?? BorderSide.none,
              ),
              textColor: controller.options.textStyle.color,
              color: controller.options.color,
              colorBrightness: ThemeData.estimateBrightnessForColor(
                  controller.options.color),
              disabledColor: controller.options.disabledColor,
              disabledTextColor: controller.options.disabledTextColor,
              padding: controller.options.padding,
              elevation: controller.options.elevation,
              child: textWidget,
            ),
          );
        });
  }
}

class CustomButtonController extends GetxController {
  var loading = false.obs;

  final String text;
  final Widget icon;
  final IconData iconData;
  final Function() onPressed;
  final CustomButtonOptions options;
  final bool showLoadingIndicator;

  CustomButtonController(
    this.text,
    this.icon,
    this.iconData,
    this.onPressed,
    this.options,
    this.showLoadingIndicator,
  );

  loadingToggle() {
    this.loading.toggle();
    update();
  }
}
