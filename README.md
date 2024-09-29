# GIT STATS

Bunch of useful scripts for git statistics

---
run ./git-top-contributors.sh to see top contributors in repository for the last month 

output looks like

```bash
➜  my-project git:(develop) ✗ ./git-top-contributors.sh
Ivan                      | Added:  12616 | Removed:   7186 | Total:   5430
Sergey                    | Added:   5719 | Removed:   1701 | Total:   4018
Aldar                     | Added:   3153 | Removed:    935 | Total:   2218
```
---

run ./all-repos-contrib.sh to see your total contribution in all repos found on your computer for the last month

output looks like

```bash
➜  git_stats git:(main) ✗ ./all-repos-contrib.sh   
Processing: /Users/mikhailsavin/projects/git_stats
  Added: 32, Removed: 0, Total: 32
...
Processing: /Users/mikhailsavin/4
  Added: , Removed: , Total: 
Total added lines: 39946
Total removed lines: 20522
Total lines: 19424

```
---

run following command to get your contribution in current repo for the last month

```bash
git log --all --author="Mikhail" --since="1 month ago" --pretty=tformat: --numstat | awk '{ add += $1; subs += $2; loc += $1 - $2 } END { printf "added lines: %s, removed lines: %s, total lines: %s\n", add, subs, loc }'
```

outputs like 
```bash
added lines: 111, removed lines: 4, total lines: 107
```
---