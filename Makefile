.PHONY: bootstrap docs load rs sh test

bootstrap:
	mysqladmin -h localhost -u root -p create calaccess_raw
	python example/manage.py makemigrations calaccess_raw
	python example/manage.py migrate
	python example/manage.py update
	python example/manage.py collectstatic --noinput
	python example/manage.py runserver

docs:
	python example/manage.py createcalaccessrawmodeldocs
	cd docs && make livehtml

load:
	python  example/manage.py updatecalaccessrawdata --skip-download --skip-clean --keep-files

testload:
	dropdb calaccess_raw
	createdb calaccess_raw
	python example/manage.py migrate
	python example/manage.py test calaccess_raw;

rs:
	python example/manage.py runserver

sh:
	python example/manage.py shell

test:
	pep8 calaccess_raw
	pyflakes calaccess_raw
	coverage run example/manage.py test calaccess_raw
	coverage report -m

testdocs:
	python example/manage.py test calaccess_raw.tests.test_docs.DocumentationTestCase
