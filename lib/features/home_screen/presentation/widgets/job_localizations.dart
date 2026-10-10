import '../../../../core/l10n/app_localizations.dart';
import '../../domain/entities/job.dart';

extension JobTechX on JobTech {
  String label(AppLocalizations l10n) => switch (this) {
        JobTech.computer => l10n.techComputer,
        JobTech.civil => l10n.techCivil,
        JobTech.electrical => l10n.techElectrical,
        JobTech.mechanical => l10n.techMechanical,
        JobTech.architecture => l10n.techArchitecture,
        JobTech.electronics => l10n.techElectronics,
      };

  String get emoji => switch (this) {
        JobTech.computer => '💻',
        JobTech.civil => '🏗️',
        JobTech.electrical => '⚡',
        JobTech.mechanical => '⚙️',
        JobTech.architecture => '📐',
        JobTech.electronics => '🔌',
      };
}
