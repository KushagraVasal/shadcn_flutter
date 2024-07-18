import 'package:flutter/material.dart' as material;
import 'package:flutter/services.dart';
import 'package:syntax_highlight/syntax_highlight.dart';

import '../../shadcn_flutter.dart';

class CodeSnippet extends StatefulWidget {
  final BoxConstraints? constraints;
  final String code;
  final String mode;
  final List<Widget> actions;

  const CodeSnippet({
    Key? key,
    this.constraints,
    this.actions = const [],
    required this.code,
    required this.mode,
  }) : super(key: key);

  @override
  State<CodeSnippet> createState() => _CodeSnippetState();
}

class _CodeSnippetState extends State<CodeSnippet> {
  static const Set<String> _supportedLanguages = {
    'json',
    'yaml',
    'dart',
    'sql',
  };
  static const Map<String, String> _languageAlias = {
    'yml': 'yaml',
  };
  static final Map<String, Future<void>> _initializedLanguages = {};
  static final Map<Brightness, Future<HighlighterTheme>> _initializedThemes =
      {};
  static Future<bool> _initializeLanguage(String mode) {
    // check for alias
    if (_languageAlias.containsKey(mode)) {
      mode = _languageAlias[mode]!;
    }
    if (!_supportedLanguages.contains(mode)) {
      return Future.value(false);
    }
    if (_initializedLanguages.containsKey(mode)) {
      _initializedLanguages[mode]!;
      return Future.value(true);
    }
    final future = Highlighter.initialize([mode]);
    _initializedLanguages[mode] = future;
    return future.then((_) => true);
  }

  static Future<HighlighterTheme> _initializeTheme(Brightness brightness) {
    if (_initializedThemes.containsKey(brightness)) {
      return _initializedThemes[brightness]!;
    }
    final future = HighlighterTheme.loadForBrightness(brightness);
    _initializedThemes[brightness] = future;
    return future;
  }

  late Future<Highlighter?> _highlighter;
  Brightness? _brightness;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var newBrightness = Theme.of(context).brightness;
    if (_brightness != newBrightness) {
      _brightness = newBrightness;
      _highlighter = _initializeHighlighter();
    }
  }

  @override
  void didUpdateWidget(covariant CodeSnippet oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.mode != widget.mode) {
      _highlighter = _initializeHighlighter();
    }
  }

  Future<Highlighter?> _initializeHighlighter() async {
    if (!await _initializeLanguage(widget.mode)) {
      return null;
    }
    final themeData = await _initializeTheme(_brightness ?? Brightness.light);
    return Highlighter(language: widget.mode, theme: themeData);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.card,
        border: Border.all(
          color: theme.colorScheme.border,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(theme.radiusLg),
      ),
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          FutureBuilder(
              future: _highlighter,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var data = snapshot.data;
                return Container(
                  constraints: widget.constraints,
                  child: SingleChildScrollView(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 20),
                      child: data == null
                          ? material.SelectableText(widget.code)
                              .muted()
                              .mono()
                              .small()
                          : material.SelectableText.rich(
                              data.highlight(widget.code),
                            ).mono().small(),
                    ),
                  ),
                );
              }),
          Positioned(
            right: 8,
            top: 8,
            child: Row(
              children: [
                ...widget.actions,
                GhostButton(
                  density: ButtonDensity.icon,
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: widget.code));
                  },
                  child: Icon(
                    Icons.copy,
                    size: 16,
                  ),
                ),
              ],
            ).gap(4),
          ),
        ],
      ),
    );
  }
}
