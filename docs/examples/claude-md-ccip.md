# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

**Note:** This guide focuses on **local development environment** setup and workflows. For production deployment information, see `docs/DEPLOYMENT_WORKFLOW.md` and `docs/DOKPLOY-COMPLETE-GUIDE.md`.

## Development Commands

### Docker (Recommended)
```bash
# Start all services
docker-compose up

# Start specific service
docker-compose up backend    # Laravel API on port 8000
docker-compose up frontend   # Vue 3 + Quasar on port 5173

# Stop services
docker-compose down
```

### Backend (Laravel 10)
```bash
cd backend

# Setup
composer install
cp .env.example .env
php artisan key:generate
php artisan migrate

# Development
php artisan serve

# Code Style (PSR-12)
php artisan pint          # Format code with Laravel Pint

# Testing
php artisan test
```

### Frontend (Vue 3 + Quasar)
```bash
cd frontend

# Setup
npm install

# Development
npm run dev

# Linting & Formatting
npm run lint              # ESLint check + auto-fix
npm run lint:check        # ESLint check only (no fix)
npm run format            # Prettier format
npm run format:check      # Prettier check only

# Build for production
npm run build

# Testing
npm run test              # Unit tests with Vitest
npm run test:ui           # Vitest UI
npm run test:coverage     # Coverage report
npm run test:e2e          # E2E tests with Playwright (localhost)
npm run test:e2e:headed   # E2E with visible browser
npm run test:e2e:ui       # E2E UI mode
npm run test:e2e:debug    # E2E debug mode
npm run test:e2e:codegen  # Playwright code generator

# Production Testing (optional - tests against live deployment)
npm run test:e2e:prod     # E2E tests against production URLs
npm run test:e2e:prod:headed  # E2E tests with visible browser
```

## Architecture Overview

### System Structure
- **Platform**: Crisis Communication Intelligence Platform (CCIP) for public health crisis management
- **Target**: Low-bandwidth environments, African health contexts
- **Stack**: Laravel 10 API + Vue 3 + Quasar PWA + PostgreSQL + MinIO + Redis

### Key Architectural Concepts

1. **BMAD Method Development**: All features follow Epic → Story → Implementation workflow
 - Epic specifications in `docs/epics/epic-XXX-feature-name.md`
 - User stories in `docs/stories/US-XXX-story-name.md`
 - Sprint status tracked in `_bmad-output/implementation-artifacts/sprint-status.yaml`
 - Always check relevant epics and stories before implementation

2. **Hierarchical Organization System**:
   - Multi-level role-based access (Super Admin → Admin → Sub-admin → User)
   - Organizations can be linked and transferred
   - Users can have different roles across organizations

3. **Global Platform Design**:
   - No country-specific code
   - Location stored as JSON
   - Generic administrative levels (national, regional, district, local, community)

### Backend Architecture (Laravel 10)
- **Authentication**: Laravel Sanctum (token-based)
- **Database**: PostgreSQL with soft deletes
- **File Storage**: S3-compatible (MinIO)
- **Permissions**: Spatie Laravel Permission package
- **API Versioning**: All endpoints under `/api/v1`

Key directories:
- `app/Http/Controllers/API/` - API controllers
- `app/Http/Controllers/Controller.php` - Base controller with standardized response methods
- `app/Models/` - Eloquent models with relationships
- `database/migrations/` - Database schema
- `app/Services/` - Business logic services

**API Response Standardization:**
All API controllers extend `App\Http\Controllers\Controller` which provides:
- `success($data, $message, $code)` - Standardized success responses
- `error($message, $code, $errors)` - Standardized error responses
- `paginated($data, $message)` - Standardized paginated responses

**Service Patterns:**
- `app/Services/AIService.php` - AI service with graceful fallback to mock data when OpenAI API fails
- Services handle errors gracefully and return fallback data when external APIs are unavailable

### Frontend Architecture (Vue 3 + Quasar)
- **Framework**: Vue 3 Composition API + Quasar for PWA capabilities
- **State Management**: Pinia stores
- **Routing**: Vue Router
- **HTTP Client**: Axios
- **Testing**: Vitest + Playwright

Key directories:
- `src/pages/` - Route components
- `src/components/` - Reusable components
- `src/stores/` - Pinia stores
- `src/composables/` - Vue composables

### Database Schema
Core entities:
- **Users** with roles and organization assignments
- **Organizations** with hierarchical structure
- **Activities** with workflow states (submit → approve/reject → complete)
- **Messages** for internal communication
- **Reports** for analytics and export
- **Files** with S3 storage integration

### Key Constraints
- **No mapping/GIS features** in MVP
- **Low-bandwidth optimization** required
- **Offline functionality** through PWA
- **Role-based security** strictly enforced

## Important Files
- Product Requirements: `_bmad-output/planning-artifacts/prd.md`
- Epic specifications: `docs/epics/epic-XXX-feature-name.md`
- User stories: `docs/stories/US-XXX-story-name.md`
- Architecture: `_bmad-output/planning-artifacts/architecture.md`
- Project Context: `docs/project_context.md` - Critical rules for AI agents
- Implementation plan: `IMPLEMENTATION_PLAN.md`
- Backend status: `backend/README.md`
- API endpoints: `docs/api/`

## Testing Strategy

### Local Development
- **Backend**: PHPUnit with feature tests (`php artisan test`)
- **Frontend**: Vitest for unit tests, Playwright for E2E (localhost)
- **API testing**: Postman collections (in docs)

### Production Testing (Optional)
- **E2E Production Tests**: `npm run test:e2e:prod` - Tests against live deployment
  - Frontend: `https://ccip.jerryagenyi.xyz`
  - Backend: `https://ccip-api.jerryagenyi.xyz/api/v1`
  - Use with caution - only for smoke testing production deployments
  - Requires production test credentials (see `frontend/tests/e2e/auth-production.spec.ts`)

**Playwright Setup:**
- `npm run playwright:install` - Install Playwright browsers
- `npm run playwright:install:deps` - Install system dependencies for Playwright
- `npm run playwright:report` - View HTML test report

## Error Handling Patterns

### AIService Fallback
The `AIService` class implements graceful degradation:
- Attempts OpenAI API call for semiotic analysis
- On failure, logs error and returns mock analysis data
- Ensures application continues functioning even when external AI service is unavailable
- See `app/Services/AIService.php::getMockAnalysis()` for fallback implementation