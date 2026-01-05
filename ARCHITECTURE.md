# Architecture Overview

This document provides a high-level overview of the CodeLab Tools architecture, explaining how the different components work together.

## System Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                        CodeLab Tools                             │
├─────────────────────────────────────────────────────────────────┤
│                                                                   │
│  ┌────────────────┐      ┌──────────────┐     ┌──────────────┐ │
│  │   CLaaT CLI    │─────▶│   Parser     │────▶│   Renderer   │ │
│  │  (Go Binary)   │      │  (Markdown/  │     │  (HTML/MD)   │ │
│  │                │      │  Google Docs)│     │              │ │
│  └────────────────┘      └──────────────┘     └──────────────┘ │
│         │                                              │         │
│         │                                              │         │
│         ▼                                              ▼         │
│  ┌────────────────┐                          ┌──────────────┐  │
│  │   HTTP Server  │                          │   Output     │  │
│  │  (Serve Mode)  │                          │   Files      │  │
│  └────────────────┘                          └──────────────┘  │
│                                                       │         │
└───────────────────────────────────────────────────────┼─────────┘
                                                        │
                                                        ▼
                            ┌───────────────────────────────────────┐
                            │      Browser / Web Client             │
                            ├───────────────────────────────────────┤
                            │  ┌─────────────────────────────────┐ │
                            │  │   Codelab Elements              │ │
                            │  │   (Web Components)              │ │
                            │  │                                 │ │
                            │  │  • google-codelab              │ │
                            │  │  • google-codelab-step         │ │
                            │  │  • google-codelab-analytics    │ │
                            │  └─────────────────────────────────┘ │
                            └───────────────────────────────────────┘
```

## Components

### 1. CLaaT CLI Tool (Go)

**Location**: `claat/`

The command-line tool that drives the entire codelab generation process.

#### Key Responsibilities:

- Parse command-line arguments
- Coordinate the export/update/serve workflow
- Manage file I/O operations
- Provide HTTP server for local preview

#### Architecture:

```
claat/
├── cmd/           # Command implementations (export, serve, update, version)
├── parser/        # Document parsers
│   ├── md/        # Markdown parser
│   └── gdoc/      # Google Docs parser
├── render/        # Output renderers
│   ├── html.go    # HTML renderer
│   └── md.go      # Markdown renderer
├── nodes/         # AST node types
├── types/         # Type definitions
├── fetch/         # Resource fetching (images, docs)
└── util/          # Utilities
```

#### Data Flow:

1. **Input** → Parser reads source (Markdown/Google Docs)
2. **AST** → Parser creates Abstract Syntax Tree of nodes
3. **Transform** → Nodes are processed and validated
4. **Render** → Renderer converts AST to output format
5. **Output** → Files written to disk

### 2. Parser System

**Location**: `claat/parser/`

Converts input documents into a common Abstract Syntax Tree (AST) representation.

#### Supported Input Formats:

##### Markdown Parser (`parser/md/`)

- Uses `goldmark` library
- Parses custom metadata (duration, tags, categories)
- Handles special directives (infoboxes, buttons, surveys)
- Processes code blocks with language highlighting

##### Google Docs Parser (`parser/gdoc/`)

- Fetches documents via Google Drive API
- Parses HTML exported from Google Docs
- Converts Google Docs formatting to AST nodes
- Handles images and embedded content

#### AST Node Types (`nodes/`)

All content is represented as typed nodes:

- `HeaderNode` - Step titles and headings
- `TextNode` - Plain text and inline formatting
- `CodeNode` - Code blocks with syntax highlighting
- `ImageNode` - Images with captions
- `InfoboxNode` - Special callout boxes (positive, negative, warning)
- `ButtonNode` - Download/action buttons
- `SurveyNode` - Interactive surveys/quizzes
- `ListNode` - Ordered/unordered lists
- `TableNode` - Tables with alignment
- `YouTubeNode` - Embedded YouTube videos
- `IFrameNode` - Embedded iframes

### 3. Renderer System

**Location**: `claat/render/`

Converts the AST into the desired output format.

#### HTML Renderer

**Output**: Complete HTML codelabs with web components

- Uses Go templates (`template.html`)
- Embeds metadata in `codelab.json`
- Links to codelab-elements from CDN or custom prefix
- Supports offline mode (`template-offline.html`)

**Features**:
- Syntax highlighting (Highlight.js)
- Copy buttons on code blocks
- Responsive design
- Dark mode support
- Progress tracking
- Analytics integration

#### Markdown Renderer

**Output**: Markdown files

- Converts AST back to Markdown
- Preserves metadata
- Used for updates and format conversion

### 4. Codelab Elements (Web Components)

**Location**: `codelab-elements/`

Client-side JavaScript components that render interactive codelabs in the browser.

#### Components:

##### `google-codelab`
Main container that orchestrates the codelab experience.

**Responsibilities**:
- Step navigation (next/previous)
- Progress tracking
- Sidebar/drawer management
- URL routing (hash-based)
- Keyboard shortcuts
- Responsive layout

##### `google-codelab-step`
Individual step/page within a codelab.

**Responsibilities**:
- Display step content
- Show duration estimates
- Handle interactive elements
- Manage step-specific state

##### `google-codelab-about`
Displays codelab metadata.

**Responsibilities**:
- Show title, authors, last updated
- Display summary information

##### `google-codelab-survey`
Interactive survey/quiz component.

**Responsibilities**:
- Render multiple choice questions
- Store responses in LocalStorage
- Send analytics events

##### `google-codelab-analytics`
Google Analytics integration.

**Responsibilities**:
- Track page views
- Record user interactions
- Monitor survey responses
- Measure completion rates

#### Technology Stack:

- **Web Components**: Custom elements (native browser API)
- **Closure Compiler**: JavaScript optimization
- **Closure Templates**: Template system
- **SCSS**: CSS preprocessing
- **Bazel**: Build system

### 5. Catalog System

**Location**: `catalog/`

Static website generator for browsing multiple codelabs.

#### Components:

- `index.html` - Main catalog page
- `style.css` - Styling with light/dark theme
- `app.js` - Search, filter, sort functionality
- `build-index.js` - Generates catalog index from codelabs

#### Features:

- Real-time search
- Category filtering
- Sorting by title/date/duration
- Dark mode with persistence
- Responsive card layout
- Static (no server required)

### 6. Build System

#### CLaaT Build (Make + Go)

```makefile
# Builds single platform binary
make

