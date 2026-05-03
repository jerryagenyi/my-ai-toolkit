# Security Scanning Tools

> Mandatory for all Docker projects. Non-negotiable.

## Tool Selection

| Tool | Best For | Stage |
|------|----------|-------|
| **Trivy** | Comprehensive scanning (images, configs, CI/CD) | Pre-deploy, CI/CD, scheduled |
| **Docker Scout** | Quick local scans, image comparison (Docker Desktop) | Development, quick checks |

## Trivy (Recommended)

### Install
```bash
brew install trivy  # macOS
# Or: https://github.com/aquasecurity/trivy/releases
```

### Usage
```bash
# Scan image
trivy image <image-name>

# Scan with severity filter
trivy image --severity HIGH,CRITICAL <image>

# Scan docker-compose config
trivy config docker-compose.yml

# Scan all images in compose
trivy image $(docker-compose config --images)

# Generate HTML report
trivy image --format template --template "@contrib/html.tpl" --output report.html <image>
```

### When to Use
- Before ANY deployment
- In CI/CD pipeline (block on CRITICAL)
- Weekly automated scans
- After updating base images

## Docker Scout (Alternative)

### Usage
```bash
docker scout quickview
docker scout cves <image>
docker scout compare <old-image> <new-image>
```

### When to Use
- Quick local vulnerability check during development
- Comparing two image versions
- Docker Desktop users wanting built-in scanning

## CI/CD Integration

See `conventions/security.md` for the GitHub Actions workflow template.

## Scanning Checklist
- [ ] Trivy or Docker Scout installed
- [ ] Security scanning script created
- [ ] CI/CD pipeline includes scanning
- [ ] Weekly automated scans configured
- [ ] Pre-deployment checks in place
- [ ] Vulnerability tracking system set up
- [ ] Remediation process documented
