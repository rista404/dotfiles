# apply chezmoi changes without running scripts
apply:
    chezmoi apply --exclude=scripts

# re-add configs that are often edited directly
sync:
    chezmoi re-add ~/.config/zed/settings.json ~/.config/zed/keymap.json ~/.config/ghostty/config

# sync and commit
save message="update configs":
    just sync
    git add -A
    git commit -m "{{message}}"

# sync and push
push message="update configs":
    just save "{{message}}"
    git push
