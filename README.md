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

- [Add a submodule](https://github.com/blog/2104-working-with-submodules)

```bash
git submodule add https://github.com/stevekm/toolbox.git toolbox
```

- [Update all submodules](http://stackoverflow.com/a/5828396/5359531)

```bash
git pull --recurse-submodules  && git submodule update --recursive --remote

git submodule foreach git pull

# submodules within submodules
git submodule foreach --recursive git pull origin master
```

- Set [email](https://help.github.com/articles/setting-your-email-in-git/) and [username](https://help.github.com/articles/setting-your-username-in-git/) to use with git (e.g. on a new machine)

```bash
git config --global user.email "email@example.com"
git config --global user.name "Mona Lisa"

# check
git config --global user.email
git config --global user.name
```


## bash
code snippets
- case statement
```bash
case "$string" in 
    *substring*)
    # Do stuff
    ;;
    *)
    # no match; do other stuff
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

- while ...
```bash
while (( $(ls -1 | wc -l) < 2 )) 
    do
        touch "foo_$(date +%s).txt"
    done
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

- rsync
  - dry run, verbose output, recursive, use checksums, preserve all metadata, show file progress and maintain partial downloads, copy symlinks as symlinks, login with ssh, exlcude certain files
```bash
rsync --dry-run -vrcahPl -e ssh username@server.org:/path/to/data/source /path/to/destination --exclude="*.bam" --exclude="*.fastq.gz"
```

- scp
```bash
scp -vr username@server.org:/path/to/data/source /path/to/destination
```

- [tee](http://stackoverflow.com/questions/692000/how-do-i-write-stderr-to-a-file-while-using-tee-with-a-pipe)
```bash
# stdout and stderr in a single log 
command 2>&1 | tee -a log

# separate logs for stdout and stderr
command > >(tee stdout.log) 2> >(tee stderr.log >&2)
```

## Python
- format string compatibility across Python versions
```python
bar = "baz"; print("foo %s" % bar) # 2.6.6, 2.7.3, 3.4.3
bar = "baz"; print("foo {0}".format(bar)) # 2.6.6, 2.7.3, 3.4.3
bar = "baz"; print("foo {}".format(bar)) # 2.7.3, 3.4.3
```
