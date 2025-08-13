import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posmobile/presentations/login/bloc/login_bloc.dart';
import 'package:posmobile/shared/config/app_colors.dart';
import 'package:posmobile/shared/config/app_fonts.dart';

class TopBar extends StatefulWidget {
  final TextEditingController? searchController;
  final ValueChanged<String>? onSearchChanged;
  final String hintText;

  const TopBar({
    super.key,
    this.searchController,
    this.onSearchChanged,
    required this.hintText,
  });

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
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        children: [
          Row(
            children: [
              // Brand & Search
              Expanded(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.primary.withValues(
                        alpha: 0.08,
                      ),
                      child: BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          final name = state.maybeWhen(
                            success: (res) => res.data.user,
                            orElse: () => 'Pengguna',
                          );
                          return Text(
                            name.isNotEmpty ? name[0].toUpperCase() : 'U',
                            style: AppFonts.defaultTextTheme.labelLarge
                                ?.copyWith(color: AppColors.primary),
                          );
                        },
                      ),
                    ),

                    const SizedBox(width: 10),
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        final name = state.maybeWhen(
                          success: (res) => res.data.user,
                          orElse: () => 'Pengguna',
                        );
                        //rich text
                        return RichText(
                          text: TextSpan(
                            text: 'Hallo, ',
                            style: AppFonts.defaultTextTheme.labelLarge
                                ?.copyWith(color: AppColors.primary),
                            children: [
                              TextSpan(
                                text: name.isNotEmpty
                                    ? name.toUpperCase()
                                    : 'U',
                                style: AppFonts.defaultTextTheme.labelLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                              ),
                            ],
                          ),
                        );
                        // return Text(
                        //   'Hallo, ${name.isNotEmpty ? name.toUpperCase() : 'U'}',
                        //   style: AppFonts.defaultTextTheme.labelLarge?.copyWith(
                        //     color: AppColors.primary,
                        //   ),
                        // );
                      },
                    ),
                    const SizedBox(width: 24),
                    if (widget.searchController != null &&
                        widget.onSearchChanged != null)
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.divider,
                              width: 1,
                            ),
                          ),
                          height: 40,
                          child: TextField(
                            controller: widget.searchController,
                            onChanged: widget.onSearchChanged,
                            style: AppFonts.defaultTextTheme.bodyMedium,
                            decoration: InputDecoration(
                              hintText: widget.hintText,
                              hintStyle: AppFonts.defaultTextTheme.bodyMedium
                                  ?.copyWith(color: AppColors.textSecondary),
                              prefixIcon: Icon(
                                Icons.search,
                                size: 20,
                                color: AppColors.textSecondary,
                              ),
                              suffixIcon: _searchText.isNotEmpty
                                  ? IconButton(
                                      onPressed: () {
                                        widget.searchController!.clear();
                                        if (widget.onSearchChanged != null) {
                                          widget.onSearchChanged!('');
                                        }
                                      },
                                      icon: Icon(
                                        Icons.close_rounded,
                                        size: 20,
                                        color: AppColors.textSecondary,
                                      ),
                                    )
                                  : null,
                              filled: true,
                              fillColor: AppColors.surface,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 24),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.divider, width: 1),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 20,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      _prettyDate(),
                      style: AppFonts.defaultTextTheme.labelMedium?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // const Divider(height: 1, color: AppColors.divider),
        ],
      ),
    );
  }

  String _prettyDate() {
    final d = _currentTime.toLocal();
    return '${_weekday(d.weekday)}, ${d.day} ${_month(d.month)} ${d.year} • ${_two(d.hour)}:${_two(d.minute)}';
  }

  String _weekday(int w) =>
      ['Senin', 'Selasa', 'Rabu', 'Kamis', "Juma't", 'Sabtu', 'Minggu'][w - 1];
  String _month(int m) => [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ][m - 1];
  String _two(int n) => n.toString().padLeft(2, '0');
}
