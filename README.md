# toolbox
general scripts that I use a lot


# Notes

## Git

- Remove a file or commit from the repository history by rolling back to a known good commit, then updating the remote to match
  - NOTE: Will destroy any unstaged changes and completely remove changes to tracked files from the history
```bash
git reset --hard <commit_ID> # e.g. d487e18b3d27900160f79b12f56c8e106150151c
git push --force
```

- [Roll back to a specific commit in the repo history](http://stackoverflow.com/a/2007704/5359531)
```bash
git checkout <commit_ID> .
```

- [Update all submodules](http://stackoverflow.com/a/5828396/5359531)

```bash
git pull --recurse-submodules  && git submodule update --recursive --remote

git submodule foreach git pull

# submodules within submodules
git submodule foreach --recursive git pull origin master
```

