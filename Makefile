# Recipe targets (that aren't files...all of them)
.PHONY : default setup


# Recipes: Default (first is "default")
default: setup


# Recipes: Aliases
dev: development


# Recipes
setup:
	./bin/setup.sh
update:
	./bin/update.sh
