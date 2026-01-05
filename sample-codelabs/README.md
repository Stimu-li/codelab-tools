# Sample Codelabs

Example codelabs demonstrating all features of CodeLab Tools.

## Available Samples

### 1. create-a-codelab.md

A meta-tutorial that teaches you how to create your own codelabs!

**Topics Covered:**
- Setting up CLaaT
- Writing markdown with proper metadata
- Using special formatting (infoboxes, code blocks)
- Exporting and publishing
- Best practices

**Duration:** ~15 minutes

**Use this as:** A template for your first codelab

### 2. test-all-features.md

Comprehensive demonstration of all codelab features.

**Topics Covered:**
- All markdown formatting options
- Code blocks with syntax highlighting
- Images and media
- Tables with alignment
- Lists (ordered, unordered, nested)
- Infoboxes (positive, negative, warning)
- Buttons and downloads
- Surveys and quizzes
- YouTube embeds
- Custom metadata

**Duration:** ~20 minutes

**Use this as:** A reference for what's possible

## Using These Samples

### Quick Preview

```bash
# Export a sample
claat export create-a-codelab.md

# Start server
claat serve

# Visit http://localhost:9090
```

### Export All Samples

```bash
# Export all samples at once
for file in *.md; do
  claat export "$file"
done

# Or use the Makefile
cd ..
make export-samples
```

### Create Your Own

Copy one of these samples as a starting point:

```bash
# Copy and edit
cp create-a-codelab.md my-tutorial.md
vim my-tutorial.md

# Export
claat export my-tutorial.md
```

## Metadata Explained

Each sample includes metadata at the top:

```markdown
id: unique-codelab-id
summary: Brief description for catalog
status: Published
authors: Your Name
categories: web, tutorial
tags: beginner, markdown
feedback link: https://github.com/yourname/repo/issues
analytics account: G-XXXXXXXXXX
```

### Required Fields

- **id** - Unique identifier (used for directory name)
- **summary** - Brief description (shown in catalog)
- **status** - Published, Draft, Deprecated, Hidden
- **authors** - Comma-separated list

### Optional Fields

- **categories** - For catalog filtering
- **tags** - Additional filtering/searching
- **feedback link** - Where users report issues
- **analytics account** - Google Analytics 4 ID
- **home url** - Custom back button destination

## Formatting Guide

### Headers

```markdown
# Title (H1) - Only one, at the top

## Step Title (H2) - Each major section

### Subsection (H3) - Within steps

#### Minor Heading (H4) - If needed
```

### Duration

Add duration to each step:

```markdown
## Step Title
Duration: 5

This step takes about 5 minutes...
```

### Code Blocks

````markdown
```javascript
console.log('Hello, world!');
```

```python
print("Hello, world!")
```

```bash
claat export my-tutorial.md
```
````

### Infoboxes

```markdown
Positive
: This is a positive message (green)

Negative
: This is a negative message (red)
```

### Buttons

```markdown
[Download Sample Code](https://example.com/code.zip)

Download 
: [Sample Code](https://example.com/code.zip)
: [Dataset](https://example.com/data.zip)
```

### Images

```markdown
![Alt text](img/screenshot.png)
```

Store images in the `img/` directory.

### Tables

```markdown
| Column 1 | Column 2 | Column 3 |
|----------|----------|----------|
| Data 1   | Data 2   | Data 3   |
| Data 4   | Data 5   | Data 6   |
```

### Lists

```markdown
- Unordered item 1
- Unordered item 2
  - Nested item
  - Another nested item

1. Ordered item 1
2. Ordered item 2
3. Ordered item 3
```

### Surveys

```markdown
### Question Title

- Option A
- Option B
- Option C
- Option D
```

### YouTube Videos

```markdown
[Video Title](https://www.youtube.com/watch?v=VIDEO_ID)
```

### Links

```markdown
[Link Text](https://example.com)

Or just: https://example.com
```

## Tips for Writing Great Codelabs

### Structure

1. **Overview** - What they'll learn, prerequisites, duration
2. **Setup** - Environment setup, downloads
3. **Core Content** - Main tutorial steps (3-7 steps ideal)
4. **Conclusion** - Summary, next steps, resources

### Writing Style

- **Clear and Concise** - Short sentences, active voice
- **Action-Oriented** - Tell users what to do
- **One Concept Per Step** - Don't overload
- **Show, Don't Tell** - Use examples and screenshots
- **Verify** - Add checkpoints to confirm understanding

### Code Examples

- **Complete** - Include all necessary code
- **Working** - Test before publishing
- **Commented** - Explain complex parts
- **Copyable** - Easy to copy/paste
- **Highlighted** - Use syntax highlighting

### Images

- **Relevant** - Only include helpful screenshots
- **Annotated** - Add arrows/highlights if needed
- **Compressed** - Optimize file sizes
- **Alt Text** - Descriptive for accessibility

### Duration Estimates

- **Realistic** - Test with actual users
- **Per-Step** - Add duration to each step
- **Include Context** - Factor in reading time
- **Be Generous** - Better to overestimate

## Testing Your Codelab

### Checklist

- [ ] All metadata fields filled in
- [ ] Each step has duration
- [ ] Code examples tested
- [ ] Links work
- [ ] Images display correctly
- [ ] No spelling/grammar errors
- [ ] Tested on mobile
- [ ] Follows accessibility guidelines
- [ ] Has clear learning objectives
- [ ] Includes next steps

### Export and Preview

```bash
# Export
claat export my-tutorial.md

# Preview
claat serve

# Test in browsers
# - Chrome
# - Firefox
# - Safari
# - Edge
```

### Get Feedback

- Have someone else follow your tutorial
- Ask for specific feedback:
  - Is it clear?
  - Is it complete?
  - Is the pace right?
  - Are there errors?

## Advanced Features

### Custom CSS

Add custom styles in a code block:

````markdown
```css
.special-box {
  background: #f0f0f0;
  padding: 20px;
  border-radius: 5px;
}
```
````

### Fragments/Includes

Split large codelabs into reusable fragments:

```markdown
<<import fragments/setup-instructions.md>>
```

### Custom Metadata

Pass custom data to templates:

```bash
claat export -extra '{"author_email":"you@example.com"}' tutorial.md
```

## Common Mistakes

### ❌ Don't

- Use multiple H1 headers
- Skip step durations
- Use absolute file paths
- Make steps too long
- Include broken links
- Skip the overview
- Use huge images
- Copy/paste without testing

### ✅ Do

- One H1 for title only
- Add duration to every step
- Use relative paths for images
- Keep steps focused (5-10 min)
- Test all links
- Include clear overview
- Optimize images
- Test all code examples

## Getting Help

- **Examples**: Look at the provided samples
- **Documentation**: Read [Markdown Format Guide](../claat/parser/md/README.md)
- **Issues**: [Report problems](https://github.com/Stimu-li/codelab-tools/issues)
- **Discussions**: [Ask questions](https://github.com/Stimu-li/codelab-tools/discussions)

## Contributing Samples

Have a great sample codelab? We'd love to include it!

1. Ensure it follows best practices
2. Test thoroughly
3. Submit a pull request
4. Include:
   - Tutorial markdown
   - Any necessary images
   - Brief description

See [CONTRIBUTING.md](../CONTRIBUTING.md) for details.

## License

Sample codelabs are provided under the same Apache 2.0 license as the project. Feel free to use them as templates!

---

Happy codelab creation! 🎉
