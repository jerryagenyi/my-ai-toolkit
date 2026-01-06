---
name: Security Practices
description: Security patterns and best practices. Use for any security-related work - input validation, authentication, authorization, secrets management, Docker security. Contains learned security preferences and requirements.
---

# Security Practices

Security patterns and best practices. Updated by the Reflect skill.

## Last Updated
2025-01-28

## Input Validation

### General Rules
- **NEVER** trust user input
- Validate on both client AND server
- Sanitize output to prevent XSS
- Use parameterized queries to prevent SQL injection

### Laravel Validation
```php
// Use Form Request classes
class StoreUserRequest extends FormRequest
{
    public function rules(): array
    {
        return [
            'email' => 'required|email|unique:users',
            'password' => 'required|min:8|confirmed',
        ];
    }
}
```

### TypeScript Validation
```typescript
// Use zod or similar for runtime validation
import { z } from 'zod'

const userSchema = z.object({
  email: z.string().email(),
  password: z.string().min(8),
})
```

## Authentication

### Laravel
```php
// Always check authentication
public function __construct()
{
    $this->middleware('auth');
}

// Use Gates/Policies for authorization
Gate::authorize('update', $user);
```

### Next.js
```typescript
// Middleware for route protection
export async function middleware(request: NextRequest) {
  const token = request.cookies.get('token')
  if (!token) return NextResponse.redirect('/login')
}
```

## Secrets Management

### Rules
- Never commit secrets to Git
- Use environment variables: `${SECRET_NAME}`
- Add `.env` files to `.gitignore`

### Laravel
```php
// Use env() with default values
$apiKey = env('API_KEY', 'default-value');

// Never use env() in production config (use config:cache)
config('services.api.key')
```

### Next.js
```typescript
// Server-side: use process.env
const apiKey = process.env.API_KEY

// Client-side: use NEXT_PUBLIC_ prefix
const publicUrl = process.env.NEXT_PUBLIC_API_URL
```

## Docker Security

### Mandatory Requirements

1. **Non-Root Users**
   ```yaml
   user: "1000:1000"  # Run as non-root
   ```

2. **Security Options**
   ```yaml
   security_opt:
     - no-new-privileges:true
   ```

3. **No Hardcoded Secrets**
   ```yaml
   environment:
     - DB_PASSWORD=${DB_PASSWORD}  # From .env
   ```

4. **Resource Limits**
   ```yaml
   deploy:
     resources:
       limits:
         cpus: '2'
         memory: 1G
   ```

### Security Scanning

**Trivy (Recommended):**
```bash
# Scan image
trivy image <image-name>

# Scan with severity filter
trivy image --severity HIGH,CRITICAL <image-name>
```

**Docker Scout:**
```bash
docker scout cves <image-name>
```

## Common Vulnerabilities

### SQL Injection
```php
// ❌ BAD
DB::select("SELECT * FROM users WHERE id = $id");

// ✅ GOOD
DB::select('SELECT * FROM users WHERE id = ?', [$id]);
// Or
User::where('id', $id)->first();
```

### XSS
```vue
<!-- ❌ BAD -->
<div v-html="userInput"></div>

<!-- ✅ GOOD -->
<div>{{ userInput }}</div>
```

### CSRF
```php
// Laravel: CSRF token is automatic in forms
@csrf

// Or include in AJAX headers
<meta name="csrf-token" content="{{ csrf_token() }}">
```

## Learned Patterns

*This section grows as the Reflect skill learns from sessions*

### Session 2025-01-28
- Learned: Always validate on server, never trust client validation
- Learned: Use prepared statements, never concatenate SQL
- Learned: Sanitize all user input before display
