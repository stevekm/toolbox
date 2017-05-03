# Git

Remove a file or commit from the repository history by rolling back to a known good commit, then updating the remote to match
- NOTE: Will destroy any unstaged changes and completely remove changes to tracked files from the history
```bash
git reset --hard <commit_ID> # e.g. d487e18b3d27900160f79b12f56c8e106150151c
git push --force
```