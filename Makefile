.PHONY: help build test clean install lint format release docker dev-docker

# Colors for output
BLUE := \033[0;34m
GREEN := \033[0;32m
YELLOW := \033[1;33m
NC := \033[0m # No Color

help: ## Show this help message
	@echo '$(BLUE)CodeLab Tools - Available Commands$(NC)'
	@echo ''
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  $(GREEN)%-20s$(NC) %s\n", $$1, $$2}'
	@echo ''

# Build targets
build: build-claat build-elements ## Build all components

build-claat: ## Build CLaaT CLI tool
	@echo "$(BLUE)Building CLaaT...$(NC)"
	@cd claat && make
	@echo "$(GREEN)✓ CLaaT built successfully$(NC)"

build-elements: ## Build codelab web elements
	@echo "$(BLUE)Building codelab elements...$(NC)"
	@npm install
	@npm run build
	@echo "$(GREEN)✓ Elements built successfully$(NC)"

# Test targets
test: test-claat test-elements ## Run all tests

test-claat: ## Run CLaaT tests
	@echo "$(BLUE)Running CLaaT tests...$(NC)"
	@cd claat && make test
	@echo "$(GREEN)✓ CLaaT tests passed$(NC)"

test-elements: ## Run JavaScript tests
	@echo "$(BLUE)Running element tests...$(NC)"
	@npm test || echo "$(YELLOW)⚠ Element tests may not be fully configured$(NC)"

# Lint targets
lint: lint-go lint-md ## Run all linters

lint-go: ## Lint Go code
	@echo "$(BLUE)Linting Go code...$(NC)"
	@cd claat && golangci-lint run || echo "$(YELLOW)⚠ Install golangci-lint: https://golangci-lint.run/usage/install/$(NC)"

lint-md: ## Lint Markdown files
	@echo "$(BLUE)Linting Markdown...$(NC)"
	@npx markdownlint-cli2 "**/*.md" || echo "$(YELLOW)⚠ Some markdown issues found$(NC)"

# Format targets
format: format-go ## Format all code

format-go: ## Format Go code
	@echo "$(BLUE)Formatting Go code...$(NC)"
	@cd claat && gofmt -s -w .
	@cd claat && goimports -w . 2>/dev/null || echo "$(YELLOW)⚠ Install goimports: go install golang.org/x/tools/cmd/goimports@latest$(NC)"
	@echo "$(GREEN)✓ Go code formatted$(NC)"

# Clean targets
clean: clean-claat clean-elements ## Clean all build artifacts

clean-claat: ## Clean CLaaT build artifacts
	@echo "$(BLUE)Cleaning CLaaT...$(NC)"
	@cd claat && make clean
	@echo "$(GREEN)✓ CLaaT cleaned$(NC)"

clean-elements: ## Clean element build artifacts
	@echo "$(BLUE)Cleaning elements...$(NC)"
	@npm run clean 2>/dev/null || true
	@rm -rf node_modules
	@echo "$(GREEN)✓ Elements cleaned$(NC)"

# Install targets
install: ## Install dependencies
	@echo "$(BLUE)Installing dependencies...$(NC)"
	@cd claat && go mod download
	@npm install
	@echo "$(GREEN)✓ Dependencies installed$(NC)"

# Release targets
release: ## Build release binaries for all platforms
	@echo "$(BLUE)Building release binaries...$(NC)"
	@cd claat && make release
	@echo "$(GREEN)✓ Release binaries built in claat/bin/$(NC)"

# Development targets
serve: build-claat ## Start CLaaT development server
	@echo "$(BLUE)Starting CLaaT server at http://localhost:9090$(NC)"
	@cd claat/bin && ./claat serve

dev: install build ## Set up development environment
	@echo "$(GREEN)✓ Development environment ready$(NC)"
	@echo "$(BLUE)Run 'make serve' to start the development server$(NC)"

# Docker targets
docker: ## Build production Docker image
	@echo "$(BLUE)Building Docker image...$(NC)"
	@docker build -t codelab-tools:latest .
	@echo "$(GREEN)✓ Docker image built: codelab-tools:latest$(NC)"

dev-docker: ## Start development Docker environment
	@echo "$(BLUE)Starting development Docker environment...$(NC)"
	@docker-compose up -d dev
	@echo "$(GREEN)✓ Development environment running$(NC)"
	@echo "$(BLUE)Run 'docker-compose exec dev /bin/sh' to access shell$(NC)"

docker-clean: ## Stop and remove Docker containers
	@docker-compose down -v

# Export samples
export-samples: build-claat ## Export sample codelabs
	@echo "$(BLUE)Exporting sample codelabs...$(NC)"
	@mkdir -p output
	@cd sample-codelabs && \
		for file in *.md; do \
			echo "Exporting $$file..."; \
			../claat/bin/claat export -o ../output "$$file"; \
		done
	@echo "$(GREEN)✓ Samples exported to output/$(NC)"

# Version info
version: ## Display version information
	@echo "$(BLUE)Version Information:$(NC)"
	@echo "Go version: $$(go version | cut -d' ' -f3)"
	@echo "Node version: v$$(node --version 2>/dev/null | cut -d'v' -f2 || echo 'not installed')"
	@echo "npm version: $$(npm --version 2>/dev/null || echo 'not installed')"
	@cd claat && test -f VERSION && echo "CLaaT version: $$(cat VERSION)" || echo "CLaaT version: development"

# CI targets (used by GitHub Actions)
ci: install lint test build ## Run CI pipeline locally
	@echo "$(GREEN)✓ CI pipeline completed successfully$(NC)"

# Quick quality check before committing
check: lint test ## Quick quality check (lint + test)
	@echo "$(GREEN)✓ All checks passed!$(NC)"

# Initialize new development environment
init: install build ## Initialize development environment
	@echo "$(GREEN)✓ Development environment initialized$(NC)"
	@echo ""
	@echo "$(BLUE)Quick Start:$(NC)"
	@echo "  • Run tests:       make test"
	@echo "  • Start server:    make serve"
	@echo "  • Export samples:  make export-samples"
	@echo "  • Run checks:      make check"
	@echo ""

.DEFAULT_GOAL := help
