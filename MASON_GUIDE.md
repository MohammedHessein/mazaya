# Mason Scaffolding Guide

This guide explains how to use Mason to import this project structure or scaffold features in a new project.

## Using Bricks in a New Project

To use these bricks in a brand new Flutter project, follow these steps in order:

1. **Initialize Mason** (if not already done in the new project):
   ```bash
   mason init
   ```

2. **Add the Feature Brick**:
   You need to point to the absolute path where this `feature` brick is located.
   ```bash
   mason add feature --path <path_to_this_repo>/bricks/feature
   ```

3. **Install the Bricks**:
   ```bash
   mason get
   ```

4. **Initialize the Base Project Structure** (Non-interactive):
   ```bash
   mason make flutter_clean_base --name <project_name>
   ```

5. **Generate a Feature** (Non-interactive):
   ```bash
   mason make feature --name <feature_name>
   ```

---

## Scaffold a New Feature (In this Project)

To create a new feature following the project's architecture (Clean Architecture + BLoC/Cubit), run the following command in your terminal:

```bash
mason make feature --name <feature_name>
```

Replace `<feature_name>` with the name of your feature in `snake_case`.

### Example
If you want to create a "user_profile" feature:
```bash
mason make feature --name user_profile
```

### What this does:
It will create the following structure in `lib/src/features/user_profile/`:
- `entity/`: For your data entities and models.
- `presentation/`:
  - `imports/view_imports.dart`: Consolidated imports and parts.
  - `cubits/`: Contains `user_profile_cubit.dart` and `user_profile_state.dart`.
  - `view/`: Contains `user_profile_screen.dart` with a pre-configured `BlocProvider`.
  - `widgets/`: For feature-specific small widgets.

## Post-Generation Steps
After generating a feature, always run the code generator to register the new Cubit in the service locator:

```bash
dart run build_runner build --delete-conflicting-outputs
```
