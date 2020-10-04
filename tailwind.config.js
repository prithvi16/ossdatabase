module.exports = {
  purge: [
    './app/**/*.html.erb'
  ],
  theme: {
    extend: {},
  },
  variants: {},
  plugins: [require('@tailwindcss/ui'),
            require('@tailwindcss/typography'),
    ],
}
