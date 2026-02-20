require 'colorizer'.setup({
    '*',             -- Support all files
}, {
    RGB      = true, -- #RGB
    RRGGBB   = true, -- #RRGGBB
    names    = true, -- Color names, ex: "blue"
    RRGGBBAA = true, -- #RRGGBBAA
    rgb_fn   = true, -- rgb(255, 255, 255)
    hsl_fn   = true, -- hsl(360, 100%, 50%)
    css      = true, -- Support CSS functions
    css_fn   = true, -- Support CSS functions
})
