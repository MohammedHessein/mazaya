part of '../../imports/view_imports.dart';

class _ComplainsDetailsBody extends StatelessWidget {
  const _ComplainsDetailsBody();

  @override
  Widget build(BuildContext context) {
    return AsyncBlocBuilder<ComplainsDetailsCubit, ComplainEntity?>(
      builder: (context, data) => _ComplainDetailsCards(data!),
      skeletonBuilder: (context) =>
          _ComplainDetailsCards(ComplainEntity.initial()),
    );
  }
}

class _ComplainDetailsCards extends StatelessWidget {
  final ComplainEntity complain;
  const _ComplainDetailsCards(this.complain);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(AppPadding.pH12),
      children: [
        _ComplainCardWidget(complain, showDetails: false),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(AppSize.sH12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppMargin.mH4,
            children: [
              Text(
                LocaleKeys.complaintsReason,
                style: const TextStyle().setGreyColor.s13.regular,
              ),
              Text(
                complain.reason,
                style: const TextStyle().setMainTextColor.s13.regular,
              ),
              AppSize.sH6.szH,
              Text(
                LocaleKeys.complaintsDetailsTitle,
                style: const TextStyle().setGreyColor.s13.regular,
              ),
              Text(
                complain.complaint,
                style: const TextStyle().setSecondryColor.s13.regular,
              ),
            ],
          ),
        ),
        if (complain.files.isNotEmpty) ...[
          Text(
            LocaleKeys.complaintsPhotos,
            style: const TextStyle().setMainTextColor.s14.regular,
          ),
          Wrap(
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: AppMargin.mH10,
            runSpacing: AppMargin.mH10,
            children: complain.files
                .map(
                  (e) => CachedImage(
                    url: e.image,
                    width: AppSize.sH70,
                    height: AppSize.sH70,
                  ),
                )
                .toList(),
          ),
          if (complain.replies.isNotEmpty) ...[
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(AppSize.sH12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: AppMargin.mH4,
                children: [
                  Text(
                    LocaleKeys.complaintsAdminResponse,
                    style: const TextStyle().setGreyColor.s13.regular,
                  ),
                  Text(
                    complain.replies.map((e) => '${e.reply} ').toString(),
                    style: const TextStyle().setMainTextColor.s13.regular,
                  ),
                ],
              ),
            ),
          ],
        ],
      ].joinWith(AppSize.sH12.szH),
    );
  }
}
