# Full SEO Audit — www.1minutesales.com

**Date:** 2026-05-21
**Pages audited:** 24 (7 root + 1 blog index + 13 blog posts + 3 landing)
**Platform:** GitHub Pages (static), CNAME on www.1minutesales.com
**Business type:** B2B service — outsourced sales / lead response for high-ticket verticals (PI law, cosmetic clinics, custom builders, premium home services)

---

## Executive Summary

**Overall SEO Health Score: 61 / 100** (solid foundations, several high-leverage fixes available)

| Category | Weight | Score | Weighted |
|---|---|---|---|
| Technical SEO | 22% | 61 | 13.4 |
| Content Quality + E-E-A-T | 23% | 50 | 11.5 |
| On-Page SEO | 20% | 70 | 14.0 |
| Schema / Structured Data | 10% | 75 | 7.5 |
| Performance (CWV) | 10% | 50 | 5.0 |
| AI Search Readiness | 10% | 67 | 6.7 |
| Images | 5% | 60 | 3.0 |
| **Total** | | | **61** |

### What's already strong

- Comprehensive `sitemap.xml` (just updated to 26 URLs covering all crawlable pages)
- Sound `robots.txt` (allows `/`, sitemap declared)
- **`llms.txt` exists and is comprehensive** — top decile vs peer sites
- Organization + Service + FAQPage + WebSite schema on homepage
- BlogPosting + BreadcrumbList schema on every blog post
- Every page has `lang="en"`, viewport meta, canonical link, OG + Twitter Card tags
- HTTPS via GitHub Pages + CNAME
- Server-rendered static HTML (no CSR issues — AI crawlers see everything)

### Top 5 critical issues

1. **Site-wide dead anchor links** — every page's nav and footer links to `/#features`, `/#integrations`, `/#pricing`, none of which exist on the homepage. ~23 pages affected.
2. **Tailwind CDN render-blocker** — `<script src="https://cdn.tailwindcss.com">` is the single biggest CWV drag, on every page.
3. **Fabricated-looking precision stat** — `blog/posts/why-leads-arent-converting.html` cites "12% without AI, 38–45% with AI" with no source. Highest E-E-A-T failure on the site under the Sept 2025 Quality Rater Guidelines.
4. **Three landing pages have zero schema and ~70% identical copy** — `builders-remodelers`, `cosmetic-med-spa`, `personal-injury` are at risk of near-duplicate doorway-page treatment.
5. **Duplicate-intent blog posts** — `cost-of-slow-response.html` (738w) cannibalizes `slow-lead-response-cost.html` (3,570w). Both indexed. No canonical or redirect.

### Top 5 quick wins (high impact / low effort)

1. **Add missing IDs to homepage sections** — fix the dead anchor links by adding `id="features"`, `id="integrations"`, `id="pricing"` to existing homepage sections. 5-min fix.
2. **Add `@id` to Organization schema + link `Service.provider`** — consolidates entity identity for Google Knowledge Panel. 10 min.
3. **Fill the 4 footer social icon links** (currently `href="#"`) and add `sameAs` to Organization schema. Biggest single GEO authority signal upgrade.
4. **Add explicit AI-crawler `Allow:` rules to robots.txt** for GPTBot, ClaudeBot, PerplexityBot, Google-Extended. Costs nothing, signals GEO intent.
5. **Render the existing FAQ schema as a visible accordion on the homepage** — schema is at `index.html:74-121`; on-page visibility is the missing piece.

---

## 1. Technical SEO

### Critical
- **Dead anchor links sitewide** — `#features`, `#integrations`, `#pricing` referenced from every page's nav/footer but not present on `index.html`. Affected: all 23 non-homepage files (e.g. `blog/index.html:94-97`, `contact.html:47-50`, `who-we-help.html:47-50`).

### High
- **Tailwind CDN render-blocker** (`index.html:27` + every other page). ~350 KB synchronous parse before render. The single biggest CWV win.
- **Google Fonts synchronous stylesheet** (`index.html:29`). `display=swap` is set but the stylesheet itself blocks.
- **Logo has `loading="lazy"` above the fold** (`index.html:174`). Add `fetchpriority="high"` instead.
- **`who-we-help.html:9` canonical strips `.html`** but the sitemap (line 18 of old sitemap; now corrected) listed it with `.html`. Canonical and actual served URL must match.
- **Privacy/terms (noindex) appeared in sitemap** — already removed in the new sitemap.xml by the sitemap subagent.

