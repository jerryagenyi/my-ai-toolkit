# Docker Security Policies (MANDATORY)

> All Docker Compose files and Dockerfiles in projects using this toolkit MUST follow these requirements.

---

## 1. Non-Root Users

All containers MUST run as non-root users.

- Add `USER` directive in Dockerfiles
- Add `user:` specification in docker-compose.yml
- **Exception:** Apache/nginx may need root for port 80, but must drop privileges immediately

## 2. Security Options

ALL services MUST include:

```yaml
security_opt:
  - no-new-privileges:true
```

Prevents privilege escalation attacks.

## 3. Secrets Management

- NEVER hardcode secrets in docker-compose.yml or Dockerfiles
- Use environment variables: `${SECRET_NAME}`
- Use Docker secrets for production
- Add `.env` files to `.gitignore`

## 4. Docker Socket Mounts

- NEVER mount `/var/run/docker.sock` without read-only flag
- If write access required (e.g., Watchtower), add security warnings in compose file
- Consider Docker-in-Docker (DinD) or rootless Docker for better isolation

## 5. Resource Limits

Add resource limits to prevent DoS:

```yaml
deploy:
  resources:
    limits:
      cpus: '2'
      memory: 1G
```

## 6. File Permissions

- Use `755` or `750`, NEVER `777` (world-write access)
- Set proper ownership in Dockerfiles

## 7. Base Images

- Prefer minimal images (alpine, distroless)
- Pin to specific tags, avoid `:latest`
- Regularly scan for CVEs (Trivy, Docker Scout)

## 8. Network Security

- Use bridge networks, avoid host network mode
- Only expose necessary ports
- Use health checks for service dependencies

## 9. Security Scanning (MANDATORY)

- Scan images before deployment using Trivy or Docker Scout
- Integrate scanning into CI/CD pipeline
- Set up weekly automated scans
- Fix HIGH and CRITICAL vulnerabilities immediately
- Document MEDIUM and LOW vulnerabilities for review

---

## Security Checklist for Every Docker Project

- [ ] All containers run as non-root
- [ ] `security_opt: - no-new-privileges:true` on all services
- [ ] No hardcoded secrets
- [ ] Docker socket mounts are read-only (if needed)
- [ ] Resource limits defined
- [ ] File permissions are secure (755/750, not 777)
- [ ] Minimal base images used
- [ ] Images pinned to specific tags
- [ ] Health checks configured
- [ ] Security scanning integrated (Trivy/Docker Scout)
- [ ] CI/CD pipeline includes vulnerability scanning

---

## Security Scanning Workflow

```yaml
# .github/workflows/security-scan.yml
name: Docker Security Scan
on:
  push:
    paths: ['docker-compose*.yml', '**/Dockerfile*']
  schedule:
    - cron: '0 0 * * 0'  # Weekly

jobs:
  scan:
    runs-on: ubuntu-latest
    steps:
      - uses: aquasecurity/trivy-action@master
        with:
          scan-type: 'image'
          scan-ref: 'your-image:latest'
          severity: 'CRITICAL,HIGH'
          exit-code: '1'
```

---

## Regular Security Maintenance

| Cadence | Action |
|---------|--------|
| Weekly | Automated vulnerability scans |
| Monthly | Review and update base images |
| Quarterly | Rotate secrets and credentials |
| Annually | Full security audit and penetration testing |

---

## Quick Security Commands

```bash
# Install Trivy
brew install trivy  # macOS

# Scan all images in a compose project
trivy image $(docker-compose config --images)

# Scan with severity filter
trivy image --severity HIGH,CRITICAL <image>

# Scan docker-compose config
trivy config docker-compose.yml
```
