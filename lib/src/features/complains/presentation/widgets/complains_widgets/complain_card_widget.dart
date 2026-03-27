part of '../../imports/view_imports.dart';

class _ComplainCardWidget extends StatelessWidget {
  final ComplainEntity complain;
  final bool showDetails;
  const _ComplainCardWidget(this.complain, {this.showDetails = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.pH12),
      margin: EdgeInsets.symmetric(vertical: AppMargin.mH6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: AppMargin.mH10,
        children: [
          _ComplainContetntWidget(complain),
          if (showDetails) ...[
            TitleWithArrowWidget(
              tiltle: LocaleKeys.complaintsShowDetails,
              mainAxisAlignment: MainAxisAlignment.end,
              selectArrowStyleEnum: SelectArrowStyleEnum.showMore,
              onTap: () => Go.to(ComplainDetailsScreen(id: complain.id)),
            ),
          ],
        ],
      ),
    );
  }
}

class _ComplainContetntWidget extends StatelessWidget {
  final ComplainEntity complain;
  const _ComplainContetntWidget(this.complain);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: AppMargin.mH10,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: AppMargin.mH10,
            children: [
              AppAssets.svg.appSvg.home.svg(
                width: AppSize.sH40,
                height: AppSize.sH40,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: AppMargin.mH2,
                  children: [
                    Text(
                      complain.complaintNumber,
                      style: const TextStyle().setMainTextColor.s13.regular,
                    ),
                    Text(
                      complain.date,
                      style: const TextStyle().setWhiteColor.s11.regular,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
