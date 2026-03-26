function idea
    if test -f ~/Library/Application\ Support/JetBrains/Toolbox/scripts/idea
        ~/Library/Application\ Support/JetBrains/Toolbox/scripts/idea $argv
    else
        echo "Jetbrains Toolbox shell script generation is not configured."
        echo "Please verify that you have \"Generate shell scripts\" toggled ON in the Jetbrains Toolbox settings."
        echo "The \"Shell scripts location\" path should be set to:"
        echo "\"~/Library/Application Support/JetBrains/Toolbox/scripts/\""
    end
end