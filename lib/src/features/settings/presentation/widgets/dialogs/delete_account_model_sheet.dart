part of '../../imports/view_imports.dart';

Future deleteAccountModelSheet() async {
  return showDefaultBottomSheet(
    child: BlocProvider(
      create: (context) => injector<DeleteAccountCubit>(),
      child: const DeleteAccountBottomSheet(),
    ),
  );
}
