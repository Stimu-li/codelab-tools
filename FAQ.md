# Frequently Asked Questions (FAQ)

Common questions about CodeLab Tools and their answers.

## General Questions

### What is CodeLab Tools?

CodeLab Tools is a complete system for creating, building, and publishing interactive tutorials (codelabs). It consists of:
- **CLaaT**: A CLI tool for converting Markdown or Google Docs to HTML codelabs
- **Codelab Elements**: Web components for rendering interactive codelabs
- **Catalog**: A static site generator for browsing multiple codelabs

### Is this the same as Google Codelabs?

This is a maintained fork of the original Google Codelabs tools. The original project (googlecodelabs/tools) is now archived. This fork includes bug fixes, new features, and active maintenance.

### What's the license?

Apache License 2.0 - the same as the original Google Codelabs project. You're free to use it for personal or commercial projects.

### Who maintains this project?

This fork is maintained by the community, with Stimu-li as the primary maintainer. Contributions are welcome!

## Getting Started

### How do I create my first codelab?

1. Install CLaaT (download from releases or build from source)
2. Create a Markdown file with metadata:
   ```markdown
   id: my-first-codelab
   summary: Learn to create codelabs
   status: Published
   authors: Your Name
   categories: Tutorial
   tags: beginner
   
   # My First Codelab
   
   ## Overview
   Duration: 1
   
   Content here...
   ```
3. Export to HTML: `claat export your-file.md`
4. Preview: `claat serve`

### Do I need programming knowledge?

No! You can create codelabs using just Markdown - a simple text formatting syntax. If you can write a README, you can create a codelab.

However, if you want to customize the build system or web components, you'll need Go and JavaScript knowledge.

### Can I use this for commercial projects?

Yes! The Apache 2.0 license allows commercial use. You can create codelabs for your company, product documentation, training materials, etc.

## Technical Questions

### What are the system requirements?

**For Using CLaaT (creating codelabs):**
- Any OS (Windows, macOS, Linux)
- No dependencies - just download the binary

**For Building from Source:**
- Go 1.21 or higher
- Node.js 20 or higher (for web components)
- Make (for build automation)

### Can I use custom domains?

Yes! Codelabs are static HTML/CSS/JS files. Host them anywhere:
- GitHub Pages
- Netlify
- Vercel
- AWS S3
- Your own web server

Just export and upload the files.

### Do codelabs require a server?

No! Codelabs are completely static. They work on:
- Web servers (HTTP/HTTPS)
- GitHub Pages
- File system (`file://` protocol)
- CDN

No backend, database, or server-side processing required.

### Can I customize the appearance?

Yes, several ways:

1. **Simple**: Use custom CSS in your markdown
2. **Moderate**: Modify the default templates
3. **Advanced**: Create custom Go templates for rendering
4. **Expert**: Fork and modify the web components

### How do I add images?

```markdown
# In your markdown file
![Alt text](images/screenshot.png)
```

Images are copied to the output directory automatically.

### Can I embed videos?

Yes! Use the YouTube directive:

```markdown
<!-- Embed YouTube video -->
[Video Title](https://www.youtube.com/watch?v=VIDEO_ID)
```

Or use iframes for other video services.

## Content Questions

### What's the recommended codelab structure?

```markdown
# Title

## Overview
- What you'll learn
- What you'll need
- Duration estimate

## Step 1: Setup
Instructions...

## Step 2: Core Content
Main tutorial content...

## Step 3: Next Steps
- Links to related codelabs
- Additional resources
- Call to action

## Conclusion
Summary and recap
```

### How long should a codelab be?

- **Beginner**: 15-30 minutes (5-8 steps)
- **Intermediate**: 30-60 minutes (8-12 steps)
- **Advanced**: 60-90 minutes (12-15 steps)

Keep individual steps focused (3-5 minutes each).

### Can I include interactive exercises?

Yes! Use:
- **Surveys**: Multiple choice questions
- **Code blocks**: For users to copy/paste
- **Downloads**: Provide sample files
- **External links**: Link to interactive tools

Note: Codelabs don't have built-in code execution. For true interactivity, link to external tools like JSFiddle, CodePen, or Jupyter notebooks.

### How do I handle prerequisites?

In the Overview section:

```markdown
## What you'll need
Duration: 1

- Basic knowledge of JavaScript
- Node.js installed (v20+)
- A code editor
- 30 minutes of free time
```

## Publishing Questions

### How do I publish codelabs?

1. **Export**: `claat export your-tutorial.md`
2. **Upload**: Copy the output directory to your web host
3. **Share**: Share the URL

For multiple codelabs, use the catalog system.

### Can I create a catalog of codelabs?

Yes! Use the included catalog system:

```bash
# 1. Export all codelabs to catalog directory
claat export -o ./catalog your-tutorial.md

# 2. Generate index
cd catalog
node build-index.js . codelabs.json

# 3. Host the catalog directory
```

### How do I update an existing codelab?

```bash
# Method 1: Re-export
claat export your-tutorial.md

# Method 2: Update in place
cd your-codelab-directory
claat update
```

The update command uses the stored `codelab.json` metadata to re-export from the original source.

### Can I version my codelabs?

Yes! Recommended approaches:

1. **Git tags**: Tag your markdown files
2. **Metadata**: Include version in metadata
3. **Separate IDs**: Create new codelab IDs for major versions

