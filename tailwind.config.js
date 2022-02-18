const colors = require('tailwindcss/colors')

module.exports = {
  content: ['./app/**/*.html.erb',
    './app/**/*.rb',
    './config/initializers/*.rb',
    './app/**/*.js'
  ],
  theme: {
    extend: {
      colors: {
        sky: colors.sky,
        teal: colors.teal,
      },
    },
  },
  plugins: [require('@tailwindcss/forms'),
            require('@tailwindcss/typography'),
            require('@tailwindcss/line-clamp'),
            require('@tailwindcss/aspect-ratio'),],
}