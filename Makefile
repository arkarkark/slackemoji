SRC_ICON = slackemoji.png
CSON_FILES = $(wildcard *.cson)
COFFEE_FILES = $(wildcard *.coffee)
ICONS=icon128.png icon48.png icon16.png
ZIP_EXCLUDE= $(CSON_FILES) $(COFFEE_FILES) .git* $(SRC_ICON) screenshot*.png Makefile README.md \
	node_modules/* package.json

JSON_FILES = $(CSON_FILES:.cson=.json)
JS_FILES = $(COFFEE_FILES:.coffee=.js)

space :=
space +=
ZIP_EXCLUDE_FLAGS = --exclude=$(subst $(space),$(space)--exclude=,$(ZIP_EXCLUDE))

build: setup $(wildcard **/*) $(ICONS) $(JSON_FILES) $(JS_FILES)
	dirname=$(shell basename $(PWD)); zip -r $(ZIP_EXCLUDE_FLAGS) ../$$dirname.zip . $(ZIP_INCLUDES)

clean:
	rm -fv $(JSON_FILES) $(JS_FILES) $(ICONS)
	rm -rf node_modules/

%.js : %.coffee
	./node_modules/coffee-script/bin/coffee -p $< > $@

%.json : %.cson
	./node_modules/.bin/cson2json $< > $@

icon%.png: $(SRC_ICON)
	convert $(SRC_ICON) -resize $* $@

setup: package.json
	npm install
