import 'package:cherry/colors.dart';
import 'package:cherry/widgets/details_dialog.dart';
import 'package:flutter/material.dart';

class RowItem extends StatelessWidget {
  final String title;
  final Widget description;

  RowItem({this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: Theme
                .of(context)
                .textTheme
                .subhead
                .copyWith(color: primaryText),
          ),
          description
        ],
      ),
    );
  }

  factory RowItem.textRow(String title, String description) {
    return RowItem(
      title: title,
      description: _getDescriptionWidget(description),
    );
  }

  factory RowItem.iconRow(String title, bool status) {
    return RowItem(title: title, description: _getIconWidget(status));
  }

  factory RowItem.dialogRow(BuildContext context, String title,
      String description, DetailsDialog dialog) {
    return RowItem(
      title: title,
      description: _getDialogWidget(context, dialog, description),
    );
  }

  static Widget _getIconWidget(bool status) {
    return Icon(
      status == null
          ? Icons.remove_circle
          : (status ? Icons.check_circle : Icons.cancel),
      color: status == null ? nullIcon : (status ? acceptIcon : denyIcon),
    );
  }

  static Widget _getDescriptionWidget(String description,
      [bool clickable = false]) {
    return Text(
      description,
      style: TextStyle(
        fontSize: 17.0,
        color: secondaryText,
        decoration: clickable ? TextDecoration.underline : TextDecoration.none,
      ),
    );
  }

  static _getDialogWidget(
      BuildContext context, DetailsDialog dialog, String description) {
    return InkWell(
      child: _getDescriptionWidget(description, true),
      onTap: () => showDialog(
            context: context,
            builder: (context) => (description != 'Unknown')
                ? dialog
                : AlertDialog(
                    title: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Unknown item',
                        style: Theme
                            .of(context)
                            .textTheme
                            .title
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    content: Text(
                      'Vehicle information is not available at this moment. Please try again later...',
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('OK'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
          ),
    );
  }
}
