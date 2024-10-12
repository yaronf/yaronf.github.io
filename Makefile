deploy:
	(cd blog; bundle exec jekyll build)
	cp -r blog/_site/* .
	sed 's-sheffer.org/blog-sheffer.org-g' <blog/_site/feed.xml >feed.xml
