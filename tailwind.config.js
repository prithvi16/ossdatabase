module.exports = {
  purge: [
    './app/**/*.html.erb',
    './app/**/*.rb'
  ],
  theme: {
    extend: {},
  },
  variants: {},
  plugins: [require('@tailwindcss/ui'),
            require('@tailwindcss/typography'),
    ],
}