### Medium
- **No favicon** (404 on `/favicon.ico` requests across all pages). Add `<link rel="icon">` in shared `<head>`.
- **BlogPosting `"image"` field across all 13 posts uses the company logo** instead of an article hero — fails Google's 1200px-wide representative-image rule for rich results.
- **No IndexNow integration** — given the active blog, this would accelerate Bing indexing at zero cost.

### Low
- `careers.html:54` canonical line has indentation drift suggesting copy-paste — confirm placement.
- `og:image` is a white logo on transparent — renders invisible on most preview cards (Slack, iMessage). Create a 1200×630 branded OG image.

---

## 2. Content Quality + E-E-A-T

E-E-A-T scores by page category:

| Category | Score | Primary drag |
|---|---|---|
| Homepage | 52/100 | No named author, no testimonials, no client logos |
| Blog index | 48/100 | Pure nav, no editorial voice |
| Blog (long-form, 5 posts) | 61/100 | Good structure, weak source attribution on stats |
| Blog (short-form, 7 posts) | 38/100 | Under 1000-word floor, no citations |
| Landing pages | 44/100 | ~70% identical copy across three industries |

### Critical
- **Unsourced precision stat at `blog/posts/why-leads-arent-converting.html:161-179`** — "12% without AI, 38-45% with AI" with no citation. Sept 2025 QRG explicitly calls this out as a Trust signal failure for commercial content.

### High
- **Duplicate-intent blog pair:** `cost-of-slow-response.html` (738w) vs `slow-lead-response-cost.html` (3,570w). Both indexed, both linked from blog index. Consolidate via canonical pointing the shorter at the longer.
- **Seven blog posts under 1,000-word floor:** lead-response-benchmarks (658), sales-outsourcing-vs-hiring (696), cost-of-slow-response (738), why-leads-arent-converting (773), commission-only-sales (816), chatbots-vs-sdr-vs-ai (855), ai-in-sales-process (903).
- **Three landing pages share ~70% identical copy:** `builders-remodelers.html`, `cosmetic-med-spa.html`, `personal-injury.html`. Workflow section + "Use language like / Avoid language like" panel are near-identical across all three. Highest near-duplicate risk on the site.
- **FAQ schema on homepage (lines 74-121) has no visible on-page equivalent.** Google rich-result eligibility requires user-visible FAQ content.
- **All 13 blog posts use `"@type": "Organization"` as author.** Replacing with a named `Person` is the single highest-leverage E-E-A-T move available.

### Medium
- Homepage cites "21x more likely to convert" (`index.html:270`) with no source.
- `391-higher-conversion-rates.html:130` credits "Harvard Business Review" but provides no link or study name.
- Landing pages have no FAQPage schema, no stats, no AI-citable passages.

---

## 3. On-Page SEO

Strong overall: every page has title, description, canonical, lang, viewport, OG, Twitter Card. Only friction:

- Title-tag length on homepage is borderline long (~70 chars) — verify Google doesn't truncate.
- Meta keywords are present on every page — harmless but obsolete. Could be removed without impact.
- H1 hierarchy clean across the site.
- Internal linking is solid for blog→home but weak between blog posts (no "related posts" section).

---

## 4. Schema / Structured Data

### Existing (already strong)
- `index.html`: Service, FAQPage, Organization, WebSite+SearchAction (4 blocks)
- `blog/index.html`: Blog, BreadcrumbList
- All 13 blog posts: BlogPosting + BreadcrumbList (5 of them also have FAQPage)

### Validation findings (High priority)
- **`Organization` missing `@id` anchor** → other blocks can't reference back. Fix at `index.html:123`.
- **`Service.provider` missing** → add `"provider": {"@id": "https://www.1minutesales.com/#org"}` at `index.html:54`.
- **`WebSite` `SearchAction.target` uses old EntryPoint object format** — should be a plain string per current Google spec. Fix at `index.html:158-161` OR remove the `potentialAction` entirely since no working search exists at `/blog/?q=`.
- **All 13 BlogPosting blocks missing top-level `url` and `keywords` properties** — recommended by Google.
- **`blog/index.html` Blog block missing `inLanguage`**.

