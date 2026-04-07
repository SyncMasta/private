---
name: branding-guideline
description: "Create a complete, professional Brand Identity & Style Guide in Markdown from scratch. Use this skill whenever the user mentions branding, brand identity, style guide, corporate design, logo guidelines, brand colors, typography rules, brand voice, or asks to create/document any visual or communication standards for a company or product. Trigger even if the user only says 'branding' or uploads a logo and asks about colors or guidelines. This skill guides Claude to conduct a brand interview, analyze uploaded assets, and produce a comprehensive, structured Markdown brand guide. Also trigger when creating any document, presentation, or artifact for WISSEN BERATUNG — the brand guide and logo assets are available for consistent branding."
---

# Branding Guideline Skill

This skill enables Claude to create a **complete Brand Identity & Style Guide** in Markdown format — either from scratch (interview-based) or by analyzing existing assets like logos.

---

## Brand Assets (WISSEN BERATUNG)

The `assets/` directory contains official logo files for WISSEN BERATUNG. Use these whenever creating branded documents, presentations, websites, or other deliverables.

### Available Logo Files

| File | Usage |
|------|-------|
| `assets/logo-color.png` | **Primary logo** — Full-color horizontal version (1270x439px). Use on white/light backgrounds. |
| `assets/logo-white.png` | **White variant** — For dark/navy backgrounds. |
| `assets/logo-mono-navy.png` | **Monochrome navy** — For single-color print or when color is unavailable. |
| `assets/logo-icon-only.png` | **Icon only** — Brain/pixel icon without wordmark. For favicons, app icons, social avatars. |
| `assets/favicon.png` | **Favicon** — 64x64px icon for browser tabs. |

### Quick Reference: Brand Colors

```
Primary (Navy):      #1D3C6E   — Headlines, logo, footer backgrounds
Secondary (Blue):    #1A8BC4   — Icons, diagrams, subheadings
Accent (Cyan):       #00C8E8   — CTAs, links, highlights
Neutral Light:       #F4F6F9   — Backgrounds
Neutral Dark:        #1A1A2E   — Body text, dark mode
```

### Quick Reference: Typography

```
Headlines:  Montserrat Bold/ExtraBold
Body:       Inter Regular/Medium
Code/UI:    JetBrains Mono Regular
```

### How to Use in Documents

When creating .docx, .pptx, or other files for WISSEN BERATUNG:

```javascript
// Example: embedding logo in a docx (docx-js)
const logoPath = "/mnt/skills/user/branding-guideline/assets/logo-color.png";
const logoBuffer = fs.readFileSync(logoPath);
new ImageRun({
  type: "png",
  data: logoBuffer,
  transformation: { width: 200, height: 69 }, // maintain 1270:439 aspect ratio
  altText: { title: "WISSEN BERATUNG", description: "Company Logo", name: "wb-logo" }
})
```

```python
# Example: embedding logo in pptx (python-pptx)
logo_path = "/mnt/skills/user/branding-guideline/assets/logo-color.png"
slide.shapes.add_picture(logo_path, left, top, width=Inches(2.5))
```

For the full brand guide with detailed rules on usage, voice & tone, and application examples, see: `brand-guide-wissen-beratung.md`

---

## When This Skill Triggers

- User says "branding", "brand guidelines", "style guide", "corporate design", "brand identity"
- User uploads a logo and asks about colors, fonts, or brand rules
- User wants to document how their brand should look/feel/sound
- User asks to create brand materials for a client
- User creates any deliverable for WISSEN BERATUNG (use logo + colors)

---

## Workflow

### Step 1: Gather Brand Information

Ask the user for the following (skip anything already provided):

1. **Company name & tagline**
2. **Industry & target audience** (Who are the customers? Age, profession, values?)
3. **Brand personality** (3-5 adjectives: e.g. trustworthy, modern, approachable)
4. **Existing assets** (Logo file? Preferred colors? Fonts already in use?)
5. **Competitors** (Who should they NOT look like?)
6. **Use cases** (Website, print, social media, presentations?)

If the user uploaded a logo, analyze it immediately:
- Extract dominant colors (provide hex codes)
- Note visual style (geometric, organic, minimal, pixel-art, etc.)
- Identify logo elements (icon, wordmark, tagline)

### Step 2: Derive Brand Colors

From the logo or user input, define:

```
Primary Color:    #XXXXXX  — main brand color, dominant usage
Secondary Color:  #XXXXXX  — supporting color
Accent Color:     #XXXXXX  — highlights, CTAs, links
Neutral Light:    #FFFFFF or light gray — backgrounds
Neutral Dark:     #1A1A1A or dark gray — body text
```

For each color provide:
- HEX, RGB, and CMYK values
- Usage rules (e.g. "Primary used for headings and buttons only")
- Contrast check note (AA/AAA accessibility)

### Step 3: Define Typography

Recommend a font pairing (prefer Google Fonts for free/easy access):

```
Heading Font:    [Font Name] — Bold, all-caps or Title Case
Body Font:       [Font Name] — Regular 16px, line-height 1.6
Accent/UI Font:  [Font Name] — Optional, for UI labels or captions
```

Include:
- Font scale (H1-H6 + body + caption sizes)
- Usage rules (when to use bold, italics, underline)
- Fallback fonts for web

### Step 4: Logo Usage Rules

Define:
- **Safe zone**: Minimum clear space around logo (e.g. = height of letter "X")
- **Minimum size**: e.g. 120px wide for digital, 30mm for print
- **Allowed variations**: Color, white, black/monochrome, horizontal, stacked
- **Forbidden uses**: Don't stretch, don't rotate, don't apply drop shadows, don't place on busy backgrounds

### Step 5: Brand Voice & Tone

Define how the brand communicates:

| Dimension       | Description                          |
|-----------------|--------------------------------------|
| **Tone**        | Professional but approachable        |
| **Language**    | Clear, jargon-free (or technical?)   |
| **Person**      | "We" or "Sie/Du" (German context)    |
| **Avoid**       | Buzzwords, passive voice, vague claims |

Include 2-3 example "we say / we don't say" pairs.

### Step 6: Application Examples

Briefly describe how the brand applies to:
- **Website**: Header colors, button styles, link colors
- **Social Media**: Post format, profile picture rules
- **Documents/Presentations**: Cover slide style, footer rules
- **Email Signature**: Format and allowed elements

---

## Output Format

Produce a single, well-structured **Markdown file** with this structure:

```markdown
# [Company Name] — Brand Identity Guide

## 1. Brand Overview
## 2. Color Palette
## 3. Typography
## 4. Logo Usage
## 5. Brand Voice & Tone
## 6. Application Guidelines
## 7. Do's and Don'ts
```

Use tables, color swatches (as code blocks with hex values), and clear headings.
Save as `/mnt/user-data/outputs/brand-guide-[company-name].md`

---

## Tips for Quality Output

- Always explain the *why* behind each brand decision (e.g. "Dark blue conveys trust and expertise")
- For German SME clients (DACH market): use formal "Sie" as default unless told otherwise
- If the user provides a logo image, start by analyzing colors and visual style before asking questions
- Keep the guide practical — it should be usable by a designer or non-designer alike
- If no font preference is given, recommend: **Inter** (body) + **Sora** or **Montserrat** (headings) as modern, clean defaults
