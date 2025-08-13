import 'package:flutter/material.dart';
import 'package:posmobile/shared/config/app_colors.dart';
import 'package:posmobile/presentations/dashboard/transaction/historytransaction/widgets/tabel_transaction.dart';

class PaginationControls extends StatefulWidget {
  final TransactionTebelData dataSource;

  const PaginationControls({super.key, required this.dataSource});

  @override
  State<PaginationControls> createState() => _PaginationControlsState();
}

class _PaginationControlsState extends State<PaginationControls> {
  @override
  void initState() {
    super.initState();
    // Add listener to rebuild when data changes
    widget.dataSource.addListener(_onDataSourceChanged);
  }

  @override
  void dispose() {
    widget.dataSource.removeListener(_onDataSourceChanged);
    super.dispose();
  }

  void _onDataSourceChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 0.5),
      ),
      child: Row(
        children: [
          // Info showing current range
          Expanded(
            child: Text(
              'Menampilkan ${widget.dataSource.startItem}-${widget.dataSource.endItem} dari ${widget.dataSource.totalItems} transaksi',
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF666666),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // Page info
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Halaman ${widget.dataSource.currentPage} dari ${widget.dataSource.totalPages}',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Previous button
          _buildPageButton(
            icon: Icons.chevron_left,
            onPressed: widget.dataSource.hasPreviousPage
                ? () => widget.dataSource.previousPage()
                : null,
            tooltip: 'Halaman Sebelumnya',
          ),

          const SizedBox(width: 8),

          // Next button
          _buildPageButton(
            icon: Icons.chevron_right,
            onPressed: widget.dataSource.hasNextPage
                ? () => widget.dataSource.nextPage()
                : null,
            tooltip: 'Halaman Selanjutnya',
          ),
        ],
      ),
    );
  }

  Widget _buildPageButton({
    required IconData icon,
    required VoidCallback? onPressed,
    required String tooltip,
  }) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: onPressed != null
                  ? AppColors.primary.withValues(alpha: 0.1)
                  : Colors.grey.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: onPressed != null
                    ? AppColors.primary.withValues(alpha: 0.3)
                    : Colors.grey.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Icon(
              icon,
              size: 18,
              color: onPressed != null ? AppColors.primary : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