# Builds all platform binaries
make release

# Runs tests
make test
```

**Process**:
1. Go compiler builds from source
2. Links version information
3. Creates binary for target platform
4. Optionally cross-compiles for multiple platforms

#### Codelab Elements Build (Bazel + npm)

```bash
npm run build
```

**Process**:
1. SCSS → CSS compilation
2. Closure Templates → JavaScript
3. JavaScript bundling with Closure Compiler
4. Minification and optimization
5. Output to `codelab-elements/build/`

## Data Flow Example

### Creating a Codelab from Markdown

1. **User writes** `my-codelab.md` with metadata and content

2. **CLaaT parses** the markdown:
   ```
   Markdown → Goldmark Parser → AST Nodes
   ```

3. **CLaaT renders** to HTML:
   ```
   AST Nodes → HTML Renderer → HTML + codelab.json
   ```

4. **Browser loads** the HTML:
   ```
   HTML → Web Components → Interactive Codelab
   ```

5. **User interacts**:
   ```
   Navigation → Update URL hash → Load new step
   Analytics → Track events → Send to GA4
   ```

## Key Design Decisions

### 1. Two-Stage Processing (AST)

**Why**: Separation of parsing and rendering allows:
- Multiple input formats (Markdown, Google Docs)
- Multiple output formats (HTML, Markdown, future formats)
- Easier testing and validation
- Flexibility to transform content

### 2. Web Components

**Why**: Standards-based approach provides:
- Browser-native functionality
- No framework dependencies
- Encapsulation
- Reusability
- Future-proof

### 3. Static Output

**Why**: Generated static HTML/CSS/JS:
- No server required
- Fast loading
- Easy hosting (CDN, GitHub Pages, etc.)
- Offline capable
- High scalability

### 4. Metadata in JSON

**Why**: Storing metadata in `codelab.json`:
- Enables updates without re-parsing source
- Supports catalog generation
- Allows external tools to process codelabs
- Version tracking

## Extension Points

### Adding New Input Formats

1. Create parser in `claat/parser/new-format/`
2. Implement `Parser` interface
3. Register parser in `claat/cmd/export.go`

### Adding New Output Formats

1. Create renderer in `claat/render/new-format.go`
2. Implement rendering logic for all node types
3. Add format flag to CLI

### Adding New Node Types

1. Define node struct in `claat/nodes/`
2. Implement `Node` interface
3. Update parsers to recognize new syntax
4. Update renderers to output new format
5. Update web components if needed

### Adding New Web Components

1. Create component in `codelab-elements/new-component/`
2. Follow web component patterns
3. Add Bazel build rules
4. Update main bundle
5. Document usage

## Testing Strategy

### Unit Tests
- Go code: `*_test.go` files
- JavaScript: `*_test.js` files

### Integration Tests
- Full export workflow tests
- Multi-format conversion tests

### Manual Testing
- Sample codelabs for all features
- Visual regression testing
- Cross-browser testing

## Performance Considerations

### CLaaT Performance
- Parallel processing for multiple exports
- Efficient file I/O
- Minimal memory footprint

### Web Component Performance
- Lazy loading of steps
- Minimal DOM manipulation
- Efficient event handling
- Code splitting

### Build Performance
- Incremental compilation (Bazel)
- Caching (Go modules, npm)
- Parallel builds

## Security Considerations

### Input Validation
- Markdown sanitization
- HTML escaping
- URL validation
- File path validation

### Output Security
- CSP headers recommended
- XSS prevention in generated HTML
- Safe iframe sandboxing
- No inline JavaScript in templates

### Dependency Security
- Regular updates (Dependabot)
- Vulnerability scanning (Trivy)
- Go module checksums
- npm audit

## Future Architecture Plans

### Potential Enhancements
- [ ] Plugin system for custom parsers/renderers
- [ ] Real-time collaborative editing
- [ ] Cloud-based export service
- [ ] Mobile app for viewing codelabs
- [ ] AI-powered content suggestions
- [ ] Multi-language support built-in
- [ ] Advanced analytics dashboard
- [ ] Version control integration

## References

- [Web Components Spec](https://html.spec.whatwg.org/multipage/custom-elements.html)
- [Goldmark Parser](https://github.com/yuin/goldmark)
- [Closure Compiler](https://developers.google.com/closure/compiler)
- [Bazel Build System](https://bazel.build/)
- [Original Google Codelabs](https://github.com/googlecodelabs/tools)
