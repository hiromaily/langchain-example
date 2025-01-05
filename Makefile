#------------------------------------------------------------------------------
# Only Initial install
#------------------------------------------------------------------------------
.PHONY: install-python
install-python:
	asdf plugin add python
	asdf install python 3.12.8
	asdf global python 3.12.8
	python -V

# https://python-poetry.org/docs/#installing-with-the-official-installer
.PHONY: install-poetry
install-poetry:
	curl -sSL https://install.python-poetry.org | python3 -
	poetry --version

# no needs to run. just memo
.PHONY: create-project
create-project:
	poetry new langchain-example
	#poetry init

# no needs to run. just memo
.PHONY: install-dependencies
install-dependencies:
	poetry add langchain-core langchain-openai
	poetry add python-dotenv argparse
	poetry add -D flake8 black isort mypy pytest
	poetry add --group dev Flake8-pyproject


#------------------------------------------------------------------------------
# Install after clone project
#------------------------------------------------------------------------------
.PHONY: set-env
set-env:
	poetry env use 3.12.8
	#poetry install
	poetry install --no-root

#------------------------------------------------------------------------------
# dev
#------------------------------------------------------------------------------
.PHONY: lint
lint:
	@# format import
	poetry run isort src
	@# format by PEP8
	poetry run black src
	@# lint
	poetry run flake8 src

# run price_monitoring task
.PHONY: run
run:
	poetry run python src/main.py

.PHONY: run-create-markdown
run-create-markdown:
	poetry run python src/main.py --task create_markdown_for-openapi
