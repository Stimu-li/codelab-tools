# Troubleshooting Guide

Common issues and their solutions when working with CodeLab Tools.

## Table of Contents

- [Installation Issues](#installation-issues)
- [Build Issues](#build-issues)
- [Runtime Issues](#runtime-issues)
- [Export Issues](#export-issues)
- [Server Issues](#server-issues)
- [Browser Issues](#browser-issues)
- [Platform-Specific Issues](#platform-specific-issues)

## Installation Issues

### Go Version Issues

**Problem**: `go: directive expects go version >= 1.21`

**Solution**:
```bash
# Update Go to 1.21 or higher
# Download from: https://golang.org/dl/

# Verify version
go version
```

### Node.js Version Issues

**Problem**: `npm` requires Node.js 20 or higher

**Solution**:
```bash
# Install Node.js 20+
# Download from: https://nodejs.org/

# Or use nvm
nvm install 20
nvm use 20
```

### Permission Denied

**Problem**: Cannot execute binary

**Solution**:
```bash
# Add execute permission (Linux/macOS)
chmod +x claat/bin/claat

# Windows: Run as Administrator if needed
```

## Build Issues

### CLaaT Build Failures

**Problem**: `make: command not found`

**Solutions**:
```bash
# Windows: Install via Chocolatey
choco install make

# macOS: Install Xcode Command Line Tools
xcode-select --install

# Linux: Install build-essential
sudo apt-get install build-essential
```

**Problem**: Go module errors

**Solutions**:
```bash
# Clean module cache
cd claat
go clean -modcache
go mod download

# Or update dependencies
go get -u ./...
go mod tidy
```

**Problem**: `cannot find package`

**Solution**:
```bash
cd claat
go mod download
go mod verify
```

### Bazel Build Failures

**Problem**: Bazel version mismatch

**Solutions**:
```bash
# Clean Bazel cache
npm run clean
rm -rf ~/.cache/bazel

# Reinstall
npm install
npm run build
```

**Problem**: `bazel: command not found`

**Solution**:
```bash
# Bazel is installed via npm
npm install

# Use via npm scripts
npm run build
# Don't call bazel directly
```

### npm Build Failures

**Problem**: Package installation fails

**Solutions**:
```bash
# Clear npm cache
npm cache clean --force

# Remove and reinstall
rm -rf node_modules package-lock.json
npm install
```

**Problem**: Checksum mismatch

**Solution**:
```bash
# Delete package-lock.json and reinstall
rm package-lock.json
npm install
```

## Runtime Issues

### CLaaT Command Not Found

**Problem**: `claat: command not found`

**Solutions**:
```bash
# Option 1: Add to PATH
export PATH=$PATH:/path/to/codelab-tools/claat/bin

# Option 2: Use full path
/path/to/claat/bin/claat export tutorial.md

# Option 3: Install globally (if built with go install)
go install github.com/Stimu-li/codelab-tools/claat@latest
```

### Version Issues

**Problem**: Wrong CLaaT version

**Solution**:
```bash
# Check version
claat version

# Rebuild to update
cd claat
make clean
make
```

## Export Issues

### Markdown Export Fails

**Problem**: `invalid metadata`

**Solutions**:
- Check metadata format in markdown file
- Ensure required fields are present:
  ```markdown
  id: my-codelab
  summary: Summary here
  status: Published
  authors: Your Name
  categories: Tutorial
  tags: web
  ```

**Problem**: Images not exported

**Solutions**:
```bash
# Use relative paths for images
![alt text](images/screenshot.png)

# Not absolute paths
# ![alt text](/home/user/images/screenshot.png)
```

**Problem**: Special characters breaking export

**Solution**:
- Escape special characters in markdown
- Use backticks for code with special chars
- Check for invalid YAML in metadata

### Google Docs Export Fails

**Problem**: Authentication errors

**Solution**:
```bash
# Provide OAuth token
claat export -auth YOUR_TOKEN doc_id

# Or set up OAuth credentials
# See: https://developers.google.com/identity/protocols/oauth2
```

**Problem**: Document not found

**Solutions**:
- Check document is shared/public
- Use document ID, not full URL
- Verify document ID is correct

### Output Format Issues

**Problem**: Custom template not working

**Solution**:
```bash
# Use absolute path to template
claat export -f /full/path/to/template.html tutorial.md

# Or relative from current directory
claat export -f ./templates/custom.html tutorial.md
```

## Server Issues

### Port Already in Use

**Problem**: `address already in use: localhost:9090`

**Solutions**:
```bash
# Use different port
claat serve -addr localhost:8080

# Or kill process using port 9090
# Linux/macOS
lsof -ti:9090 | xargs kill -9

# Windows
netstat -ano | findstr :9090
taskkill /PID <PID> /F
```

### Files Not Loading

**Problem**: 404 errors when serving

**Solutions**:
- Check you're in the correct directory
- Verify codelabs are exported in current directory
- Check file permissions

**Problem**: CSS/JS not loading

**Solutions**:
```bash
# Check network in browser dev tools
# Verify CDN links are accessible
# Try with -prefix flag for local files
claat export -prefix ./codelab-elements/build tutorial.md
```

## Browser Issues

### Codelab Not Rendering

**Problem**: Blank page or errors

**Solutions**:
1. Check browser console for errors (F12)
2. Verify JavaScript is enabled
3. Clear browser cache
4. Try different browser
5. Check if web components are supported

**Problem**: "Loading..." stuck

**Solutions**:
- Check network tab for failed requests
- Verify codelab-elements CDN is accessible
- Check browser console for errors

### Navigation Not Working

**Problem**: Can't move between steps

**Solutions**:
- Check browser console for JavaScript errors
- Verify URL hash is updating
- Clear LocalStorage (browser dev tools)
- Try in incognito/private mode

### Styling Issues

**Problem**: Broken layout or missing styles

**Solutions**:
```bash
# Re-export with current prefix
claat export tutorial.md

# Or specify CDN
claat export -prefix https://cdn.jsdelivr.net/gh/Stimu-li/codelab-tools@main/codelab-elements/build/ tutorial.md
```

## Platform-Specific Issues

### Windows Issues

**Problem**: Line ending issues (CRLF vs LF)

**Solution**:
```bash
# Configure Git
git config --global core.autocrlf input

# Or convert files
dos2unix filename
```

**Problem**: Path separator issues

**Solution**:
- Use forward slashes in paths when possible
- Or use filepath.Join in Go code
- PowerShell handles both / and \

**Problem**: Execution policy

**Solution**:
```powershell
# Allow script execution
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### macOS Issues

**Problem**: "Cannot be opened because the developer cannot be verified"

**Solution**:
1. Go to System Preferences > Security & Privacy
2. Click "Open Anyway" for the blocked application
3. Or use: `xattr -d com.apple.quarantine claat`

**Problem**: Xcode Command Line Tools needed

**Solution**:
```bash
xcode-select --install
```

### Linux Issues

**Problem**: Missing shared libraries

**Solution**:
```bash
# Install build essentials
sudo apt-get update
sudo apt-get install build-essential

# For specific libraries
ldd claat/bin/claat  # Check dependencies
```

**Problem**: Permission denied for port binding

**Solution**:
```bash
# Recommended: Use port > 1024 (no special permissions needed)
claat serve -addr localhost:8080

# NOT RECOMMENDED: Grant capability (security risk)
# This grants elevated network privileges that could be exploited
# Only use if absolutely necessary and you understand the risks
# sudo setcap 'cap_net_bind_service=+ep' claat/bin/claat
```

## Development Issues

### Tests Failing

**Problem**: Go tests fail

**Solutions**:
```bash
# Update dependencies
cd claat
go mod download
go mod tidy

# Run with verbose output
go test -v ./...

# Run specific test
go test -v -run TestName ./package
```

**Problem**: JavaScript tests fail

**Solution**:
```bash
# Reinstall dependencies
rm -rf node_modules
npm install

# Run tests
npm test
```

### Linting Failures

**Problem**: golangci-lint errors

**Solutions**:
```bash
# Install/update golangci-lint
# https://golangci-lint.run/usage/install/

# Run with auto-fix
golangci-lint run --fix

# Or ignore specific rules (not recommended)
# Edit .golangci.yml
```

**Problem**: Markdown lint errors

**Solution**:
```bash
# Fix automatically
npx markdownlint-cli2-fix "**/*.md"

# Or adjust rules in .markdownlint.json
```

## Performance Issues

### Slow Export

**Problem**: Export takes too long

**Solutions**:
- Check internet connection (for image downloads)
- Use local images when possible
- Reduce image sizes
- Export multiple codelabs in parallel

### High Memory Usage

**Problem**: Process using too much memory

**Solutions**:
- Process codelabs in smaller batches
- Optimize images before export
- Use streaming for large files

## Getting More Help

If your issue isn't covered here:

1. **Search Issues**: [GitHub Issues](https://github.com/Stimu-li/codelab-tools/issues)
2. **Ask in Discussions**: [GitHub Discussions](https://github.com/Stimu-li/codelab-tools/discussions)
3. **Check Documentation**:
   - [BUILD_GUIDE.md](BUILD_GUIDE.md)
   - [CONTRIBUTING.md](CONTRIBUTING.md)
   - [README.md](README.md)
4. **Enable Debug Mode**:
   ```bash
   # For Go code
   go run -race ./main.go
   
   # Add debug prints
   fmt.Printf("DEBUG: %+v\n", variable)
   ```

5. **Report a Bug**: Use the [bug report template](.github/ISSUE_TEMPLATE/bug_report.yml)

## Prevention Tips

### Best Practices

1. **Keep tools updated**
   ```bash
   go get -u ./...
   npm update
   ```

2. **Use version control**
   - Commit working configurations
   - Tag stable versions

3. **Test locally first**
   ```bash
   make test
   claat export sample.md
   ```

4. **Validate inputs**
   - Check markdown syntax
   - Verify metadata fields
   - Test image paths

5. **Monitor logs**
   - Check console output
   - Review browser console
   - Enable verbose mode when debugging

### Useful Commands

```bash
# Check environment
go version
node --version
npm --version

# Verify build
cd claat && make test

# Clean rebuild
make clean && make

# Check dependencies
go list -m all
npm list

# Verify binary
./claat version
file ./claat

# Test export
claat export -o /tmp/test sample.md
```
