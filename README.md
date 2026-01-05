# CodeLab Tools - Codelabs Authoring & Publishing System

> **Fork of [googlecodelabs/tools](https://github.com/googlecodelabs/tools)** - This is a maintained version of the original (now archived) project with bug fixes and new features.

A complete toolkit for creating, building, and publishing interactive tutorials (codelabs) from Markdown or Google Docs. This modernized fork includes enhanced features, improved build system, and comprehensive documentation.

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](LICENSE)
[![Go Version](https://img.shields.io/badge/Go-1.21+-blue.svg)](https://golang.org/)
[![Node Version](https://img.shields.io/badge/Node-20+-green.svg)](https://nodejs.org/)
[![GitHub Release](https://img.shields.io/github/v/release/Stimu-li/codelab-tools)](https://github.com/Stimu-li/codelab-tools/releases/latest)
[![CI Status](https://img.shields.io/github/actions/workflow/status/Stimu-li/codelab-tools/ci.yml?branch=main&label=CI)](https://github.com/Stimu-li/codelab-tools/actions/workflows/ci.yml)
[![Go Report Card](https://goreportcard.com/badge/github.com/Stimu-li/codelab-tools)](https://goreportcard.com/report/github.com/Stimu-li/codelab-tools)

## What's Included

This repository contains everything you need to create and publish professional codelabs:

- **`claat/`** - CLI tool for converting Markdown/Google Docs to HTML codelabs
- **`codelab-elements/`** - Web components for rendering interactive codelabs
- **`catalog/`** - Static site generator for browsing multiple codelabs
- **`sample-codelabs/`** - Example codelabs demonstrating all features

## ✨ Key Features

### Content Creation
- 📝 **Markdown Support** - Write codelabs in simple Markdown
- 📄 **Google Docs Import** - Convert Google Docs to codelabs
- 🎨 **Rich Formatting** - Code blocks, images, tables, lists, and more
- 📊 **Interactive Elements** - Surveys, quizzes, and embedded media
- ⏱️ **Duration Tracking** - Automatic time estimates for each step

### Publishing
- 🚀 **Static Output** - No server required, host anywhere
- 📱 **Responsive Design** - Works on desktop, tablet, and mobile
- 🌓 **Dark Mode** - Automatic theme switching
- 🔍 **SEO Friendly** - Semantic HTML with proper meta tags
- ♿ **Accessible** - WCAG compliant with keyboard navigation

### Development
- 🛠️ **Local Preview** - Built-in HTTP server for testing
- 🔄 **Hot Reload** - Auto-update on changes
- 📦 **Easy Deployment** - Export to GitHub Pages, Netlify, etc.
- 🎯 **Custom Templates** - Create your own designs
- 📈 **Analytics Integration** - Google Analytics 4 support

### Developer Tools
- 🐳 **Docker Support** - Containerized development environment
- 🧪 **Comprehensive Tests** - Unit and integration testing
- 📐 **Linting** - Go, Markdown, and JavaScript linters
- 🔒 **Security Scanning** - Automated vulnerability detection
- 📚 **Documentation** - Extensive guides and examples

## Quick Start

```bash
# Download and install CLaaT
# See releases page for pre-built binaries
# https://github.com/Stimu-li/codelab-tools/releases/latest

# Or build from source
git clone https://github.com/Stimu-li/codelab-tools.git
cd codelab-tools
make build

# Export a markdown file to a codelab
claat export your-tutorial.md

# Start local preview server
claat serve
```

For detailed setup instructions, see the [Build Guide](BUILD_GUIDE.md).

## Installation

The easiest way is to download pre-compiled binaries from the [Releases page](https://github.com/Bit-Blazer/codelab-tools/releases/latest).

## Documentation

### Core Documentation
- **[Quick Start Guide](#quick-start)** - Get started in 5 minutes
- **[CLaaT Tool Guide](claat/README.md)** - Complete CLI documentation
- **[Markdown Format Guide](claat/parser/md/README.md)** - Syntax reference for authoring
- **[Codelab Elements](codelab-elements/README.md)** - Web components documentation
- **[Catalog System](catalog/README.md)** - Building a codelab catalog site

### Developer Resources
- **[Build Guide](BUILD_GUIDE.md)** - Building from source
- **[Architecture](ARCHITECTURE.md)** - System architecture overview
- **[Contributing](CONTRIBUTING.md)** - How to contribute
- **[Troubleshooting](TROUBLESHOOTING.md)** - Common issues and solutions
- **[FAQ](FAQ.md)** - Frequently asked questions

### Project Information
- **[Release Notes](RELEASE_NOTES.md)** - What's new
- **[Changelog](CHANGELOG.md)** - Detailed change history
- **[Roadmap](ROADMAP.md)** - Future plans
- **[Security Policy](SECURITY.md)** - Security guidelines
- **[Code of Conduct](CODE_OF_CONDUCT.md)** - Community standards

## Examples

See live examples at the [deployed catalog](https://bit-blazer.github.io/codelab-tools/).

## License

Apache 2.0 - See [LICENSE](LICENSE) file

Original work by Google, modifications and enhancements by this fork.

## Community

- **Issues**: Report bugs or request features on [GitHub Issues](https://github.com/Bit-Blazer/codelab-tools/issues)
- **Discussions**: Share ideas in [GitHub Discussions](https://github.com/Bit-Blazer/codelab-tools/discussions)
- **Original Group**: [codelab-authors Google Group](https://groups.google.com/g/codelab-authors)
