# Build Guide

Complete guide for building and developing CodeLab Tools from source.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Building CLaaT](#building-claat)
- [Building Codelab Elements](#building-codelab-elements)
- [Running Tests](#running-tests)
- [Development Workflow](#development-workflow)
- [Troubleshooting](#troubleshooting)

## Prerequisites

### Required Software

1. **Go 1.21 or higher**
   ```bash
   # Check your Go version
   go version
   
   # Download from: https://golang.org/dl/
   ```

2. **Node.js 20 or higher**
   ```bash
   # Check your Node version
   node --version
   
   # Download from: https://nodejs.org/
   ```

3. **Git**
   ```bash
   # Check your Git version
   git --version
   
   # Download from: https://git-scm.com/
   ```

4. **Make** (usually pre-installed on Unix systems)
   - **Windows**: Install via [Chocolatey](https://chocolatey.org/) `choco install make`
   - **macOS**: Included with Xcode Command Line Tools
   - **Linux**: Usually pre-installed, or `apt install build-essential`

### Optional Tools

- **Bazelisk** - For advanced Bazel builds (installed via npm)
- **golangci-lint** - For Go linting ([installation](https://golangci-lint.run/usage/install/))
- **Docker** - For containerized development (optional)

## Quick Start

```bash
# Clone the repository
git clone https://github.com/Stimu-li/codelab-tools.git
cd codelab-tools

# Build CLaaT
cd claat
make
cd ..

# Build Codelab Elements
npm install
npm run build

# Test CLaaT
cd claat/bin
./claat version
```

## Building CLaaT

### Standard Build

```bash
cd claat
make
```

This creates `claat/bin/claat` (or `claat.exe` on Windows).

### Build for All Platforms

```bash
cd claat
make release
```

This creates binaries for:
- `claat-darwin-amd64` (macOS)
- `claat-linux-amd64` (Linux 64-bit)
- `claat-linux-386` (Linux 32-bit)
- `claat-windows-amd64.exe` (Windows 64-bit)
- `claat-windows-386.exe` (Windows 32-bit)

All binaries will be in `claat/bin/`.

### Build with Custom Version

```bash
cd claat
VERSION="3.0.0" make
```

### Development Build (No Optimization)

```bash
cd claat
go build -o bin/claat
```

This is faster for iterative development.

### Clean Build

```bash
cd claat
make clean
make
```

## Building Codelab Elements

### Prerequisites for Web Components

```bash
# Install Node dependencies (includes Bazelisk)
npm install
```

### Standard Build

```bash
npm run build
```

This:
1. Compiles SCSS to CSS
2. Processes Closure Templates
3. Bundles JavaScript with Closure Compiler
4. Outputs to `codelab-elements/build/`

Output files:
- `codelab-elements.min.js` - Minified JavaScript bundle
- `codelab-elements.min.css` - Minified CSS bundle

### Clean Build

```bash
npm run clean
npm run build
```

### Development Watch Mode

For active development, you can use Bazel watch mode:

```bash
# Install ibazel for watch mode
npm install -g @bazel/ibazel

# Watch for changes
ibazel build ...
```

## Running Tests

### Go Tests (CLaaT)

```bash
# Run all tests
cd claat
make test

# Run tests with coverage
go test -v -race -coverprofile=coverage.txt ./...

# Run tests for specific package
go test -v ./parser/md

# Run specific test
go test -v -run TestMarkdownParser ./parser/md
```

### JavaScript Tests

```bash
# Run all tests
npm test

# Individual component tests are in codelab-elements/*/test.js
```

### Linting

#### Go Code

```bash
cd claat

# Using golangci-lint (recommended)
golangci-lint run

# Or make target
make lint
```

#### Markdown

```bash
# Lint all markdown files
npx markdownlint-cli2 "**/*.md"
```

## Development Workflow

### 1. Setting Up Your Environment

```bash
# Fork the repo on GitHub, then:
git clone https://github.com/YOUR_USERNAME/codelab-tools.git
cd codelab-tools

# Add upstream remote
git remote add upstream https://github.com/Stimu-li/codelab-tools.git

# Install dependencies
npm install
cd claat && go mod download && cd ..
```

### 2. Creating a Feature Branch

```bash
git checkout -b feature/my-feature
```

### 3. Making Changes

#### For CLaaT Changes:

```bash
# Edit Go files in claat/
vim claat/parser/md/parse.go

# Build and test
cd claat
make
make test

# Try it out
./bin/claat export ../sample-codelabs/test-all-features.md
```

#### For Web Component Changes:

```bash
# Edit files in codelab-elements/
vim codelab-elements/google-codelab/google_codelab.js

# Rebuild
npm run build

# Test with sample codelab
cd claat
go build -o ../claat-bin
cd ../sample-codelabs
../claat-bin export -o ../test-output test-all-features.md
# Open test-output/*/index.html in browser
```

### 4. Running Local Tests

```bash
# Before committing, always run:
cd claat
make test lint
cd ..
npm test
```

### 5. Local Preview

```bash
# Start local server
cd claat/bin
./claat serve

# Visit http://localhost:9090
```

### 6. Committing Changes

```bash
git add .
git commit -m "feat: add new feature"
git push origin feature/my-feature
```

Then open a Pull Request on GitHub.

## Common Development Tasks

### Testing a Markdown File

```bash
cd claat
./bin/claat export ../sample-codelabs/your-codelab.md
./bin/claat serve
```

### Debugging Parser Issues

```bash
cd claat
# Add debug prints in code
go build -o bin/claat
./bin/claat export -o - your-file.md | less
```

### Updating Dependencies

#### Go Modules

```bash
cd claat

# Update all dependencies
go get -u ./...
go mod tidy

# Update specific dependency
go get -u github.com/yuin/goldmark@latest
go mod tidy
```

#### npm Packages

```bash
# Check for outdated packages
npm outdated

# Update all packages
npm update

# Update specific package
npm install @bazel/bazelisk@latest
```

### Creating a Release Build

```bash
# Update version
echo "3.1.0" > claat/VERSION

# Build all platforms
cd claat
make release

# Verify binaries
ls -lh bin/
```

## Troubleshooting

### Go Build Issues

**Problem**: `go: command not found`
```bash
# Solution: Install Go or add to PATH
export PATH=$PATH:/usr/local/go/bin
```

**Problem**: Module errors
```bash
# Solution: Clean and re-download
cd claat
go clean -modcache
go mod download
```

### Bazel Build Issues

**Problem**: Bazel version mismatch
```bash
# Solution: Clean Bazel cache
npm run clean
rm -rf ~/.cache/bazel
npm run build
```

**Problem**: `bazel: command not found`
```bash
# Solution: Install via npm (included in devDependencies)
npm install
# Use via npm scripts: npm run build
```

### Node/npm Issues

**Problem**: npm install fails
```bash
# Solution: Clear cache
npm cache clean --force
rm -rf node_modules package-lock.json
npm install
```

### Windows-Specific Issues

**Problem**: Line ending issues (CRLF vs LF)
```bash
# Solution: Configure Git
git config --global core.autocrlf input
```

**Problem**: Make not found
```bash
# Solution: Install make via Chocolatey
choco install make
```

### Permission Issues (Linux/macOS)

**Problem**: Permission denied when running binary
```bash
# Solution: Add execute permission
chmod +x claat/bin/claat
```

## Platform-Specific Notes

### macOS

- If you get security warnings when running binaries, go to System Preferences > Security & Privacy
- You may need to install Xcode Command Line Tools: `xcode-select --install`

### Windows

- Use PowerShell or Git Bash for better compatibility
- Consider using WSL2 for a Linux-like environment
- Some scripts may need adjustment for Windows paths

### Linux

- Ensure you have build-essential installed: `sudo apt-get install build-essential`
- May need to install additional libraries depending on distribution

## CI/CD Integration

The repository uses GitHub Actions for automated builds and tests. See `.github/workflows/` for configurations.

### Running CI Locally

You can use [act](https://github.com/nektos/act) to run GitHub Actions locally:

```bash
# Install act
# Then run workflow
act push
```

## Additional Resources

- [Go Documentation](https://golang.org/doc/)
- [Bazel Documentation](https://bazel.build/docs)
- [Closure Compiler](https://developers.google.com/closure/compiler)
- [Contributing Guide](CONTRIBUTING.md)

## Getting Help

- **Issues**: [GitHub Issues](https://github.com/Stimu-li/codelab-tools/issues)
- **Discussions**: [GitHub Discussions](https://github.com/Stimu-li/codelab-tools/discussions)
- **Documentation**: [README.md](README.md)
