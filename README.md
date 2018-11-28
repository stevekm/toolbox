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

- Change the URL to a remote 

```bash
git remote set-url origin git@github.com:stevekm/sns-wes-coverage-analysis.git
```

- Add a remote to a git repo

```bash
git remote add clinical git@github.com:NYU-Molecular-Pathology/sns-wes-coverage-analysis.git
```

- [Clean up merged branches](https://stackoverflow.com/a/24558813/5359531)

```bash
# clean local branches
git branch --merged | grep -v 'master\|dev' | xargs git branch -d

# clean remote branches
git branch -r --merged | grep -v 'master\|dev' |  sed 's/origin\///' | xargs git push --delete origin

```

## bash

- parameter expansion & subsitution

<table style="width:100%;">

<tr>
<th></th>
<th><em>parameter</em><br>Set and Not Null</th>
<th><em>parameter</em><br>Set But Null</th>
<th><em>parameter</em><br>Unset</th>
</tr>

<tr>
<td><pre>${parameter:-word}</pre></td>
<td>substitute <pre>parameter</pre></td>
<td>substitute <pre>word</pre></td>
<td>substitute <pre>word</pre></td>
</tr>

<tr>
<td><pre>${parameter-word}</pre></td>
<td>substitute <pre>parameter</pre></td>
<td>substitute <pre>null</pre></td>
<td>substitute <pre>word</pre></td>
</tr>

<tr>
<td><pre>${parameter:=word}</pre></td>
<td>substitute <pre>parameter</pre></td>
<td>assign <pre>word</pre></td>
<td>assign <pre>word</pre></td>
</tr>

<tr>
<td><pre>${parameter=word}</pre></td>
<td>substitute <pre>parameter</pre></td>
<td>substitute <pre>null</pre></td>
<td>assign <pre>word</pre></td>
</tr>

<tr>
<td><pre>${parameter:?word}</pre></td>
<td>substitute <pre>parameter</pre></td>
<td>error, exit</td>
<td>error, exit</td>
</tr>

<tr>
<td><pre>${parameter?word}</pre></td>
<td>substitute <pre>parameter</pre></td>
<td>substitute <pre>null</pre></td>
<td>error, exit</td>
</tr>

<tr>
<td><pre>${parameter:+word}</pre></td>
<td>substitute <pre>word</pre></td>
<td>substitute <pre>null</pre></td>
<td>substitute <pre>null</pre></td>
</tr>

<tr>
<td><pre>${parameter+word}</pre></td>
<td>substitute <pre>word</pre></td>
<td>substitute <pre>word</pre></td>
<td>substitute <pre>null</pre></td>
</tr>

</table>


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

case "$0" in
    -bash|bash|*/bash) echo "do a thing for bash" ;;
    -ksh|ksh|*/ksh) echo "do a thing for ksh" ;;
    -zsh|zsh|*/zsh) echo "do a thing for zsh" ;;
    *) echo "do some other default action" ;; # sh and default for scripts
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

- find ... xargs ...
```bash
find . -name "*.mp3" -print0 | xargs -0 mplayer
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

- find and ignore error messages

```bash
find / 2>/dev/null
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

- [copy directory tree](https://serverfault.com/a/204320/346367)
```bash
rsync --dry-run -vah --include="*/" --exclude="*"  /path/to/source /path/to/target
```

- tar

```bash
# create an archive
tar -zcvf new_archive.tar.gz /path/to/some_file_or_dir

# extract archive
tar -vxzf new_archive.tar.gz
```

- md5 entire directory

```bash
for file in $(find . -type f ! -name "*.md5.txt"); do echo "$file"; md5sum "${file}" > "${file}.md5.txt"; done
```

- list files in archive before downloading

```
wget ftp://igenome:G3nom3s4u@ussd-ftp.illumina.com/Homo_sapiens/UCSC/hg19/Homo_sapiens_UCSC_hg19.tar.gz -O- | tar -ztvf - > tar_contents.txt
```

- extract select files from large archive download

```
wget ftp://igenome:G3nom3s4u@ussd-ftp.illumina.com/Homo_sapiens/UCSC/hg19/Homo_sapiens_UCSC_hg19.tar.gz -O- | tar -zxvf - Homo_sapiens/UCSC/hg19/Sequence/WholeGenomeFasta/genome.fa
```

## Python
- format string compatibility across Python versions
```python
bar = "baz"; print("foo %s" % bar) # 2.6.6, 2.7.3, 3.4.3
bar = "baz"; print("foo {0}".format(bar)) # 2.6.6, 2.7.3, 3.4.3
bar = "baz"; print("foo {}".format(bar)) # 2.7.3, 3.4.3
```

## Docker
- To run a Docker base image directly:

```bash
docker run --privileged --rm -ti debian:jessie /bin/bash
```
## Makefile

- set the default shell to use

```
SHELL:=/bin/bash
```

- Makefile vs. shell variable expansion 

```
HG19_GENOME_FA_MD5:=c1ddcc5db31b657d167bea6d9ff354f9
ref-data:
	echo "$(HG19_GENOME_FA_MD5) ${HG19_GENOME_FA_MD5} $${HG19_GENOME_FA_MD5:=none}"
```
output:
```bash
$ make ref-data
echo "c1ddcc5db31b657d167bea6d9ff354f9 c1ddcc5db31b657d167bea6d9ff354f9 ${HG19_GENOME_FA_MD5:=none}"
c1ddcc5db31b657d167bea6d9ff354f9 c1ddcc5db31b657d167bea6d9ff354f9 none
```

- recursive recipe invocation + dynamic recipes from some source criteria for parallel processing (`make do-thing -j4`)

```
SAMPLES=$(shell tail -n +2 "samples.csv")

do-thing:
	$(MAKE) do-thing-recurse

do-thing-recurse: $(SAMPLES)

$(SAMPLES):
	@sampleID="$$(echo "$@" | cut -d ',' -f1)" ; \
	runID="$$(echo "$@" | cut -d ',' -f2)" ; \
	echo ">>> Doing a thing for runID: $${runID} sampleID: $${sampleID}" ; \
	./do-my-things.sh "$${runID}" "$${sampleID}"
.PHONY: $(SAMPLES)
```
