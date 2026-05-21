# SEO Action Plan — www.1minutesales.com

Generated 2026-05-21 alongside FULL-AUDIT-REPORT.md.

Each item has a **priority**, **effort estimate**, and the **file(s)** to touch. Ordered so the early items are highest impact per minute of work.

---

## 🔴 Critical (fix today)

### 1. Fix the sitewide dead-anchor links
**Effort: 15 min · Impact: trust signal + minor UX**

Every page's nav and footer links to `/#features`, `/#integrations`, `/#pricing` — none of which exist on `index.html`. Either:

- **(A) Cleanest:** add `id="features"`, `id="integrations"`, `id="pricing"` to existing homepage sections (e.g., the "what we do" block could carry `id="features"`).
- **(B) Quickest:** change all nav/footer template links to existing IDs: `/#what-we-do`, `/#who-we-serve`, `/#bookcall`.

Files: every page (the nav/footer block is repeated). At minimum: `index.html`, `blog/index.html`, `contact.html`, `careers.html`, `who-we-help.html`, `schedule-strategy-call.html`, all 13 `blog/posts/*.html`, all 3 `landing/*.html`.

### 2. Remove or source the fabricated-looking precision stat
**Effort: 10 min · Impact: highest E-E-A-T failure on the site**

`blog/posts/why-leads-arent-converting.html:161-179` claims "12% conversion without AI, 38-45% with AI" with no source. Under the Sept 2025 Quality Rater Guidelines this is a Trust deduction for commercial content.

Replace with either:
- A cited range from an identifiable study (with link), or
- A first-hand statement: "1 Minute Sales clients typically see [X]% improvement in consult bookings within 30 days" — first-hand evidence is stronger than an unsourced %.

### 3. Source the homepage and 391-post stats
**Effort: 15 min · Impact: E-E-A-T**

