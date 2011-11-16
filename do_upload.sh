touch /home/ost/personal/blog/o1iver.github.com/.nojekyll

cp -r /home/ost/personal/blog/blog/_build/* /home/ost/personal/blog/o1iver.github.com/.
cd /home/ost/personal/blog/o1iver.github.com/

git add --all

git ci -m 'upload...'

git push -u origin master

