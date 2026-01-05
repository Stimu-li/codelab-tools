# Contributing to CodeLab Tools

Thank you for your interest in contributing to CodeLab Tools! This document provides guidelines and instructions for contributing.

## Code of Conduct

This project adheres to a Code of Conduct that all contributors are expected to follow. Please read [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) before contributing.

## Getting Started

### Prerequisites

- **Go 1.21 or higher** - [Download Go](https://golang.org/dl/)
- **Node.js 20 or higher** - [Download Node.js](https://nodejs.org/)
- **Git** - [Download Git](https://git-scm.com/)

### Setting Up Development Environment

1. **Fork the repository** on GitHub
2. **Clone your fork**:
   ```bash
   git clone https://github.com/YOUR_USERNAME/codelab-tools.git
   cd codelab-tools
   ```
3. **Add upstream remote**:
   ```bash
   git remote add upstream https://github.com/Stimu-li/codelab-tools.git
   ```

### Building the Project

#### CLaaT CLI Tool

```bash
cd claat
make
```

The binary will be in `claat/bin/claat`.

#### Codelab Elements

```bash
npm install
npm run build
```

Built files will be in `codelab-elements/build/`.

### Running Tests

#### Go Tests

```bash
cd claat
make test
```

#### JavaScript Tests

```bash
npm test
```

### Running the Development Server

```bash
cd claat/bin
./claat serve
```

Visit `http://localhost:9090` to view codelabs.

## How to Contribute

### Reporting Bugs

Before creating bug reports, please check existing issues to avoid duplicates. When creating a bug report, include:

- **Clear title and description**
- **Steps to reproduce** the issue
- **Expected vs actual behavior**
- **Environment details** (OS, Go version, Node version)
- **Screenshots** if applicable
- **Error messages** or logs

Use the bug report issue template when available.

### Suggesting Enhancements

Enhancement suggestions are welcome! Please include:

- **Clear use case** - Why is this enhancement needed?
- **Proposed solution** - How should it work?
- **Alternatives considered** - What other approaches did you think about?
- **Mockups or examples** if applicable

### Pull Requests

1. **Create a topic branch** from `main`:
   ```bash
   git checkout -b feature/my-feature
   ```

2. **Make your changes**:
   - Follow the coding style of the project
   - Add tests for new functionality
   - Update documentation as needed
   - Keep commits focused and atomic

3. **Test your changes**:
   ```bash
   # Test Go code
   cd claat && make test lint
   
   # Test JavaScript
   npm test
   ```

4. **Commit your changes**:
   ```bash
   git commit -m "Add feature: brief description"
   ```
   
   Follow [Conventional Commits](https://www.conventionalcommits.org/) format:
   - `feat:` - New feature
   - `fix:` - Bug fix
   - `docs:` - Documentation changes
   - `style:` - Code style changes (formatting, etc.)
   - `refactor:` - Code refactoring
   - `test:` - Adding or updating tests
   - `chore:` - Maintenance tasks

5. **Push to your fork**:
   ```bash
   git push origin feature/my-feature
   ```

6. **Open a Pull Request** on GitHub with:
   - Clear title describing the change
   - Description of what and why
   - Reference to related issues (e.g., "Fixes #123")
   - Screenshots for UI changes

### Coding Standards

#### Go Code

- Follow [Effective Go](https://golang.org/doc/effective_go.html)
- Use `gofmt` for formatting
- Use `golint` for linting
- Write meaningful comments for exported functions
- Keep functions small and focused
- Add unit tests for new code

#### JavaScript Code

- Follow existing code style
- Use meaningful variable names
- Add JSDoc comments for functions
- Test interactive features
- Consider accessibility

#### Documentation

- Use clear, concise language
- Include code examples
- Update relevant README files
- Add inline comments for complex logic

## Project Structure

```
codelab-tools/
├── claat/              # CLI tool (Go)
│   ├── cmd/            # Command implementations
│   ├── parser/         # Document parsers (Markdown, Google Docs)
│   ├── render/         # Output renderers (HTML, Markdown)
│   ├── nodes/          # AST node types
│   └── types/          # Type definitions
├── codelab-elements/   # Web components (JavaScript)
│   ├── google-codelab/ # Main codelab element
│   ├── google-codelab-step/
│   ├── google-codelab-about/
│   ├── google-codelab-survey/
│   └── google-codelab-analytics/
├── catalog/            # Static catalog site
├── sample-codelabs/    # Example codelabs
└── .github/            # GitHub workflows
```

## Development Workflow

1. **Sync with upstream**:
   ```bash
   git fetch upstream
   git checkout main
   git merge upstream/main
   ```

2. **Create feature branch**
3. **Make changes and test**
4. **Submit PR**
5. **Address review feedback**
6. **Merge** (maintainers will merge approved PRs)

## Release Process

Releases are managed by maintainers:

1. Update `RELEASE_NOTES.md`
2. Update version in `claat/VERSION`
3. Create and push a version tag (e.g., `v3.1.0`)
4. GitHub Actions will build and publish binaries

## Questions?

- **Issues**: [GitHub Issues](https://github.com/Stimu-li/codelab-tools/issues)
- **Discussions**: [GitHub Discussions](https://github.com/Stimu-li/codelab-tools/discussions)
- **Original Google Group**: [codelab-authors](https://groups.google.com/g/codelab-authors)

## License

By contributing, you agree that your contributions will be licensed under the Apache License 2.0.

## Recognition

Contributors will be recognized in release notes and the project's contributor list. Thank you for helping make CodeLab Tools better!
