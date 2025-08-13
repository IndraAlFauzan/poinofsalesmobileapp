import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';

class ServiceTypeDropdown extends StatelessWidget {
  final Function(String?) onServiceTypeChanged;

  const ServiceTypeDropdown({super.key, required this.onServiceTypeChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CustomDropdown<String>(
        decoration: CustomDropdownDecoration(
          closedBorder: Border.all(color: Colors.grey),
        ),
        hintText: "Tipe Layanan",
        items: const ["Dine In", "Take Away", "Delivery"],
        onChanged: (value) {
          // Input Dine In jadi dine_in dan begitu seterusnya
          final valueLower = value?.toLowerCase().replaceAll(" ", "_");
          onServiceTypeChanged(valueLower);
        },
      ),
    );
  }
}
