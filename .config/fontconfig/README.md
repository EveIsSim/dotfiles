# Setup emoji font

1. check emoji font
    - `fc-list | grep -i "emoji"`
2. if p.1 returned empty, execute:
    - `sudo pacman -S noto-fonts-emoji`
3. put `.config.fontconfig/` dir to your `.config/`
4. `fc-cache -fv`
    - if you try to solve it for dunst, restart it:
        - `pkill dunst && dunst &`
5. profit!

### Why?
I had a problem with displaying emoji in dunst.

`dunst` (like most GUI applications on Linux) uses Fontconfig to select fonts.
When you specify a font (e.g., `FiraCode Nerd Font`), Fontconfig:

* tries to find the character (e.g., 🎉) in that font;
* if the character is missing, it searches for a fallback font that contains it;
* without an explicit fallback configuration, it might:
    * fail to substitute any font at all,
    * pick the wrong font (sometimes one without colored emoji),
    * or simply ignore the missing character.

### Additional
1. test notify via dunst:
    - `notify-send "🎉 It works!" "Emoji should display now"`

