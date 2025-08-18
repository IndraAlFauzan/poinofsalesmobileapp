import 'package:flutter/material.dart';
import 'package:posmobile/shared/config/api_config.dart';

class ApiConfigDebugWidget extends StatefulWidget {
  const ApiConfigDebugWidget({super.key});

  @override
  State<ApiConfigDebugWidget> createState() => _ApiConfigDebugWidgetState();
}

class _ApiConfigDebugWidgetState extends State<ApiConfigDebugWidget> {
  String? _selectedUrl;

  @override
  void initState() {
    super.initState();
    _selectedUrl = ApiConfig.effectiveBaseUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(Icons.settings, color: Colors.orange),
                const SizedBox(width: 8),
                Text(
                  'API Configuration (Debug)',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.orange[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Current URL: $_selectedUrl',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontFamily: 'monospace',
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quick Fix for iPad Simulator:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[700],
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: () {
                      ApiConfig.useLocalhost();
                      setState(() {
                        _selectedUrl = ApiConfig.effectiveBaseUrl;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '✅ Switched to localhost (127.0.0.1:8000)',
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                    icon: const Icon(Icons.computer, size: 16),
                    label: const Text('Use Localhost'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            ...ApiConfig.availableUrls.entries.map(
              (entry) => RadioListTile<String>(
                title: Text(entry.key),
                subtitle: Text(
                  entry.value,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'monospace',
                    color: Colors.grey[600],
                  ),
                ),
                value: entry.value,
                groupValue: _selectedUrl,
                onChanged: (value) {
                  setState(() {
                    _selectedUrl = value;
                    if (value == ApiConfig.baseUrl) {
                      ApiConfig.clearManualOverride();
                    } else {
                      ApiConfig.setManualBaseUrl(value!);
                    }
                  });
                },
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      ApiConfig.clearManualOverride();
                      _selectedUrl = ApiConfig.effectiveBaseUrl;
                    });
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Auto Detect'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                  label: const Text('Close'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Show API config dialog
void showApiConfigDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => Dialog(child: ApiConfigDebugWidget()),
  );
}
