import 'package:diploma_job/features/edit_student_profile/data/model/student_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_dimens.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/labeled_text_field.dart';

class EditStudentProfileDialog extends ConsumerStatefulWidget {
  const EditStudentProfileDialog({super.key});

  @override
  ConsumerState<EditStudentProfileDialog> createState() =>
      _EditStudentProfileDialogState();
}

class _EditStudentProfileDialogState
    extends ConsumerState<EditStudentProfileDialog> {
  late TextEditingController _bioController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _rollController;
  late TextEditingController _regController;
  late TextEditingController _sessionController;
  late TextEditingController _nocController;

  @override
  void initState() {
    super.initState();
    final state = ref.read(studentProfileEditProvider);
    _bioController = TextEditingController(text: state.bio);
    _emailController = TextEditingController(text: state.email);
    _phoneController = TextEditingController(text: state.phone);
    _addressController = TextEditingController(text: state.address);
    _rollController = TextEditingController(text: state.boardRoll);
    _regController = TextEditingController(text: state.registrationNo);
    _sessionController = TextEditingController(text: state.session);
    _nocController = TextEditingController(text: state.nocLetterNo);
  }

  @override
  void dispose() {
    _bioController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _rollController.dispose();
    _regController.dispose();
    _sessionController.dispose();
    _nocController.dispose();
    super.dispose();
  }

  void _save() {
    ref
        .read(studentProfileEditProvider.notifier)
        .updateProfile(
          bio: _bioController.text,
          email: _emailController.text,
          phone: _phoneController.text,
          address: _addressController.text,
          boardRoll: _rollController.text,
          registrationNo: _regController.text,
          session: _sessionController.text,
          nocLetterNo: _nocController.text,
        );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.radiusLg),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 750),
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Edit Profile Information',
                    style: AppTextStyles.headlineMedium.responsive(context),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Divider(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      LabeledTextField(
                        label: 'About me (Bio)',
                        controller: _bioController,
                        maxLines: 4,
                      ),
                      const SizedBox(height: AppDimens.sm),
                      LabeledTextField(
                        label: 'Email address',
                        controller: _emailController,
                        preIcon: Icons.email_outlined,
                      ),
                      const SizedBox(height: AppDimens.sm),
                      LabeledTextField(
                        label: 'Phone number',
                        controller: _phoneController,
                        preIcon: Icons.phone_outlined,
                      ),
                      const SizedBox(height: AppDimens.sm),
                      LabeledTextField(
                        label: 'Current address',
                        controller: _addressController,
                        preIcon: Icons.location_on_outlined,
                      ),
                      const SizedBox(height: AppDimens.sm),
                      Row(
                        children: [
                          Expanded(
                            child: LabeledTextField(
                              label: 'Board roll',
                              controller: _rollController,
                            ),
                          ),
                          const SizedBox(width: AppDimens.sm),
                          Expanded(
                            child: LabeledTextField(
                              label: 'Registration',
                              controller: _regController,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppDimens.sm),
                      Row(
                        children: [
                          Expanded(
                            child: LabeledTextField(
                              label: 'Session',
                              controller: _sessionController,
                            ),
                          ),
                          const SizedBox(width: AppDimens.sm),
                          Expanded(
                            child: LabeledTextField(
                              label: 'NOC letter no',
                              controller: _nocController,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppDimens.sm),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: AppDimens.sm),
                  CustomButton(
                    label: 'Save Changes',
                    onPressed: _save,
                    variant: CustomButtonVariant.primary,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
