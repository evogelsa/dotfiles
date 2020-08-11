mkdir -p $HOME/Pictures/screenshots
scrot -a $(slop -f '%x,%y,%w,%h') $HOME/Pictures/screenshots/screenshot_%Y-%m-%d_%H%M%S.png -e 'xclip -sel clip -t image/png < $f'
