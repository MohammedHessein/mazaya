part of 'imports/intro_imports.dart';

class IntroSectionWidget extends StatefulWidget {
  final IntroDto introDto;
  const IntroSectionWidget({super.key, required this.introDto});

  @override
  State<IntroSectionWidget> createState() => _IntroSectionWidgetState();
}

class _IntroSectionWidgetState extends State<IntroSectionWidget> {
  late Ticker _ticker;

  @override
  void initState() {
    _ticker = Ticker((d) {
      setState(() {});
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
        final time = DateTime.now().millisecondsSinceEpoch / 2000;
        final scaleX = 1.2 + sin(time) * .05;
        final scaleY = 1.2 + cos(time) * .07;
        final offsetY = 20 + cos(time) * 20;
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        return Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: <Widget>[
            Transform.translate(
              offset: Offset(
                -(scaleX - 1) / 2 * width,
                -(scaleY - 1) / 2 * height + offsetY,
              ),
              child: Transform(
                transform: Matrix4.diagonal3Values(scaleX, scaleY, 1),
                child: Image.asset(widget.introDto.backGroundImagePath),
              ),
            ),
            Container(
              color: Colors.black38,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                vertical: AppPadding.pH14,
                horizontal: AppPadding.pW10,
              ),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: AppMargin.mH40,
                  children: [
                    _PointerWithSkipButtonWidget(
                      pointerImagePath: widget.introDto.pointerImagePath!,
                    ),
                    _ContentWidget(
                      title: widget.introDto.title,
                      subTitle: widget.introDto.subtitle,
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ContentWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  const _ContentWidget({required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppMargin.mH10,
      children: <Widget>[
        if (title.isNotEmpty) ...[
          Text(
            title,
            textAlign: TextAlign.start,
            style: context.textStyle.s28.setWhiteColor.bold,
          ),
        ],
        if (subTitle.isNotEmpty) ...[
          Text(
            subTitle,
            textAlign: TextAlign.start,
            style: context.textStyle.s13.setWhiteColor.medium,
          ),
        ],
      ],
    );
  }
}

class _PointerWithSkipButtonWidget extends StatelessWidget {
  final String pointerImagePath;
  const _PointerWithSkipButtonWidget({required this.pointerImagePath});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          // onTap: () => Go.offAll(const LoginScreen()),
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: AppPadding.pH6,
              horizontal: AppPadding.pW14,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppCircular.r40),
              color: AppColors.white.withAlpha(25),
              border: Border.all(color: AppColors.white.withAlpha(10)),
            ),
            child: Text(
              LocaleKeys.introSkip,
              style: context.textStyle.s11.setWhiteColor.regular,
            ),
          ),
        ),
        Image.asset(
          pointerImagePath,
          width: context.width * .4,
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}
