/** @type {import('tailwindcss').Config} */
module.exports = {
  // Scan every HTML page on the site for Tailwind class usage.
  content: [
    "./*.html",
    "./blog/**/*.html",
    "./landing/**/*.html"
  ],
  theme: {
    extend: {
      fontFamily: {
        // Existing pages keep Inter; the new homepage look uses the trio below.
        inter: ["Inter", "ui-sans-serif", "system-ui", "sans-serif"],
        sans: ["Hanken Grotesk", "ui-sans-serif", "system-ui", "sans-serif"],
        serif: ["Newsreader", "Georgia", "serif"],
        mono: ["JetBrains Mono", "ui-monospace", "SFMono-Regular", "monospace"]
      },
      colors: {
        accent: "#D3BC5F",
        bgdeep: "#0B0F12",
        // New homepage palette.
        gold: "#E7B14C",
        golddim: "#C8902F",
        ink: "#0B0B0C",
        paper: "#F5F4EF",
        cream: "#ECECE8",
        mint: "#5BB98C"
      },
      boxShadow: {
        glow: "0 0 40px 0 rgba(34, 211, 166, 0.15)"
      }
    }
  },
  plugins: [
    require("@tailwindcss/typography")
  ]
}
