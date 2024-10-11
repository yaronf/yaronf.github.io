deploy:
	(cd blog; bundle exec jekyll build)
	cp -r blog/_site/* .
