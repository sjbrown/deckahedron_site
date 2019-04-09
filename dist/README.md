# dist

This is where the automatically-build artifacts go

To clean up old git versions of files that take up a ton of space:

```
# Back it up first
cp dist/<version>/<filename> ~/tmp/
git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch dist/<version>/<filename>' --prune-empty --tag-name-filter cat -- --all

# If you want only the latest version:
cp ~/tmp/<filename> dist/<version>/<filename>
git add dist/<version>/<filename>
git commit -m "Pruned all old versions of a dist file"

git push origin --force --all

git for-each-ref --format='delete %(refname)' refs/original | git update-ref --stdin
git reflog expire --expire=now --all
git gc --prune=now
```
