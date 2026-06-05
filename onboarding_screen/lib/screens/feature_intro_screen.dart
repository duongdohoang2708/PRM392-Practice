import 'package:flutter/material.dart';

import '../app_theme.dart';

class FeatureSlide {
  final IconData icon;
  final String title;
  final String description;
  final Color accent;

  const FeatureSlide({
    required this.icon,
    required this.title,
    required this.description,
    required this.accent,
  });
}

class FeatureIntroScreen extends StatefulWidget {
  const FeatureIntroScreen({super.key});

  @override
  State<FeatureIntroScreen> createState() => _FeatureIntroScreenState();
}

class _FeatureIntroScreenState extends State<FeatureIntroScreen> {
  final PageController _pageController = PageController(
    viewportFraction: 0.78,
  );

  int _currentIndex = 0;

  static const List<FeatureSlide> _slides = [
    FeatureSlide(
      icon: Icons.auto_graph_rounded,
      title: 'Theo dõi tiến độ',
      description: 'Xem các chỉ số quan trọng và hiểu tình hình sử dụng của bạn.',
      accent: Color(0xFF6D28D9),
    ),
    FeatureSlide(
      icon: Icons.task_alt_rounded,
      title: 'Quản lý công việc',
      description: 'Sắp xếp nhiệm vụ, ưu tiên việc quan trọng và hoàn thành đúng hạn.',
      accent: Color(0xFF9333EA),
    ),
    FeatureSlide(
      icon: Icons.notifications_active_rounded,
      title: 'Nhắc nhở thông minh',
      description: 'Nhận thông báo đúng lúc để không bỏ lỡ việc cần làm.',
      accent: Color(0xFFB15CFF),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isLastSlide = _currentIndex == _slides.length - 1;

    return Scaffold(
      appBar: AppBar(
        title: const Text('GIỚI THIỆU TÍNH NĂNG'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),

            const Text(
              'Vuốt để lướt xem',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 8),

            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _slides.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  final slide = _slides[index];

                  return AnimatedBuilder(
                    animation: _pageController,
                    child: _FeatureCard(slide: slide),
                    builder: (context, child) {
                      double scale = 1;

                      if (_pageController.hasClients &&
                          _pageController.position.haveDimensions) {
                        final page = _pageController.page ?? _currentIndex.toDouble();
                        scale = (1 - (page - index).abs() * 0.08)
                            .clamp(0.92, 1.0)
                            .toDouble();
                      }

                      return Transform.scale(
                        scale: scale,
                        child: child,
                      );
                    },
                  );
                },
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _slides.length,
                    (index) => _buildDot(index),
              ),
            ),

            const SizedBox(height: 24),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: () {
                  if (isLastSlide) {
                    _finishIntro();
                  } else {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  }
                },
                child: Text(
                  isLastSlide ? 'HOÀN TẤT' : 'TIẾP TỤC',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDot(int index) {
    final isActive = index == _currentIndex;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 22 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.primaryPurple
            : AppColors.primaryPurple.withOpacity(0.25),
        borderRadius: BorderRadius.circular(99),
      ),
    );
  }

  void _finishIntro() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const HomePlaceholderScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class _FeatureCard extends StatelessWidget {
  final FeatureSlide slide;

  const _FeatureCard({
    required this.slide,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 32,
      ),
      decoration: BoxDecoration(
        color: AppColors.onSurfaceBlack,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.14),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    slide.accent.withOpacity(0.95),
                    slide.accent.withOpacity(0.45),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Icon(
                slide.icon,
                size: 92,
                color: Colors.white,
              ),
            ),
          ),

          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    slide.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    slide.description,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 13.5,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomePlaceholderScreen extends StatelessWidget {
  const HomePlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HOME'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Đây là màn Home tạm thời.\nSau này bạn sẽ thay bằng màn chính của app.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              height: 1.4,
            ),
          ),
        ),
      ),
    );
  }
}