# Stats 400 Group 6 — Static Site

This folder contains a minimal three-page website you can push to GitHub and publish with GitHub Pages.

## Pages
- `csv.html` — scrollable view of `revised_sat_dataset.csv`
- `regression.html` — key regression outputs from the project doc
- `plots.html` — a few simple PNG plots generated from the CSV
- `index.html` — simple home page

## How to publish (GitHub Pages)
1. Create a repo (or use existing), e.g., `fa25_stats400_group6`.
2. Copy the contents of this `site/` folder into the **repo root**.
3. Commit & push:
   ```bash
   git add .
   git commit -m "Add static site"
   git push
   ```
4. In GitHub **Settings → Pages**, set:
   - **Source**: `Deploy from a branch`
   - **Branch**: `main` (root)
5. Your site will be available at [`https://<your-username>.github.io/<repo-name>/`.](https://victordashuaibi.github.io/fa25_stats400_group6/
)
