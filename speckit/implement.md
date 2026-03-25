# 🚀 Hattrick App – Implementation Workflows

## Workflow 1: Create a New Feature

1. **Scaffold**: Run `mason make feature --name <feature_name>`.
2. **Entity**: Define your data entity in `lib/src/features/[type]/[name]/entity/`.
3. **Cubit**: Implement logic in `presentation/cubits/[name]_cubit.dart` using `AsyncCubit`.
4. **DI**: Run `dart run build_runner build --delete-conflicting-outputs`.
5. **UI**: Build your screen in `presentation/view/`. **Recommendation**: Use `BlocStatelessWidget<C>` or `BlocStatefulWidget<C>` to simplify `BlocProvider` injection.
6. **State Handling**: Use the `BaseStatus.when()` extension in your UI widgets to handle Loading, Success, and Error states exhaustively.
7. **Navigation**: Navigate via `Go.to(context, NewScreen())`.

## Workflow 2: Add an API Endpoint

1. **Constants**: Add endpoint to `ApiConstants`.
2. **Params**: Create a `CrudBaseParams` object defining the endpoint and HTTP method.
3. **Implementation**: Call `baseCrudUseCase.call(params)` within `executeAsync` in your Cubit.
4. **Mapper**: Provide a mapper function to transform JSON into your entity.

## Workflow 4: Implementing a Paginated List

1. **Cubit**: Create a class extending `PaginatedCubit<T>`.
2. **Override**: Implement `fetchPageData(page, {key})` (call your API) and `parseItems(json)` (map to your entity).
3. **UI**: Use the `PaginatedListWidget<T>` in your screen. Pass the cubit and an `itemBuilder`.
4. **Initial Load**: Call `context.read<YourPaginatedCubit>().fetchInitialData()` in `initState`.

## Workflow 5: Global Loading Overlay

1. **Show**: Call `FullScreenLoadingManager.show()` to display a blocking loading indicator.
2. **Hide**: Call `FullScreenLoadingManager.hide()` to remove it.
3. **Usage**: Ideal for non-UI-specific operations like "Deleting Account" or "Uploading File".

## Workflow 6: Handling Session Expiry (Auth)

1. **Auto-handling**: The `UnAuthenticatedInterceptor` automatically detects 401 errors or `unauthenticated/blocked` keys.
2. **Global UI**: It triggers an `UnAuthenticatedBottomSheet` automatically (configured in `App` widget).
3. **Manual Trigger**: You can manually notify listeners via `UnAuthenticatedInterceptor.instance.notifyListeners(true/false)`.

## Workflow 7: Advanced Navigation Transitions

1. **Standard**: Use `Go.to(context, Page())` for default transitons.
2. **Custom**: To use specific animations:
   ```dart
   PageRouterBuilder().build(
     NewPage(),
     transition: TransitionType.fade, // or slide, scale, shake, etc.
   );
   ```
3. **Global Config**: Default transitions per platform are set in `main.dart` via `PageRouterBuilder().initAppRouter()`.

## 💡 Concrete Examples

### Example 1: Standard Feature Cubit (`AsyncCubit`)
Use this for fetching a list of items or a single detail object.

```dart
@injectable
class FaqsCubit extends AsyncCubit<List<FaqEntity>> {
  FaqsCubit() : super([]);

  Future<void> fetchFaqs() async {
    await executeAsync(
      operation: () async => baseCrudUseCase.call(
        CrudBaseParams(
          api: ApiConstants.faqs,
          httpRequestType: HttpRequestType.get,
          mapper: (json) => (json['data'] as List)
              .map((e) => FaqEntity.fromJson(e))
              .toList(),
        ),
      ),
    );
  }
}
```

### Example 2: Reactive UI with `AsyncBlocBuilder`
Use this to handle loading (with skeletons), success, and error states automatically.

```dart
class FaqsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AsyncBlocBuilder<FaqsCubit, List<FaqEntity>>(
      skeletonBuilder: (context) => _MySkeletonList(),
      builder: (context, data) {
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) => FaqCard(faq: data[index]),
        );
      },
    );
  }
}
```

### Example 3: Clean Screen with `BlocStatelessWidget`
Reduces boilerplate for providing and initializing a Cubit.

```dart
class FaqsScreen extends BlocStatelessWidget<FaqsCubit> {
  const FaqsScreen({super.key});

  @override
  FaqsCubit get create => injector<FaqsCubit>()..fetchFaqs();

  @override
  Widget buildContent(BuildContext context, FaqsCubit ref) {
    return DefaultScaffold(
      title: LocaleKeys.faqs.tr(),
      body: const FaqsBody(),
    );
  }
}
```

### Example 4: Paginated List Implementation
Use this for features requiring infinite scrolling.

```dart
@injectable
class MyItemsCubit extends PaginatedCubit<MyItemEntity> {
  @override
  Future<Result<Map<String, dynamic>, Failure>> fetchPageData(int page, {String? key}) async {
    return baseCrudUseCase.call(
      CrudBaseParams(
        api: ApiConstants.myItems,
        queryParameters: {'page': page},
        mapper: (json) => json, // Pass full JSON to PaginatedCubit logic
      ),
    );
  }

  @override
  List<MyItemEntity> parseItems(dynamic json) =>
      (json['data'] as List).map((e) => MyItemEntity.fromJson(e)).toList();

  @override
  PaginationMeta parsePagination(dynamic json) =>
      PaginationMeta.fromJson(json['meta']);
}

// In UI:
PaginatedListWidget<MyItemEntity>(
  cubit: context.read<MyItemsCubit>(),
  itemBuilder: (context, item) => MyItemCard(item: item),
);
```

### 9. Handling Session Expiry & Blocking
The app automatically monitors authentication status via `UnAuthenticatedInterceptor`.
- **Trigger**: Any 401 response or a specialized "blocked" status in the API.
- **Action**: A global `UnAuthenticatedBottomSheet` is displayed.
- **Cleanup**: User data is cleared from Cache and SecureStorage via `UserCubit.logout()`.
- **Navigation**: The user is returned to the login/onboarding root.

### 10. Responsive UI Design
- Use `context.width` and `context.height` for relative sizing.
- Use `.h`, `.w`, `.sp`, and `.r` for pixel-consistent design.
- Chain `TextStyleEx` for rapid styling: `Text("...").style(context.textStyle.s16.bold.setPrimaryColor)`.
- Use `UniversalMediaWidget` to intelligently handle SVGs, Lottie, and Network images in a single call.
