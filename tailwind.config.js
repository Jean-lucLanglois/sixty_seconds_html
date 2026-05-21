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
        inter: ["Inter", "ui-sans-serif", "system-ui", "sans-serif"]
      },
      colors: {
        accent: "#D3BC5F",
        bgdeep: "#0B0F12"
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
