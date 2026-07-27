-- CSS Language Server config
-- Disables validation that conflicts with Tailwind CSS
-- (Tailwind utility classes trigger "unknown property" warnings in cssls)

return {
  settings = {
    css = {
      validate = false, -- cssls doesn't understand Tailwind, disable to avoid noise
    },
    scss = {
      validate = false,
    },
    less = {
      validate = false,
    },
  },
}
