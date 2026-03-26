part of 'imports/intro_imports.dart';

class IntroSectionWidget extends StatefulWidget {
  final IntroDto introDto;
  const IntroSectionWidget({super.key, required this.introDto});

  @override
  State<IntroSectionWidget> createState() => _IntroSectionWidgetState();
}

class _IntroSectionWidgetState extends State<IntroSectionWidget> {
  late Ticker _ticker;
  double _time = 0.0;

  @override
  void initState() {
    _ticker = Ticker((d) {
      if (!mounted) return;
      setState(() {
        _time = DateTime.now().millisecondsSinceEpoch / 2000;
      });
    })..start();
    super.initState();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final scaleX = 1.1 + sin(_time) * .02;
        final scaleY = 1.1 + cos(_time) * .02;
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;

        return Container(
          color: AppColors.white,
          child: Column(
            children: [
              SizedBox(
                height: height * 0.5,
                width: double.infinity,
                child: ClipPath(
                  clipper: ConcaveCurveClipper(),
                  child: Container(
                    color: AppColors.grey2.withValues(alpha: 0.1),
                    child: Transform.translate(
                      offset: Offset(
                        -(scaleX - 1) / 2 * width,
                        -(scaleY - 1) / 2 * (height * 0.5),
                      ),
                      child: Transform(
                        transform: Matrix4.diagonal3Values(scaleX, scaleY, 1),
                        child: Image.asset(
                          widget.introDto.backGroundImagePath,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: AppColors.white,
                  padding: EdgeInsets.symmetric(
                    vertical: AppPadding.pH14,
                    horizontal: AppPadding.pW20,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: AppMargin.mH40,
                    children: [
                      _ContentWidget(
                        title: widget.introDto.title,
                        subTitle: widget.introDto.subtitle,
                      ),
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Image.asset(
                          widget.introDto.pointerImagePath!,
                          width: context.width * .4,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ConcaveCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 40);

    final firstControlPoint = Offset(size.width / 4, size.height + 15);
    final firstEndPoint = Offset(size.width / 2, size.height + 15);

    final secondControlPoint = Offset(
      size.width - (size.width / 4),
      size.height + 15,
    );
    final secondEndPoint = Offset(size.width, size.height - 40);

    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _ContentWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  const _ContentWidget({required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    final translatedTitle = title.tr();
    final words = translatedTitle.split(' ');
    final spans = <TextSpan>[];

    if (words.isNotEmpty) {
      for (int i = 0; i < words.length - 1; i++) {
        spans.add(TextSpan(text: '${words[i]} '));
      }
      spans.add(
        TextSpan(
          text: words.last,
          style: TextStyle(color: AppColors.orange),
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppMargin.mH10,
      children: <Widget>[
        if (title.isNotEmpty) ...[
          RichText(
            textAlign: TextAlign.start,
            text: TextSpan(
              style: context.textStyle.s28.setBlackColor.bold.copyWith(
                fontFamily: ConstantManager.fontFamily,
              ),
              children: spans.isEmpty
                  ? [TextSpan(text: translatedTitle)]
                  : spans,
            ),
          ),
        ],
        if (subTitle.isNotEmpty) ...[
          Text(
            subTitle.tr(),
            textAlign: TextAlign.start,
            style: context.textStyle.s13.setBlackColor.medium,
          ),
        ],
      ],
    );
  }
}
