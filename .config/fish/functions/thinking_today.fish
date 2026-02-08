function thinking_today
    set filename (date +%Y-%m-%d).md
    touch $filename
    $EDITOR $filename
end
