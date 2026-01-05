# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Comprehensive community documentation (CONTRIBUTING.md, CODE_OF_CONDUCT.md, SECURITY.md)
- GitHub issue and PR templates for better collaboration
- Comprehensive CI/CD workflow with testing, linting, and security scanning
- Dependabot configuration for automated dependency updates
- Pre-commit hooks configuration
- EditorConfig for consistent code formatting
- Root Makefile for common development tasks
- Docker support with development and production Dockerfiles
- docker-compose.yml for local development environment
- BUILD_GUIDE.md with comprehensive build instructions
- ARCHITECTURE.md with system architecture documentation
- CHANGELOG.md for tracking changes
- .golangci.yml for Go linting configuration
- .markdownlint.json for Markdown linting
- Improved .gitignore with comprehensive ignore patterns

### Changed
- Updated package.json repository URL to point to fork
- Updated Go version requirement to 1.21+ in go.mod
- Enhanced README.md with more badges and better quick start section
- Removed outdated .travis.yml (replaced with GitHub Actions)

### Fixed
- Package.json now correctly references the fork repository

## [3.0.0] - Previous Release

See [RELEASE_NOTES.md](RELEASE_NOTES.md) for details about v3.0.0 and earlier releases.

### 🎯 Features
- Add home URL metadata support for navigation buttons
- Replace prettify with Highlight.js and add copy button plugin
- Add alignment support for tables in HTML rendering
- Auto-wrap download links in button nodes
- Fix infobox parsing

### 🚀 CI/CD
- Add GitHub Actions workflow for release automation
- Automated builds for macOS, Linux, and Windows (32/64-bit)

---

[Unreleased]: https://github.com/Stimu-li/codelab-tools/compare/v3.0.0...HEAD
[3.0.0]: https://github.com/Stimu-li/codelab-tools/releases/tag/v3.0.0