- `index.html:270` — "21x more likely to convert" → add the InsideSales / Lead Response Management Study citation.
- `blog/posts/391-higher-conversion-rates.html:130` — credits "Harvard Business Review" but no link or study name. Add the actual study title (James B. Oldroyd's "The Short Life of Online Sales Leads," HBR 2011) and a link.

---

## 🟠 High priority (this week)

### 4. Move Tailwind from CDN to a built CSS file
**Effort: 1 hour · Impact: ~80% of the available CWV improvement**

Currently `<script src="https://cdn.tailwindcss.com">` runs on every page (~350 KB synchronous). Replace with a CLI-built `dist/styles.css`. Steps:

```bash
cd ~/Documents/Sites/sixty_seconds_html
npm install -D tailwindcss
npx tailwindcss init
# Configure content paths in tailwind.config.js to include **/*.html
npx tailwindcss -i ./styles.css -o ./dist/styles.css --minify
```

Then in every HTML page, replace:
```html
<script src="https://cdn.tailwindcss.com"></script>
<script>tailwind.config = { ... }</script>
```
with:
```html
<link rel="stylesheet" href="/dist/styles.css">
```

Move the tailwind config from inline JS into `tailwind.config.js`. Add a GitHub Action step that rebuilds CSS on push.

### 5. Fix Organization schema + link Service
**Effort: 10 min · Impact: Knowledge Panel consolidation + GEO**

In `index.html:123-148`, add to the Organization block:
```json
"@id": "https://www.1minutesales.com/#org",
"email": "hello@1minutesales.com",
"foundingDate": "2024",
"sameAs": [
  "https://www.linkedin.com/company/1minutesales",
  "https://twitter.com/1minutesales",
  "https://www.facebook.com/1minutesales"
]
```
(Replace with your real social URLs.)

In the Service block at `index.html:54`, add:
```json
"provider": {
  "@type": "Organization",
  "@id": "https://www.1minutesales.com/#org"
}
```

### 6. Fill the 4 footer social `href="#"` placeholders
**Effort: 5 min · Impact: GEO entity confirmation**

Find the social icon `<a href="#">` tags in the footer (used on every page — likely lines 477-490 of `index.html`). Replace `#` with the actual LinkedIn / Twitter / Facebook / Instagram URLs. If a network doesn't exist yet, remove that icon entirely rather than leaving a dead link.

### 7. Add the missing schema on 6 pages
**Effort: 30 min · Impact: high — landing pages are primary SEO assets**

Ready-to-paste JSON-LD blocks per page (full snippets in the schema subagent report; summary here):

- `landing/builders-remodelers.html` — `Service` block, `serviceType: "Outsourced Sales for Home Builders and Remodelers"`, `audience` field
- `landing/cosmetic-med-spa.html` — `Service` block, `serviceType: "Outsourced Sales for Cosmetic Clinics and Medical Spas"`, `audience` field
- `landing/personal-injury.html` — `Service` block, `serviceType: "Legal Intake Services for Personal Injury Firms"`, `audience` field
- `contact.html` — `ContactPage` with embedded Organization `@id` reference
- `schedule-strategy-call.html` — `Service` with `offers.price: "0"` (free strategy call)
- `careers.html` — `JobPosting` for the sales rep role (Google jobs carousel eligibility)

All 6 share the same `breadcrumb` pattern with `BreadcrumbList`.

### 8. Add `url` and `keywords` to all 13 BlogPosting blocks
**Effort: 20 min · Impact: medium**

Each post's `<head>` already has `<meta name="keywords">`. Mirror that into the BlogPosting JSON-LD plus add an explicit `url` property:

```json
"url": "https://www.1minutesales.com/blog/posts/<post-slug>.html",
"keywords": "<copy from meta keywords>"
```

### 9. Replace `"@type": "Organization"` with `"@type": "Person"` author in blog posts
**Effort: 30 min · Impact: highest single E-E-A-T move available**

Pick a named author (founder, content lead). Create a minimal Person schema and reuse across all 13 posts:

```json
"author": {
  "@type": "Person",
  "name": "Jane Doe",
  "url": "https://www.linkedin.com/in/jane-doe",
  "jobTitle": "Founder",
  "worksFor": {
    "@type": "Organization",
    "@id": "https://www.1minutesales.com/#org"
  }
}
```

Add `<meta name="author">` to each post's `<head>` as well. Consider an "About the author" footer block (40-80 words + headshot) at the bottom of each post — visible E-E-A-T signal Google rewards.

### 10. Build the visible FAQ section on the homepage
**Effort: 30 min · Impact: rich-result eligibility + AI citability + UX**

The 5 FAQ items in `index.html:74-121` (schema) are excellent. Convert to a visible `<details>`/`<summary>` accordion or a Tailwind FAQ component, placed above the footer. Google requires user-visible FAQ content for any chance of rich results (FAQPage is commercial-restricted but visible FAQs still help AI search citation regardless).

### 11. Canonical fix on `who-we-help.html`
**Effort: 2 min**

Line 9 currently: `<link rel="canonical" href="https://www.1minutesales.com/who-we-help">`. Change to:
```html
<link rel="canonical" href="https://www.1minutesales.com/who-we-help.html">
```
Must match the actual served URL and the sitemap entry.

### 12. Consolidate duplicate-intent blog pair
**Effort: 5 min · Impact: removes a cannibalization signal**

`cost-of-slow-response.html` (738 words, generic) and `slow-lead-response-cost.html` (3,570 words, with FAQPage) target identical intent. Both indexed.

Add to `blog/posts/cost-of-slow-response.html` `<head>`:
```html
<link rel="canonical" href="https://www.1minutesales.com/blog/posts/slow-lead-response-cost.html">
```
Or, cleaner: delete the shorter post and add a redirect (GitHub Pages doesn't support redirects natively — use a `<meta http-equiv="refresh">` page in the shortest path).

Also unlink the shorter post from `blog/index.html:279`.

### 13. Add a homepage entity-definition paragraph
**Effort: 15 min · Impact: GEO — primary citation source for "What is 1 Minute Sales?"**

Insert near the top of `index.html` body (visible body copy, ~140-160 words). Template:

> 1 Minute Sales is a US-based outsourced sales service that handles inbound lead response, qualification, appointment booking, and deal closing for high-ticket businesses that cannot afford to lose leads to slow follow-up. The company specializes in industries where each inbound inquiry carries significant revenue — personal injury law firms, cosmetic surgery practices, med spas, dental implant groups, custom home builders, remodelers, and premium roofing companies. 1 Minute Sales responds to inbound leads within 60 seconds, 24 hours a day, across phone, SMS, and email, then qualifies the contact, books a consultation or appointment directly to the client's calendar, and where applicable closes the deal and sends contracts. The service operates on a monthly retainer plus commission model and integrates with existing CRM platforms (HubSpot, Pipedrive, Zoho) without requiring clients to change their current tools.

This is the standalone answer AI engines (Google AIO, ChatGPT, Perplexity, Bing Copilot) will extract for "What is 1 Minute Sales?"

---

## 🟡 Medium priority (this month)

### 14. Differentiate the 3 landing pages
**Effort: 2 hours · Impact: removes near-duplicate doorway-page risk**

`landing/builders-remodelers.html`, `landing/cosmetic-med-spa.html`, `landing/personal-injury.html` share ~70% identical copy. Add 200-300 words of vertical-specific content per page:

- **Personal injury** — statute-of-limitations urgency, retainer conversion, typical case-value ranges
- **Cosmetic / med spa** — procedure price points (e.g., $5k-$15k consult), patient comparison shopping behavior, before/after image expectations
- **Builders / remodelers** — seasonal demand cycles, project value thresholds, the typical 3-5-bid pattern

Also add FAQPage schema to each landing page (3-5 vertical-specific Q&A pairs).

### 15. Expand the 7 thin blog posts to 1500+ words OR consolidate them
**Effort: 4-8 hours · Impact: ranking + AI citation**

Posts under 1000 words: lead-response-benchmarks (658), sales-outsourcing-vs-hiring (696), cost-of-slow-response (738 — already canonical'd in step 12), why-leads-arent-converting (773), commission-only-sales (816), chatbots-vs-sdr-vs-ai (855), ai-in-sales-process (903).

Pick the 3-4 worth expanding; canonical the others to longer related posts.

### 16. Add real article images to BlogPosting schema
**Effort: 2 hours · Impact: rich-result eligibility**

Every BlogPosting currently has `"image"` pointing to the white logo PNG. Add a representative 1200px+ image per post (even a category-level vertical hero image), update the schema. Use the seo-image-gen skill if needed.

### 17. Enrich llms.txt
**Effort: 30 min · Impact: ChatGPT / Perplexity citation quality**

In `/llms.txt`, make four changes:
- Replace the opening blockquote with a crisp entity definition: "1 Minute Sales (1minutesales.com) is a US-based outsourced sales service…"
- Add a `## Key statistics` section with 4-5 sourced figures (the 391% HBR study, the 21x lead-response figure, etc.)
- Replace "platform" / "system" language with "service" / "team" to align with the website's positioning
- Add a footer `## Document metadata` section with `Last updated: 2026-05-21` and version stamp

Optional: create `llms-full.txt` with verbatim FAQ pairs + use case deep-dives (3 hours).

### 18. Add explicit AI-crawler rules to robots.txt
**Effort: 5 min · Impact: GEO signal**

Append to `/robots.txt`:
```
# AI Search Crawlers — explicitly permitted
User-agent: GPTBot
Allow: /

User-agent: OAI-SearchBot
Allow: /

User-agent: ClaudeBot
Allow: /

User-agent: PerplexityBot
Allow: /

User-agent: Google-Extended
Allow: /
```

### 19. Add favicon
**Effort: 10 min**

Add `<link rel="icon" href="/favicon.ico" type="image/x-icon">` (and SVG variant if available) to the shared `<head>`. Drop a `favicon.ico` and `favicon.svg` at the root.

### 20. Replace the white-on-transparent OG image
**Effort: 30 min · Impact: social-share appearance**

Create a 1200×630 PNG with the brand mark on the dark background color (#0B0F12) and the tagline. Update `og:image` and `twitter:image` on every page. Use `seo-image-gen` to generate.

### 21. Fix WebSite SearchAction or remove it
**Effort: 5 min**

`index.html:158-161` uses old EntryPoint object format. Either fix to:
```json
"potentialAction": {
  "@type": "SearchAction",
  "target": "https://www.1minutesales.com/blog/?q={search_term_string}",
  "query-input": "required name=search_term_string"
}
```
OR remove `potentialAction` since `/blog/?q=` has no working search endpoint. Removing is safer if you don't plan to add search.

### 22. Convert blog post H2s to question format on top posts
**Effort: 30 min · Impact: 15-25% AI-citation lift on those posts**

Pick the 3 highest-traffic blog posts and rephrase their H2 headings as questions. Example:
- "The 60-Second Window" → "Why Does Responding Within 60 Seconds Increase Conversions by 391%?"
- "The Psychology of Lead Engagement" → "What Happens in a Lead's Mind in the First 5 Minutes?"

Align with the existing FAQPage schema questions on the same page.

---

## 🟢 Low priority (backlog)

- `careers.html:54` canonical placement — clean up indentation drift
- Add `<meta name="author">` site-wide
- Add an "About the author" footer block to blog posts
- Add `wordCount` and `articleSection` to BlogPosting schema
- Add `inLanguage: "en-US"` to Blog schema at `blog/index.html`
- Remove obsolete `<meta name="keywords">` (harmless but signals dated SEO)
- IndexNow integration for Bing/Yandex (write key file + GitHub Action ping on push)
- Add `<link rel="alternate" type="application/rss+xml">` for the blog
- Internal-linking improvements: add a "Related posts" block at the bottom of each blog post (3 contextually-related links)

---

## Estimated total effort

- **Critical block (3 items)**: ~40 min
- **High-priority block (10 items)**: ~5 hours
- **Medium-priority block (9 items)**: ~10-14 hours
- **Low-priority backlog**: 4-6 hours

A focused 1-day push can knock out all Critical + High items and lift the score from 61 → ~78. Medium block to follow over 2-3 weeks lifts to ~85+.

---

## What's already excellent (don't touch)

- `llms.txt` (top decile vs peers)
- Sitemap structure (just refreshed)
- Robots.txt (allows /, disallows /img/, sitemap declared)
- Schema on homepage (Service + Organization + FAQPage + WebSite, 4 blocks)
- BlogPosting + BreadcrumbList on every blog post
- Per-page canonical, OG, Twitter Card, viewport, lang
- HTTPS via GitHub Pages CNAME
- Server-rendered static HTML (AI-crawler-friendly)
