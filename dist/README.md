# dist

This is where the automatically-build artifacts go

To clean up old git versions of files that take up a ton of space:

```
FPATH=dist/<version>/<filename>
# Back it up first
cp $FPATH ~/tmp/
git filter-branch --force --index-filter "git rm --cached --ignore-unmatch $FPATH" --prune-empty --tag-name-filter cat -- --all

# If you want only the latest version:
cp ~/tmp/$(basename "$FPATH") $FPATH
git add $FPATH
git commit -m "Pruned all old versions of $FPATH"

git for-each-ref --format='delete %(refname)' refs/original | git update-ref --stdin
git reflog expire --expire=now --all
git gc --prune=now

git push origin --force --all
```
