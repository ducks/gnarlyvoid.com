# AI-AGENTS.md

Instructions for an AI agent adding a new "void" (an art post) to this
site. Gnarly Void is a personal art site built with [Zola]; each void is
one piece of fiber/tufted/mixed-media work with a preview image and a short
written reflection.

If you are a human, use `make void` instead — it prompts you interactively.
This file exists because that command needs a TTY and an agent usually
can't drive it; the steps below reproduce exactly what it does, plus the
image handling it leaves manual.

[Zola]: https://www.getzola.org/

## What a void is

- Content file: `content/voids/<N>.md` where `<N>` is the next integer.
- Images: `static/images/<N>/1.jpg` (and `2.jpg`, `3.jpg`, ... if multiple).
- The site is static; a void is live once merged and the Pages deploy runs.

## Steps

### 1. Find the next number

The next void number is one more than the highest existing one:

```bash
next=$(ls content/voids/[0-9]*.md | sed 's/.*\/\([0-9]*\)\.md/\1/' \
  | sort -n | tail -1); next=$((next + 1)); echo "$next"
```

### 2. Place the image(s)

Put the artwork under `static/images/<N>/`, named `1`, `2`, ... Keep the
source file's real extension — pieces here use `.jpg`, `.jpeg`, and `.png`
interchangeably; do NOT rename a `.jpg` to `.jpeg`.

```bash
mkdir -p static/images/<N>
cp /path/to/artwork.jpg static/images/<N>/1.jpg
```

If given several images, number them `1.jpg`, `2.jpg`, ... The first image
is the preview shown in listings.

### 3. Look at the image before writing

Actually look at the artwork. The written reflection must describe *this*
piece — its subject, technique, materials, and what makes it work. Do not
write generic filler. If you cannot see the image, stop and ask.

### 4. Write the content file

Create `content/voids/<N>.md`. The front matter is TOML between `+++`
fences. Fill in real values:

```toml
+++
title = "Short evocative title"
date = YYYY-MM-DD
description = "One sentence, concrete, describing the piece and its hook"

[taxonomies]
tags = ["tufting", "fiber", ...]  # lowercase; reuse existing tags where they fit

[extra]
preview_image = "images/<N>/1.jpg"
images = ["images/<N>/1.jpg"]      # list every image you placed, in order
+++

Body copy here.
```

Then the body: a short reflection, usually 3–5 short paragraphs. Read a few
recent voids (`content/voids/16.md`, `17.md`, `18.md`) first and match the
voice — spare, confident, attentive to form and material, a little wry.
Common shape: open with a one-line hook, describe what the piece is doing
visually, then the technique/materials, then a closing line on the tension
it holds (rigid vs. soft, engineered vs. handmade, and so on). No emoji, no
hype, no "in this piece."

Tags: reuse existing ones where they fit (`tufted`, `fiber`, and
subject/style tags). Check what other voids use rather than inventing new
tags for the same idea.

### 5. Verify it builds

```bash
zola check
```

Expect "N pages (0 orphan)" with no errors, where N went up by one.

### 6. Branch, commit, open a PR

Match the repo convention: a feature branch per void, named `post/void-<N>`.

```bash
git checkout -b post/void-<N>
git add content/voids/<N>.md static/images/<N>/
git commit -m "add void <N> - <title>"
```

Do not push or merge unless asked; leave the branch for a human to review
and merge. Merges to `main` are `--no-ff`, and the GitHub Pages workflow
deploys on merge.

## Don'ts

- Don't invent a description of art you haven't looked at.
- Don't rename image extensions to force uniformity.
- Don't edit existing voids while adding a new one.
- Don't push or deploy without being asked — a void goes live on merge.
