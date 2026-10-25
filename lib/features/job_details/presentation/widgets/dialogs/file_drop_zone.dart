import 'package:flutter/material.dart';

import '../../../../../core/extension/l10n_extension.dart';
import '../../../domain/entities/job_circular.dart';
import '../job_core.dart';
import '../job_ui.dart';

/// Tap-to-browse upload area. Shows the picked file with a remove button.
class FileDropZone extends StatelessWidget {
  const FileDropZone({
    super.key,
    required this.file,
    required this.onPick,
    required this.onRemove,
    required this.hint,
    this.compact = false,
    this.errorText,
  });

  final AttachedFile? file;
  final VoidCallback onPick;
  final VoidCallback onRemove;
  final String hint;
  final bool compact;
  final String? errorText;

  String _size(BuildContext context, int bytes) {
    if (bytes >= 1024 * 1024) {
      return '${context.fmtNumber(bytes / (1024 * 1024), decimals: 1)} MB';
    }
    return '${context.fmtNumber(bytes / 1024, decimals: 0)} KB';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final hasError = errorText != null;
    final borderColor = hasError
        ? context.palette.danger
        : context.scheme.outline;

    final Widget content = file == null
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.cloud_upload_outlined,
                size: compact ? 22 : 30,
                color: AppColors.textMuted,
              ),
              const SizedBox(height: 4),
              Text.rich(
                TextSpan(
                  text: '${l10n.dropOrBrowse} ',
                  children: [
                    TextSpan(
                      text: l10n.browse,
                      style: TextStyle(
                        color: context.palette.brand,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
                style: AppTextStyles.bodySmall.copyWith(
                  color: context.bodyColor,
                ),
              ),
              if (!compact)
                CustomText(
                  hint,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textMuted,
                    fontSize: 11,
                  ),
                ),
            ],
          )
        : Row(
            children: [
              IconTile(
                icon: Icons.picture_as_pdf_outlined,
                color: context.palette.brand,
                background: context.palette.pillBg,
              ),
              const SizedBox(width: AppDimens.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      file!.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: context.scheme.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    CustomText(
                      _size(context, file!.sizeBytes),
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textMuted,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: l10n.removeFile,
                visualDensity: VisualDensity.compact,
                onPressed: onRemove,
                icon: const Icon(Icons.close_rounded, size: 18),
              ),
            ],
          );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(AppDimens.radiusMd),
          onTap: file == null ? onPick : null,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(compact ? AppDimens.sm : AppDimens.md),
            decoration: BoxDecoration(
              color: context.mutedSurface,
              borderRadius: BorderRadius.circular(AppDimens.radiusMd),
              border: Border.all(color: borderColor),
            ),
            child: content,
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: 4),
          CustomText(
            errorText!,
            style: AppTextStyles.bodySmall.copyWith(
              color: context.palette.danger,
            ),
          ),
        ],
      ],
    );
  }
}
