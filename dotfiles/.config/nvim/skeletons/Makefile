# Variables
foo := bar

# Recipes: Default
.DEFAULT_GOAL := help

# Recipe phony targets (that aren't files...all of them)
.PHONY: all clean dev development help test

# Recipes: Aliases
dev: development

# Recipes: Targets
development: ## Development stuff and things
	echo "Sup"

help: ## Show help
	@echo "Usage: make [recipe]\n\nRecipes:"
	@grep -h '##' $(MAKEFILE_LIST) | grep -v grep | sed -e 's/\(.*\):.*## \(.*\)/\1|    \2/' | tr '|' '\n'
