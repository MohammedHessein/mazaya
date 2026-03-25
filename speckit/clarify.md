# ❓ Hattrick App – Clarifications & Decisions Log

## Architecture Decisions

### ADR-001: AsyncCubit Standard
- **Decision**: All feature state management MUST extend `AsyncCubit` (or `PaginatedCubit` for lists).
- **Rationale**: Standardizes loading/error handling across the app and reduces boilerplate.

### ADR-002: Base CRUD UseCase
- **Decision**: Use `baseCrudUseCase` for all standard API interactions.
- **Rationale**: Centralizes logic for mapping, status handling, and error processing via `BaseModel`.

### ADR-003: Go Class for Navigation
- **Decision**: Centralize all routing logic in the `Go` utility.
- **Rationale**: Simplifies the navigation API and allows for future centralized routing improvements.

---

## Technical Clarifications

### Q: Why RTL-first?
**A**: The project is primarily for the Arabic market. Designing RTL-first ensures that the UI is perfectly aligned for Arabic speakers and reduces "fixing" effort for LTR (English) locales.

### Q: How do we handle specific UI widgets?
**A**: Use `IconWidget` for all icons and `CachedImage` for all network images. These are optimized for the project's theme and performance needs.

### Q: Where are the core design tokens?
**A**: `lib/src/config/res/` contains:
- `ColorManager`: Semantically named colors.
- `AppSizes`: Centralized padding, font sizes, and radii.
- `ConstantManager`: Global UI and API constants.
