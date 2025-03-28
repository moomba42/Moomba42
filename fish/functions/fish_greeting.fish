function fish_greeting
    echo (set_color red;)Hello, (finger $USER | grep -o 'Name: [A-z0-9]*' | cut -d' ' -f2-) (set_color normal;)
end