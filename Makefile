.PHONY: void serve build clean

# Create a new void
void:
	@read -p "Enter void title: " title; \
	if [ -z "$$title" ]; then \
		echo "Error: void title cannot be empty"; \
		exit 1; \
	fi; \
	last=$$(ls content/voids/[0-9]*.md 2>/dev/null | sed 's/.*\/\([0-9]*\)\.md/\1/' | sort -n | tail -1); \
	if [ -z "$$last" ]; then \
		next=1; \
	else \
		next=$$(($$last + 1)); \
	fi; \
	slug=$$next; \
	file="content/voids/$$slug.md"; \
	echo "Creating $$file..."; \
	echo "+++" > "$$file"; \
	echo "title = \"$$title\"" >> "$$file"; \
	echo "date = $$(date +%Y-%m-%d)" >> "$$file"; \
	echo "" >> "$$file"; \
	echo "[taxonomies]" >> "$$file"; \
	echo "tags = []" >> "$$file"; \
	echo "" >> "$$file"; \
	echo "[extra]" >> "$$file"; \
	echo "# preview_image = \"images/preview.jpg\"" >> "$$file"; \
	echo "# images = [\"images/photo1.jpg\", \"images/photo2.jpg\"]" >> "$$file"; \
	echo "+++" >> "$$file"; \
	echo "" >> "$$file"; \
	echo "Description goes here." >> "$$file"; \
	echo "" >> "$$file"; \
	echo "### Process" >> "$$file"; \
	echo "" >> "$$file"; \
	echo "### Materials" >> "$$file"; \
	echo "" >> "$$file"; \
	echo "Created $$file with URL: /voids/$$slug/"

# Serve locally
serve:
	zola serve

# Build site
build:
	zola build

# Clean build artifacts
clean:
	rm -rf public
