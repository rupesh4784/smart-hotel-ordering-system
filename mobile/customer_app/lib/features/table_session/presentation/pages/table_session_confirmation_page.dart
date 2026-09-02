
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../table_session/presentation/controllers/table_session_controller.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../app/theme/app_spacing.dart';

/// TEMPORARY screen — proves the QR scan -> session creation pipeline works.
/// Gets replaced by the real Hotel/Menu Home screen in Phase 4.
class TableSessionConfirmationPage extends ConsumerWidget {
  const TableSessionConfirmationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionState = ref.watch(tableSessionControllerProvider);
    final session = sessionState.session;

    return Scaffold(
      appBar: AppBar(title: const Text('Table Session')),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: sessionState.isLoading
            ? const Center(child: CircularProgressIndicator())
            : session == null
            ? Center(
          child: Text(
            sessionState.errorMessage ?? 'No active session.',
            style: AppTypography.bodyLarge,
          ),
        )
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.check_circle, color: AppColors.success, size: 48),
            const SizedBox(height: AppSpacing.md),
            Text('Session started', style: AppTypography.h2),
            const SizedBox(height: AppSpacing.lg),
            _InfoRow(label: 'Hotel ID', value: session.hotelId),
            _InfoRow(label: 'Table ID', value: session.tableId),
            _InfoRow(label: 'Session ID', value: session.sessionId),
            _InfoRow(label: 'Started at', value: session.createdAt.toString()),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'This confirms the QR scan -> session pipeline works. '
                  'The real menu screen replaces this in Phase 4.',
              style: AppTypography.caption,
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 100, child: Text(label, style: AppTypography.labelMedium)),
          Expanded(child: Text(value, style: AppTypography.bodyMedium)),
        ],
      ),
    );
  }
}