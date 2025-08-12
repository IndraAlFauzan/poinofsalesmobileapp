import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:posmobile/presentations/login/bloc/login_bloc.dart';

class TopBar extends StatefulWidget {
  final TextEditingController? searchController;
  final ValueChanged<String>? onSearchChanged;

  const TopBar({super.key, this.searchController, this.onSearchChanged});

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  late Timer _timer;
  late DateTime _currentTime;
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _currentTime = DateTime.now();
        });
      }
    });

    // Listen to search controller changes to update UI
    if (widget.searchController != null) {
      widget.searchController!.addListener(_onSearchTextChanged);
      _searchText = widget.searchController!.text;
    }
  }

  void _onSearchTextChanged() {
    if (mounted) {
      setState(() {
        _searchText = widget.searchController!.text;
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    if (widget.searchController != null) {
      widget.searchController!.removeListener(_onSearchTextChanged);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),

          child: Row(
            children: [
              // Brand & Search
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(alpha: .07),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.restaurant,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Search Bar
                    if (widget.searchController != null &&
                        widget.onSearchChanged != null)
                      Expanded(
                        child: Container(
                          height: 36,
                          child: TextField(
                            controller: widget.searchController,
                            onChanged: widget.onSearchChanged,
                            decoration: InputDecoration(
                              hintText: 'Search menu…',
                              hintStyle: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.hintColor,
                              ),
                              prefixIcon: Icon(
                                Icons.search,
                                size: 18,
                                color: theme.hintColor,
                              ),
                              suffixIcon: _searchText.isNotEmpty
                                  ? IconButton(
                                      onPressed: () {
                                        widget.searchController!.clear();
                                        // Trigger search changed immediately to ensure proper reset
                                        if (widget.onSearchChanged != null) {
                                          widget.onSearchChanged!('');
                                        }
                                      },
                                      icon: Icon(
                                        Icons.close_rounded,
                                        size: 18,
                                        color: theme.hintColor,
                                      ),
                                    )
                                  : null,
                              filled: true,
                              fillColor: theme.colorScheme.surface,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: .07),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 18,
                      color: theme.hintColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _prettyDate(),
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 16),
                    // IconButton(
                    //   tooltip: 'Refresh',
                    //   onPressed: () {
                    //     context.read<ProductBloc>().add(
                    //       const ProductEvent.started(),
                    //     );
                    //   },
                    //   icon: const Icon(Icons.refresh),

                    // ),
                    const SizedBox(width: 4),
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: theme.colorScheme.onSurface.withValues(
                        alpha: .07,
                      ),
                      child: BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          final name = state.maybeWhen(
                            success: (res) => res.data.user,
                            orElse: () => 'Pengguna',
                          );
                          return Text(
                            name.isNotEmpty ? name[0].toUpperCase() : 'U',
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Divider(
          height: 2,
          color: Colors.black26,
          // indent: 20,
          // endIndent: 20,
        ),
      ],
    );
  }

  String _prettyDate() {
    final d = _currentTime.toLocal();
    return '${_weekday(d.weekday)}, ${d.day} ${_month(d.month)} ${d.year} • ${_two(d.hour)}:${_two(d.minute)}:${_two(d.second)}';
  }

  String _weekday(int w) =>
      ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'][w - 1];
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
