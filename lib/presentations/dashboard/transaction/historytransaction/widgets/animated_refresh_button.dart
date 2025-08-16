import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posmobile/presentations/dashboard/transaction/historytransaction/bloc/history_transaction_bloc.dart';
import 'package:posmobile/shared/config/app_colors.dart';

class AnimatedRefreshButton extends StatefulWidget {
  const AnimatedRefreshButton({super.key});

  @override
  State<AnimatedRefreshButton> createState() => _AnimatedRefreshButtonState();
}

class _AnimatedRefreshButtonState extends State<AnimatedRefreshButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HistoryTransactionBloc, HistoryTransactionState>(
      listener: (context, state) {
        state.whenOrNull(
          refreshing: () => _animationController.repeat(),
          success: (_) => _animationController.stop(),
          failure: (_) => _animationController.stop(),
        );
      },
      child: BlocBuilder<HistoryTransactionBloc, HistoryTransactionState>(
        builder: (context, state) {
          final isRefreshing = state.maybeWhen(
            refreshing: () => true,
            orElse: () => false,
          );

          return InkWell(
            onTap: isRefreshing
                ? null
                : () {
                    context.read<HistoryTransactionBloc>().add(
                      const HistoryTransactionEvent.refreshTransactions(),
                    );
                  },
            borderRadius: BorderRadius.circular(8),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8),
                boxShadow: isRefreshing
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.3),
                          blurRadius: 8,
                          spreadRadius: 2,
                        ),
                      ]
                    : null,
              ),
              child: Row(
                children: [
                  AnimatedBuilder(
                    animation: _rotationAnimation,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _rotationAnimation.value * 2 * 3.14159,
                        child: Icon(
                          Icons.refresh,
                          color: AppColors.textOnPrimary,
                          size: 20,
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: Text(
                      isRefreshing ? "Refreshing..." : "Refresh",
                      key: ValueKey('refresh_text_$isRefreshing'),
                      style: TextStyle(
                        color: AppColors.textOnPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
