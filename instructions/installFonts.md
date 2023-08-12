1. Download [NordFont](https://www.nerdfonts.com/)
2. unzip file - `$ unzip {your_file}.zip`
3. mv unziped file to `$ mv {fonts} ~/.local/share/fonts`
4. Run the command `$ fc-cache -fv` to manually rebuild the font cache
5. Reload your terminal.

## If you use Linux and emoji don't display, set `Noto Emoji` from google:

#### Steps:

1. Download [Noto Emoji](https://fonts.google.com/noto/specimen/Noto+Emoji) 
2. unzip file - `$ unzip {your_file}.zip`
3. mv unziped file to `$ mv {fonts} ~/.local/share/fonts`
4. Run the command `$ fc-cache -fv` to manually rebuild the font cache
5. Reload your terminal.

#### If you want to use Noto Emoji with/withour color, set fontconfig like:

* `<family>Noto Emoji</family>` - without color
* `<family>Noto Color Emoji</family>` - with color

```xml
# ~/.config/fontconfig/fonts.conf

<?xml version='1.0' encoding='UTF-8'?>
<!DOCTYPE fontconfig SYSTEM 'fonts.dtd'>
<fontconfig>
 <alias>
  <family>serif</family>
  <prefer>
   <family>Noto Sans</family>
   <family>Noto Emoji</family>
  </prefer>
 </alias>
 <alias>
  <family>sans-serif</family>
  <prefer>
   <family>Noto Sans</family>
   <family>Noto Emoji</family>
  </prefer>
 </alias>
 <alias>
  <family>monospace</family>
  <prefer>
   <family>Noto Sans</family>
   <family>Noto Emoji</family>
  </prefer>
 </alias>
 <dir>~/.fonts</dir>
 <match target="font">
  <edit name="hinting" mode="assign">
   <bool>true</bool>
  </edit>
 </match>
 <match target="font">
  <edit name="hintstyle" mode="assign">
   <const>hintslight</const>
  </edit>
 </match>
</fontconfig>
```

= = = = = = = = = = = 

>**!Note: don`t forget reload your terminal after all**


**DONE** 👉 🦀 = 🤕
