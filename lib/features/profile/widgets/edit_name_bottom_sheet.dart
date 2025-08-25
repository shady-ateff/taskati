import 'package:flutter/material.dart';
import 'package:taskati/components/buttons/custom_button.dart';
import 'package:taskati/core/services/hive_helper.dart';
import 'package:taskati/features/add_task/widgets/custom_form_field.dart';

class EditNameBottomSheet extends StatelessWidget {
  const EditNameBottomSheet({
    super.key,
    required TextEditingController nameController,
    required this.onNameChenged,
  }) : _nameController = nameController;

  final TextEditingController _nameController;

  // final VoidCallback onNameChenged;
  final Function(TextEditingController changedNameController) onNameChenged;

  @override
  Widget build(BuildContext context) {
    // var _nameController =TextEditingController();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomFormField(
              title: "",
              hintText: "name",
              controller: _nameController,
            ),
            CustomButton(
              label: "Update Your Name",
              onPressed: () {
                if (_nameController.text.isNotEmpty) {
                  HiveHelper.cacheData(
                    HiveHelper.userName,
                    _nameController.text,
                  );
                  Navigator.of(context).pop();
                  onNameChenged(_nameController);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
