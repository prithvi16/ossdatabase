const colors = require('tailwindcss/colors')

module.exports = {
  mode: 'jit',
  purge: ['./app/**/*.html.erb',
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
  variants: {
    extend: {
      fontWeight: ['hover', 'focus'],
      backgroundColor: ['group-focus', 'active'],
      borderColor: ['group-focus'],
      boxShadow: ['group-focus'],
      opacity: ['group-focus'],
      textColor: ['group-focus', 'active'],
      textDecoration: ['group-focus'],
    },
  },
  plugins: [require('@tailwindcss/forms'),
            require('@tailwindcss/typography'),
            require('@tailwindcss/aspect-ratio'),],
}