```markdown
id: my-codelab-v2
summary: My Codelab (Version 2.0)
```

## Google Docs Questions

### Can I still use Google Docs?

Yes! CLaaT supports Google Docs as input:

```bash
claat export 1ABC-XYZ123_docID
```

### How do I format Google Docs for codelabs?

1. Use Heading 1 for title
2. Use Heading 2 for steps
3. Use Heading 3 for subsections
4. Add metadata at the top as a table
5. Use special text formatting for directives

See the [Google Docs guide](https://github.com/googlecodelabs/tools/blob/master/FORMAT-GUIDE.md) (from original project).

### Do I need special permissions?

The document must be:
- Publicly accessible (anyone with link can view), OR
- You provide an OAuth token with `-auth` flag

## Troubleshooting

### My export fails with "invalid metadata"

Check that your markdown has required fields:

```markdown
id: unique-id-here
summary: Brief summary
status: Published
authors: Your Name
```

### Images don't show up

- Use relative paths: `images/pic.png`
- Don't use absolute paths: `/home/user/pics/pic.png`
- Ensure images exist before exporting

### The codelab looks broken in the browser

1. Check browser console (F12) for errors
2. Verify JavaScript is enabled
3. Check if CDN is accessible
4. Try re-exporting with current prefix

### How do I report bugs?

Use the [bug report template](.github/ISSUE_TEMPLATE/bug_report.yml) on GitHub.

## Advanced Questions

### Can I automate codelab generation?

Yes! CLaaT is designed for automation:

```bash
# Export multiple files
claat export *.md

# In CI/CD
claat export -o ./dist tutorial.md
```

Integrate with GitHub Actions, Jenkins, or other CI/CD systems.

### Can I contribute?

Yes! See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

Areas where we need help:
- Bug fixes
- New features
- Documentation
- Testing
- Examples and tutorials

### How do I create custom templates?

1. Create a Go template file (e.g., `custom.html`)
2. Use CLaaT's template syntax
3. Export with `-f` flag:

```bash
claat export -f custom.html tutorial.md
```

See `claat/render/template.html` for reference.

### Can I extend the web components?

Yes! The web components are built with standard Web Components APIs. You can:

1. Fork the repository
2. Modify components in `codelab-elements/`
3. Build: `npm run build`
4. Use custom build with `-prefix` flag

### How do I add analytics?

Use the `-ga4` flag:

```bash
claat export -ga4 G-XXXXXXXXXX tutorial.md
```

Or set it in metadata:

```markdown
ga4: G-XXXXXXXXXX
```

### Can I localize/translate codelabs?

Currently, you need to:
1. Create separate markdown files for each language
2. Use different IDs: `tutorial-en`, `tutorial-es`, etc.
3. Link between language versions

Full i18n support is on the roadmap.

## Integration Questions

### Can I integrate with my documentation site?

Yes! Codelabs are static HTML. You can:

1. Embed in iframes
2. Link from your docs
3. Style to match your site
4. Include in static site generators

### Does it work with Jekyll/Hugo/Gatsby?

Yes! Generate codelabs separately and link to them from your static site.

### Can I use with LMS platforms?

Yes! Export codelabs and:
- Link from LMS (Moodle, Canvas, etc.)
- Embed in iframes
- Include in SCORM packages (with extra work)

### Does it integrate with GitHub?

Yes! Several ways:
- Store markdown in GitHub repos
- Use GitHub Pages for hosting
- Automate with GitHub Actions
- Link to GitHub repos from codelabs

## Performance Questions

### How fast is export?

Very fast! A typical codelab exports in under 1 second. Bottlenecks:
- Large images (optimize before export)
- Network fetches (Google Docs, remote images)
- Many codelabs in batch

### Can I optimize for SEO?

Yes! Codelabs generate semantic HTML with:
- Proper heading structure
- Meta tags
- Descriptive titles
- Clean URLs

Add your own:
- Sitemap
- robots.txt
- Social media meta tags

### What about mobile devices?

The web components are responsive and work on:
- Phones
- Tablets
- Desktops
- Any screen size

## Comparison Questions

### vs. Markdown documentation?

**Codelabs provide:**
- Step-by-step structure
- Progress tracking
- Time estimates
- Interactive surveys
- Professional appearance

**Regular Markdown is better for:**
- Reference documentation
- Quick notes
- Simple guides

### vs. Video tutorials?

**Codelabs are better for:**
- Self-paced learning
- Easy to update
- Searchable content
- Copy-paste code
- Accessibility

**Videos are better for:**
- Visual demonstrations
- Personality/engagement
- Live coding

**Best approach**: Use both! Link to videos from codelabs.

### vs. Jupyter Notebooks?

**Different purposes:**
- Codelabs: Teaching/tutorials
- Jupyter: Data analysis/exploration

You can link to Jupyter notebooks from codelabs!

## Still Have Questions?

- **Search Issues**: [GitHub Issues](https://github.com/Stimu-li/codelab-tools/issues)
- **Ask Community**: [GitHub Discussions](https://github.com/Stimu-li/codelab-tools/discussions)
- **Read Docs**:
  - [README.md](README.md)
  - [BUILD_GUIDE.md](BUILD_GUIDE.md)
  - [TROUBLESHOOTING.md](TROUBLESHOOTING.md)
  - [ARCHITECTURE.md](ARCHITECTURE.md)
