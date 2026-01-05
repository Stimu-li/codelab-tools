# Security Policy

## Supported Versions

We actively support the following versions with security updates:

| Version | Supported          |
| ------- | ------------------ |
| 3.x.x   | :white_check_mark: |
| 2.x.x   | :x:                |
| 1.x.x   | :x:                |

## Reporting a Vulnerability

We take the security of CodeLab Tools seriously. If you discover a security vulnerability, please follow these steps:

### For Critical Vulnerabilities

If you discover a critical security vulnerability that could put users at immediate risk:

1. **DO NOT** open a public GitHub issue
2. **DO NOT** disclose the vulnerability publicly
3. Email the maintainers directly with details (see contact info below)
4. Include "SECURITY" in the email subject line

### For Non-Critical Vulnerabilities

For less severe security issues:

1. Open a GitHub Security Advisory at: https://github.com/Stimu-li/codelab-tools/security/advisories/new
2. Provide a detailed description of the vulnerability
3. Include steps to reproduce if possible
4. Suggest a fix if you have one

### What to Include in Your Report

Please provide as much information as possible:

- **Type of vulnerability** (XSS, injection, authentication bypass, etc.)
- **Affected component** (CLaaT, web elements, catalog, etc.)
- **Affected versions**
- **Step-by-step instructions to reproduce**
- **Proof of concept** or exploit code (if available)
- **Impact assessment** (what could an attacker do?)
- **Suggested fix** (if you have one)

### Response Timeline

- **Initial Response**: Within 48 hours
- **Status Update**: Within 7 days
- **Fix Timeline**: Depends on severity
  - Critical: Within 7 days
  - High: Within 30 days
  - Medium: Within 90 days
  - Low: Next regular release

### Disclosure Policy

We follow a responsible disclosure process:

1. You report the vulnerability privately
2. We confirm receipt and begin investigation
3. We develop and test a fix
4. We release the fix in a security update
5. We publicly disclose the vulnerability after users have had time to update (typically 30 days after fix release)

### Security Best Practices for Users

#### When Using CLaaT

- Keep CLaaT updated to the latest version
- Validate all input markdown/HTML files
- Be cautious when importing codelabs from untrusted sources
- Review generated HTML before publishing
- Use HTTPS for hosting codelabs

#### When Using Codelab Elements

- Always load web components from trusted CDNs or self-hosted locations
- Implement Content Security Policy (CSP) headers
- Sanitize user-generated content
- Keep dependencies updated
- Use Subresource Integrity (SRI) for external resources

#### When Hosting Codelabs

- Use HTTPS for all codelab sites
- Implement proper authentication if needed
- Keep web server software updated
- Use security headers (CSP, X-Frame-Options, etc.)
- Monitor for suspicious activity

### Known Security Considerations

#### Input Validation

CLaaT processes markdown and Google Docs content. Always:
- Validate input sources
- Review generated HTML
- Sanitize any user-generated content

#### XSS Prevention

The codelab elements include code execution for demos. When using:
- Validate all embedded content
- Use iframe sandboxing for untrusted content
- Implement CSP headers

#### Dependency Security

We regularly update dependencies, but you should:
- Check for security advisories on dependencies
- Use `npm audit` and `go mod` security scanning
- Keep your own deployments updated

### Security-Related Configuration

#### Content Security Policy Example

```
Content-Security-Policy: 
  default-src 'self'; 
  script-src 'self' 'unsafe-inline' 'unsafe-eval' cdn.jsdelivr.net; 
  style-src 'self' 'unsafe-inline' cdn.jsdelivr.net;
  img-src 'self' data: https:;
  font-src 'self' data:;
  connect-src 'self';
```

Note: `unsafe-inline` and `unsafe-eval` are currently needed for some features. We're working to remove these requirements.

## Vulnerability Scanning

We use automated security scanning:

- **Go dependencies**: `go mod` with vulnerability databases
- **npm dependencies**: `npm audit`
- **Code scanning**: CodeQL via GitHub Actions
- **Dependency updates**: Dependabot

## Security Updates

Security updates are published:

- As GitHub Security Advisories
- In release notes with `[SECURITY]` prefix
- Via GitHub notifications to watchers

## Contact

For security concerns:

- **GitHub Security Advisory**: https://github.com/Stimu-li/codelab-tools/security/advisories/new
- **GitHub Issues**: For non-sensitive security improvements
- **Discussions**: For security-related questions

## Acknowledgments

We appreciate responsible security researchers who help keep CodeLab Tools secure. Contributors who report valid security issues will be acknowledged in:

- Security advisories
- Release notes
- This security policy

Thank you for helping keep CodeLab Tools and its users safe!

## Additional Resources

- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [Web Security Best Practices](https://developers.google.com/web/fundamentals/security)
- [Content Security Policy Guide](https://developer.mozilla.org/en-US/docs/Web/HTTP/CSP)
