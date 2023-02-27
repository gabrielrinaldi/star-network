const defaultTheme = require('tailwindcss/defaultTheme');

module.exports = {
  content: [
    './app/components/**/*.{rb,erb}',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,html}',
    './config/initializers/heroicon.rb',
    './config/initializers/simple_form.rb',
    './public/*.html',
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
    },
  },
  plugins: [require('@tailwindcss/forms'), require('@tailwindcss/aspect-ratio'), require('@tailwindcss/typography')],
};
