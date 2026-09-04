SHELL := /bin/sh

JEKYLL_ENV ?= development
HOST ?= 127.0.0.1
PORT ?= 4000
JEKYLL := bundle exec jekyll

.DEFAULT_GOAL := help

.PHONY: help install build run serve test format clean

help: ## Show the available targets
	@awk 'BEGIN { FS = ":.*## "; printf "Usage: make <target>\n\nTargets:\n" } /^[a-zA-Z_-]+:.*## / { printf "  %-10s %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

install: ## Install Ruby, Python, and Node dependencies
	bundle install
	python3 -m pip install -r requirements.txt
	npm install

build: ## Build the site into _site
	JEKYLL_ENV=$(JEKYLL_ENV) $(JEKYLL) build

run: ## Run the development server with live reload
	JEKYLL_ENV=$(JEKYLL_ENV) $(JEKYLL) serve --host $(HOST) --port $(PORT) --livereload

serve: run ## Alias for run

test: ## Build for production and check source formatting
	JEKYLL_ENV=production $(JEKYLL) build
	npx prettier . --check

format: ## Format supported source files with Prettier
	npx prettier . --write

clean: ## Remove generated Jekyll output and caches
	$(JEKYLL) clean
