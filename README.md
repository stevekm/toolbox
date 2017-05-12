# toolbox
general scripts that I use a lot


# Notes

## Git

- Remove a file or commit from the repository history by rolling the repo history back to a known good commit, then updating the remote to match
  - NOTE: Will destroy any unstaged changes and completely remove changes to tracked files from the history
  - NOTE: This is dangerous, use with caution
```bash
git reset --hard <commit_ID> # e.g. d487e18b3d27900160f79b12f56c8e106150151c
git push --force
```

- [Roll back all files to specific commit's state](http://stackoverflow.com/a/4114122/5359531)
```bash
git checkout <commit_ID> 
```

- [Update all submodules](http://stackoverflow.com/a/5828396/5359531)

```bash
git pull --recurse-submodules  && git submodule update --recursive --remote

git submodule foreach git pull

# submodules within submodules
git submodule foreach --recursive git pull origin master
```

## bash
code snippets
- case statement
```bash
case "$string" in 
    *substring*)
    # Do stuff
    ;;
esac
```
- functions
```bash
my_function () {
    local item="$1"
    printf "This is the item:\n%s\n\n" "$item"
}

print_div () {
    local default_message=""
    local message="${1:-$default_message}"
    div="-----------------------------------"
    printf "\n%s\n%s\n" "$div" "$message"
}
```

- find ... while read ...
```bash
find "$my_dir" -type f -name "*.txt" -print0 | while read -d $'\0' item; do
    print_div
    my_function "$item"
done

```
- if ... then ... elif ... else
```bash
if [ -f "$item" ]; then
   echo "Its a file"
elif [ -d "$item" ]; then
   echo "Its a dir"
else
   echo "Not a file or a dir"
fi
```

- date

```bash
# epoch time
date +%s

#timestamp
date +"%Y-%m-%d-%H-%M-%S"
```
