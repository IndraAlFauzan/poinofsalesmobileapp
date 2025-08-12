import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posmobile/bloc/product/product_bloc.dart';
import 'package:posmobile/presentations/login/bloc/login_bloc.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        // Brand
        Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.restaurant, color: theme.colorScheme.primary),
            ),
            const SizedBox(width: 10),
          ],
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          decoration: BoxDecoration(
            color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 18,
                color: theme.hintColor,
              ),
              const SizedBox(width: 8),
              Text(
                _prettyDate(),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(.7),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 16),
              IconButton(
                tooltip: 'Refresh',
                onPressed: () {
                  context.read<ProductBloc>().add(const ProductEvent.started());
                },
                icon: const Icon(Icons.refresh),
              ),
              const SizedBox(width: 4),
              CircleAvatar(
                radius: 18,
                child: BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    final name = state.maybeWhen(
                      success: (res) => res.data.user,
                      orElse: () => 'Pengguna',
                    );
                    return Text(name.isNotEmpty ? name[0].toUpperCase() : 'U');
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _prettyDate() {
    final d = DateTime.now();
    return '${_weekday(d.weekday)}, ${d.day} ${_month(d.month)} ${d.year} • ${_two(d.hour)}:${_two(d.minute)}';
  }

  String _weekday(int w) =>
      ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][w - 1];
  String _month(int m) => [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ][m - 1];
  String _two(int n) => n.toString().padLeft(2, '0');
}
