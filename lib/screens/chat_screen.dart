import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class ChatScreen extends StatefulWidget {
  final String orderId;
  final String otherUserName;

  const ChatScreen({
    super.key,
    required this.orderId,
    required this.otherUserName,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _msgController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isTyping = false;

  final List<Map<String, dynamic>> _messages = [
    {
      'text': 'Hello! Has my order been dispatched yet?',
      'isMe': true,
      'time': '10:32 AM',
    },
    {
      'text': 'Hi there! Yes, it\'s been packed and will be on its way shortly.',
      'isMe': false,
      'time': '10:33 AM',
    },
    {
      'text': 'Great! Approximately when will it arrive?',
      'isMe': true,
      'time': '10:34 AM',
    },
    {
      'text': 'It will arrive between 4–6 PM today. Our delivery partner will call you.',
      'isMe': false,
      'time': '10:35 AM',
    },
  ];

  void _sendMessage() {
    final text = _msgController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({
        'text': text,
        'isMe': true,
        'time': _currentTime(),
      });
    });
    _msgController.clear();

    // Simulate typing response
    setState(() => _isTyping = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() {
        _isTyping = false;
        _messages.add({
          'text': 'Thanks for reaching out! I\'ll check on that for you.',
          'isMe': false,
          'time': _currentTime(),
        });
      });
      _scrollToBottom();
    });

    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _currentTime() {
    final now = DateTime.now();
    final h = now.hour > 12 ? now.hour - 12 : now.hour;
    final m = now.minute.toString().padLeft(2, '0');
    final period = now.hour >= 12 ? 'PM' : 'AM';
    return '$h:$m $period';
  }

  @override
  void dispose() {
    _msgController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          color: AppTheme.surface,
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_rounded,
                        color: AppTheme.textPrimary),
                    onPressed: () => Navigator.pop(context),
                  ),
                  // Farmer avatar
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      gradient: AppTheme.gradientPrimary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        widget.otherUserName[0],
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.otherUserName,
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              width: 7,
                              height: 7,
                              decoration: const BoxDecoration(
                                color: AppTheme.success,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'Online now • ${widget.orderId}',
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.call_rounded,
                        color: AppTheme.primary),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // ── Messages ──
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              physics: const BouncingScrollPhysics(),
              itemCount: _messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (ctx, i) {
                if (_isTyping && i == _messages.length) {
                  return _buildTypingIndicator();
                }
                final msg = _messages[i];
                return _buildMessage(msg, i).animate()
                    .fadeIn(duration: 200.ms)
                    .slideY(begin: 0.2);
              },
            ),
          ),

          // ── Input Bar ──
          Container(
            padding: EdgeInsets.fromLTRB(
              16,
              12,
              16,
              MediaQuery.of(context).padding.bottom + 12,
            ),
            decoration: BoxDecoration(
              color: AppTheme.surface,
              border: const Border(top: BorderSide(color: AppTheme.divider)),
              boxShadow: AppTheme.shadowLarge,
            ),
            child: Row(
              children: [
                // Attachment
                IconButton(
                  icon: const Icon(Icons.attach_file_rounded,
                      color: AppTheme.textSecondary, size: 22),
                  onPressed: () {},
                ),
                // Text field
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceElevated,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: AppTheme.border),
                    ),
                    child: TextField(
                      controller: _msgController,
                      maxLines: null,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                        hintText: 'Type a message…',
                        fillColor: Colors.transparent,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // Send
                GestureDetector(
                  onTap: _sendMessage,
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      gradient: AppTheme.gradientPrimary,
                      shape: BoxShape.circle,
                      boxShadow: AppTheme.shadowPrimary.map((s) =>
                          BoxShadow(
                            color: s.color.withValues(alpha: 0.2),
                            blurRadius: s.blurRadius,
                            offset: s.offset,
                          )).toList(),
                    ),
                    child: const Icon(Icons.send_rounded,
                        color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(Map<String, dynamic> msg, int index) {
    final isMe = msg['isMe'] as bool;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe) ...[
            // Farmer avatar
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                gradient: AppTheme.gradientPrimary,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  'F',
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.72,
                  ),
                  decoration: BoxDecoration(
                    gradient: isMe ? AppTheme.gradientPrimary : null,
                    color: isMe ? null : AppTheme.surface,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(18),
                      topRight: const Radius.circular(18),
                      bottomLeft: Radius.circular(isMe ? 18 : 4),
                      bottomRight: Radius.circular(isMe ? 4 : 18),
                    ),
                    border: isMe
                        ? null
                        : Border.all(color: AppTheme.divider),
                    boxShadow: AppTheme.shadowSmall,
                  ),
                  child: Text(
                    msg['text'] as String,
                    style: GoogleFonts.inter(
                      color:
                          isMe ? Colors.white : AppTheme.textPrimary,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      msg['time'] as String,
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        color: AppTheme.textTertiary,
                      ),
                    ),
                    if (isMe) ...[
                      const SizedBox(width: 4),
                      const Icon(Icons.done_all_rounded,
                          size: 12, color: AppTheme.primary),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              gradient: AppTheme.gradientPrimary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                'F',
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(18),
              ),
              border: Border.all(color: AppTheme.divider),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                3,
                (i) => Container(
                  width: 7,
                  height: 7,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: AppTheme.primary,
                    shape: BoxShape.circle,
                  ),
                )
                    .animate(onPlay: (c) => c.repeat())
                    .moveY(
                      begin: 0,
                      end: -5,
                      delay: Duration(milliseconds: 150 * i),
                      duration: 400.ms,
                      curve: Curves.easeInOut,
                    )
                    .then()
                    .moveY(begin: -5, end: 0, duration: 400.ms, curve: Curves.easeInOut),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