### Missing schema (High priority — 6 pages)
- `contact.html` — needs `ContactPage`
- `careers.html` — needs `JobPosting` (commission-only sales role)
- `schedule-strategy-call.html` — needs `Service` (free strategy call as offer)
- `landing/builders-remodelers.html` — needs vertical-specific `Service`
- `landing/cosmetic-med-spa.html` — needs vertical-specific `Service`
- `landing/personal-injury.html` — needs vertical-specific `Service`
- `who-we-help.html` — could use `WebPage` + `BreadcrumbList` (low priority)

(Full ready-to-paste JSON-LD blocks are in the schema subagent's report — preserved verbatim in this audit's working notes for the action plan.)

### Advisory
- FAQPage schema on commercial sites no longer generates Google rich results (Aug 2023 change). Keep it for AI/LLM benefit — it still helps ChatGPT, Perplexity, Gemini citation.

---

## 5. Performance (Core Web Vitals — lab estimates)

Cannot measure live CrUX without Google API access. Lab-level inspection:

| Likely metric | Estimate | Cause |
|---|---|---|
| LCP | 3.5-4.5s | Tailwind CDN script blocks render until parsed |
| INP | OK (<200ms) | Site is mostly static HTML; minimal JS interactivity |
| CLS | OK (<0.1) | No layout-shifting content; no late-loading images above fold |

The single CWV intervention worth doing: **build Tailwind CSS statically and replace the CDN `<script>` with a `<link rel="stylesheet">`**. Everything else (font loading, image preload) compounds but the CDN is 80% of the issue.

---

## 6. AI Search Readiness (GEO)

Score: **67/100** — already top-quartile among service-business sites thanks to llms.txt + FAQ schema.

| Platform | Score | Primary gap |
|---|---|---|
| Google AI Overviews | 71 | Missing named author + sameAs; no homepage definition paragraph |
| ChatGPT Search | 68 | llms.txt lacks stats + verbatim FAQs; no llms-full.txt |
| Perplexity | 74 | Strong blog citations; gap is sameAs |
| Bing Copilot | 61 | Entity ambiguity (no sameAs); broken social links |

Top three GEO fixes:

1. **Add a named entity-definition paragraph to homepage** (140-160 words, "What is 1 Minute Sales?"). Currently no standalone definition exists anywhere — the FAQ schema's first answer is the closest. AI systems will synthesize their own definition (often miscategorizing as "AI chatbot" or "answering service") without one.
2. **Fill `sameAs` and the four footer social hrefs** — Organization schema's most powerful entity-disambiguation property is missing.
3. **Enrich llms.txt** — add a stats section with sourced figures, align language from "platform/system" to "service/team" (matches homepage), add a `Last updated:` stamp. Optional: split into `llms.txt` (summary) + `llms-full.txt` (verbatim FAQ + use cases).

Also: add explicit AI-crawler `Allow:` rules to robots.txt for GPTBot, OAI-SearchBot, ClaudeBot, PerplexityBot, Google-Extended. Currently the wildcard `Allow: /` covers them functionally but explicit rules signal intent.

---

## 7. Images

- All in-content images checked have `alt` text (sampled).
- Logo `loading="lazy"` above the fold is the only critical issue (covered in Technical §H3).
- OG/Twitter Card image uses the white-on-transparent logo — renders blank on most social preview surfaces. Create a 1200×630 branded card.
- No image dimensions specified on most `<img>` tags — potential CLS contributor, low impact for this content shape.

---

## Files for follow-up

- `ACTION-PLAN.md` — prioritized, with effort estimates
- `sitemap.xml` — already updated by the sitemap subagent (26 URLs, includes landing/* and privacy/terms removed; `.html` extension consistency preserved)

---

## Specialist reports

All five specialist audits ran in parallel:
- **seo-technical** — flagged dead anchors, Tailwind CDN, font blocking, canonical mismatch, noindex-in-sitemap
- **seo-content** — flagged unsourced stats, duplicate blog pair, thin landing pages, missing FAQ visibility, Organization-as-author
- **seo-schema** — flagged missing @id, six pages with no schema, BlogPosting field gaps
- **seo-geo** — flagged llms.txt gaps, no sameAs, broken social links, no entity definition paragraph
- **seo-sitemap** — rewrote sitemap.xml to include landing pages, remove noindex pages, strip ignored priority/changefreq

Their full reports are preserved in the working session.
