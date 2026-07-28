import 'dart:math' as math;

import 'package:PiliPlus/utils/platform_utils.dart';
import 'package:PiliPlus/utils/storage.dart';
import 'package:PiliPlus/utils/storage_key.dart';
import 'package:PiliPlus/utils/storage_pref.dart';
import 'package:flutter/material.dart';

const kFullScreenSCWidth = 255.0;

class FullScreenScSize extends StatefulWidget {
  const FullScreenScSize({super.key});

  @override
  State<FullScreenScSize> createState() => _FullScreenScSizeState();
}

class _FullScreenScSizeState extends State<FullScreenScSize> {
  late double _width;
  late EdgeInsets _padding;
  late ColorScheme _colorScheme;

  @override
  void initState() {
    super.initState();
    _width = Pref.fullScreenSCWidth.toDouble();
    _padding = MediaQuery.viewPaddingOf(context);
    _colorScheme = Theme.of(context).colorScheme;
  }

  void _updateWidth(double width) {
    setState(() {
      _width = width;
      GStorage.setting.put(SettingBoxKey.fullScreenSCWidth, width.toInt());
    });
  }

  Widget _buildPreview() {
    final size = MediaQuery.sizeOf(context);
    final maxWidth = size.width - _padding.horizontal;
    final maxHeight = size.height - _padding.vertical - kToolbarHeight - 120;
    final scWidth = math.min(_width, maxWidth);
    final scHeight = math.min(200.0, maxHeight);
    return Container(
      width: scWidth,
      height: scHeight,
      margin: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: _colorScheme.surfaceContainerHighest,
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 32,
              color: _colorScheme.outline,
            ),
            const SizedBox(height: 8),
            Text(
              'SC ${scWidth.toInt()}px',
              style: TextStyle(color: _colorScheme.outline),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModeButton({
    required String label,
    required IconData icon,
    required double width,
  }) {
    final isSelected = (_width - width).abs() < 1.0;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: FilledButton.tonalIcon(
          onPressed: () => _updateWidth(width),
          icon: Icon(icon, size: 20),
          label: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? _colorScheme.primary : null,
            ),
          ),
          style: FilledButton.styleFrom(
            backgroundColor: isSelected
                ? _colorScheme.primaryContainer
                : _colorScheme.surfaceContainerHighest,
            padding: const EdgeInsets.symmetric(vertical: 8),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final maxWidth = size.width - _padding.horizontal;
    final isDesktop = PlatformUtils.isDesktop;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('全屏弹幕宽度'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: _padding.left,
          right: _padding.right,
          bottom: 100,
        ),
        child: Column(
          children: [
            _buildPreview(),
            const SizedBox(height: 16),
            if (isDesktop) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  '拖动滑块调整全屏弹幕宽度',
                  style: TextStyle(color: _colorScheme.outline),
                ),
              ),
              Slider(
                min: 200,
                max: maxWidth,
                value: _width.clamp(200.0, maxWidth),
                onChanged: _updateWidth,
              ),
            ],
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _buildModeButton(
                    label: '竖向',
                    icon: Icons.stay_current_portrait,
                    width: 255,
                  ),
                  _buildModeButton(
                    label: '全屏',
                    icon: Icons.fullscreen,
                    width: maxWidth * 0.85,
                  ),
                  _buildModeButton(
                    label: '横向',
                    icon: Icons.stay_current_landscape,
                    width: maxWidth * 0.95,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}