module.exports = {
  purge: [
    './app/**/*.html.erb',
    './app/**/*.rb',
    './config/initializers/*.rb'
  ],
  theme: {
    extend: {},
  },
  variants: {},
  plugins: [require('@tailwindcss/ui'),
            require('@tailwindcss/typography'),
    ],
}
