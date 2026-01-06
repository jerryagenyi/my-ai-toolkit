---
name: Code Style
description: Coding conventions and style preferences. Use for any code generation - TypeScript, JavaScript, PHP, naming conventions, async patterns, testing patterns. Contains learned preferences for Laravel/PHP and Vue/Next.js/TypeScript.
---

# Code Style

Coding conventions and style preferences. Updated by the Reflect skill.

## Last Updated
2025-01-28

## TypeScript / JavaScript

### General
- Use TypeScript for all new files
- Enable strict mode in `tsconfig.json`
- Avoid `any` type at all costs
- Use interface for object shapes, type for unions/primitives

### Naming
- **Components:** PascalCase (`UserProfile.vue`, `DataManager.ts`)
- **Functions/Methods:** camelCase (`getUserData()`, `handleSubmit()`)
- **Constants:** UPPER_SNAKE_CASE (`API_BASE_URL`, `MAX_RETRIES`)
- **Private properties:** underscore prefix (`_internalState`)

### Async/Await
- Prefer async/await over Promise chains
- Always handle errors with try/catch
- Don't forget `await` keyword (common bug!)

### Vue 3 Composition API
- Use `<script setup lang="ts">` syntax
- Composables start with `use` prefix (`useUserData()`, `useAuth()`)
- Reactive primitives use `ref()`, objects use `reactive()`
- Destructure refs with `.value` when needed

## PHP / Laravel

### General
- Follow PSR-12 coding standard
- Use strict types (`declare(strict_types=1)`)
- Type all method parameters and return values

### Naming
- **Classes:** PascalCase (`UserController`, `UserService`)
- **Methods:** camelCase (`getUserById()`, `createOrder()`)
- **Variables:** snake_case (`$user_id`, `$order_data`)
- **Constants:** UPPER_SNAKE_CASE (`API_TIMEOUT`, `MAX_ATTEMPTS`)

### Laravel Specifics
- Use Form Request classes for validation
- Put business logic in Services, not Controllers
- Use Laravel's dependency injection
- Eloquent: use relationships, avoid N+1 queries

## Testing

### General
- Write tests BEFORE fixing bugs (regression tests)
- One assertion per test when possible
- Use descriptive test names (`should_return_error_when_user_not_found()`)

### PHPUnit (Laravel)
- Test classes end with `Test` suffix
- Use `@test` attribute for test methods
- Mock external dependencies (APIs, databases)

### Vitest (Frontend)
- Group related tests with `describe()`
- Use `test()` instead of `it()` for consistency
- Mock async operations properly

## Learned Patterns

*This section grows as the Reflect skill learns from sessions*

### Session 2025-01-28
- Learned: Always use `?.` optional chaining for nested object access
- Learned: Prefer `for...of` loops over `.forEach()` for better TypeScript inference
- Learned: Use early returns to reduce nesting
