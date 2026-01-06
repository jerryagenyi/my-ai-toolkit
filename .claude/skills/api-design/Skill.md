---
name: API Design
description: API design patterns and REST conventions. Use for any API work - endpoint design, response formats, error handling, pagination, status codes. Contains learned preferences for Laravel and Next.js API patterns.
---

# API Design

API design patterns and conventions. Updated by the Reflect skill.

## Last Updated
2025-01-28

## RESTful Conventions

### Endpoint Structure

| Pattern | Example | Description |
|---------|---------|-------------|
| `GET /resources` | `GET /users` | List all resources |
| `GET /resources/{id}` | `GET /users/123` | Get single resource |
| `POST /resources` | `POST /users` | Create new resource |
| `PUT /resources/{id}` | `PUT /users/123` | Replace resource |
| `PATCH /resources/{id}` | `PATCH /users/123` | Partial update |
| `DELETE /resources/{id}` | `DELETE /users/123` | Delete resource |

### Relationships
- Use nested paths for 1:1 relationships: `/users/{id}/profile`
- Use query params for 1:N relationships: `/users/{id}/posts?limit=10`
- Avoid nesting deeper than 2 levels

## Response Format

### Success Response
```json
{
  "success": true,
  "data": {
    "id": 123,
    "name": "Example"
  },
  "meta": {
    "page": 1,
    "per_page": 20,
    "total": 100
  }
}
```

### Error Response
```json
{
  "success": false,
  "error": {
    "message": "User not found",
    "code": "USER_NOT_FOUND",
    "details": {
      "field": "user_id",
      "value": 999
    }
  }
}
```

## HTTP Status Codes

| Code | Usage | Example |
|------|-------|---------|
| 200 | Success (GET, PATCH) | User retrieved successfully |
| 201 | Created (POST) | User created successfully |
| 204 | No Content (DELETE) | User deleted successfully |
| 400 | Bad Request | Validation failed |
| 401 | Unauthorized | Not logged in |
| 403 | Forbidden | Logged in, no permission |
| 404 | Not Found | Resource doesn't exist |
| 422 | Unprocessable Entity | Validation error |
| 500 | Server Error | Something went wrong |

## Pagination

### Query Parameters
```
GET /users?page=1&per_page=20&sort=created_at&order=desc
```

### Response Structure
```json
{
  "data": [...],
  "meta": {
    "page": 1,
    "per_page": 20,
    "total": 100,
    "pages": 5
  },
  "links": {
    "first": "/users?page=1",
    "last": "/users?page=5",
    "prev": null,
    "next": "/users?page=2"
  }
}
```

## Laravel Implementation

### Controller Structure
```php
class UserController extends Controller
{
    public function index(Request $request): JsonResponse
    {
        $page = $request->input('page', 1);
        $perPage = $request->input('per_page', 20);

        $users = User::paginate($perPage);

        return response()->json([
            'success' => true,
            'data' => $users->items(),
            'meta' => [
                'page' => $page,
                'per_page' => $perPage,
                'total' => $users->total(),
            ]
        ]);
    }
}
```

## Next.js Implementation

### API Route Structure
```
app/api/
├── users/
│   ├── route.ts          # GET /api/users, POST /api/users
│   └── [id]/
│       └── route.ts      # GET/PATCH/DELETE /api/users/[id]
```

## Learned Patterns

*This section grows as the Reflect skill learns from sessions*

### Session 2025-01-28
- Learned: Always include `success` boolean in responses for easy error checking
- Learned: Use ISO 8601 format for all timestamps
- Learned: Return 204 No Content for DELETE (not 200 with empty body)
