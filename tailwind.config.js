module.exports = {
    mode: 'jit',
    purge: [
      './pages/**/*.{js,jsx,ts,tsx,vue}',
      './components/**/*.{js,jsx,ts,tsx,vue}',
    ],
    media: false, // or 'media' or 'class'
    variants: {},
    theme: {
    },
    plugins: [],
}