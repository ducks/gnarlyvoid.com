.PHONY: void writing serve build clean

# Create a new void
void:
	@read -p "Enter void title: " title; \
	if [ -z "$$title" ]; then \
		echo "Error: void title cannot be empty"; \
		exit 1; \
	fi; \
	read -p "Enter description: " description; \
	if [ -z "$$description" ]; then \
		echo "Error: description cannot be empty"; \
		exit 1; \
	fi; \
	read -p "Enter tags (comma-separated): " tags; \
	last=$$(ls content/voids/[0-9]*.md 2>/dev/null | sed 's/.*\/\([0-9]*\)\.md/\1/' | sort -n | tail -1); \
	if [ -z "$$last" ]; then \
		next=1; \
	else \
		next=$$(($$last + 1)); \
	fi; \
	slug=$$next; \
	branch="post/void-$$slug"; \
	echo "Creating branch $$branch..."; \
	git checkout -b "$$branch"; \
	file="content/voids/$$slug.md"; \
	echo "Creating $$file..."; \
	echo "+++" > "$$file"; \
	echo "title = \"$$title\"" >> "$$file"; \
	echo "date = $$(date +%Y-%m-%d)" >> "$$file"; \
	echo "description = \"$$description\"" >> "$$file"; \
	echo "" >> "$$file"; \
	echo "[taxonomies]" >> "$$file"; \
	if [ -n "$$tags" ]; then \
		echo -n "tags = [" >> "$$file"; \
		IFS=','; \
		first=true; \
		for tag in $$tags; do \
			tag=$$(echo $$tag | xargs); \
			if [ "$$first" = true ]; then \
				echo -n "\"$$tag\"" >> "$$file"; \
				first=false; \
			else \
				echo -n ", \"$$tag\"" >> "$$file"; \
			fi; \
		done; \
		echo "]" >> "$$file"; \
	else \
		echo "tags = []" >> "$$file"; \
	fi; \
	echo "" >> "$$file"; \
	echo "[extra]" >> "$$file"; \
	echo "preview_image = \"images/$$slug/1.jpeg\"" >> "$$file"; \
	echo "images = [\"images/$$slug/1.jpeg\", \"images/$$slug/2.jpeg\"]" >> "$$file"; \
	echo "+++" >> "$$file"; \
	echo "" >> "$$file"; \
	echo "Description goes here." >> "$$file"; \
	echo "" >> "$$file"; \
	echo "### Process" >> "$$file"; \
	echo "" >> "$$file"; \
	echo "### Materials" >> "$$file"; \
	echo "" >> "$$file"; \
	echo "Created $$file with URL: /voids/$$slug/"

# Create a new writing post (text, no artwork)
writing:
	@read -p "Enter post title: " title; \
	if [ -z "$$title" ]; then \
		echo "Error: title cannot be empty"; \
		exit 1; \
	fi; \
	read -p "Enter description: " description; \
	if [ -z "$$description" ]; then \
		echo "Error: description cannot be empty"; \
		exit 1; \
	fi; \
	read -p "Enter slug (kebab-case): " slug; \
	if [ -z "$$slug" ]; then \
		echo "Error: slug cannot be empty"; \
		exit 1; \
	fi; \
	read -p "Enter tags (comma-separated): " tags; \
	last=$$(ls content/writing/[0-9]*.md 2>/dev/null | sed 's/.*\/\([0-9]*\)\.md/\1/' | sort -n | tail -1); \
	if [ -z "$$last" ]; then \
		next=1; \
	else \
		next=$$(($$last + 1)); \
	fi; \
	branch="write/writing-$$next"; \
	echo "Creating branch $$branch..."; \
	git checkout -b "$$branch"; \
	file="content/writing/$$next.md"; \
	echo "Creating $$file..."; \
	echo "+++" > "$$file"; \
	echo "title = \"$$title\"" >> "$$file"; \
	echo "date = $$(date +%Y-%m-%d)" >> "$$file"; \
	echo "description = \"$$description\"" >> "$$file"; \
	echo "slug = \"$$slug\"" >> "$$file"; \
	echo "aliases = [\"/writing/$$next/\"]" >> "$$file"; \
	echo "" >> "$$file"; \
	echo "[taxonomies]" >> "$$file"; \
	if [ -n "$$tags" ]; then \
		echo -n "tags = [" >> "$$file"; \
		IFS=','; \
		first=true; \
		for tag in $$tags; do \
			tag=$$(echo $$tag | xargs); \
			if [ "$$first" = true ]; then \
				echo -n "\"$$tag\"" >> "$$file"; \
				first=false; \
			else \
				echo -n ", \"$$tag\"" >> "$$file"; \
			fi; \
		done; \
		echo "]" >> "$$file"; \
	else \
		echo "tags = []" >> "$$file"; \
	fi; \
	echo "" >> "$$file"; \
	echo "[extra]" >> "$$file"; \
	echo "post_type = \"writing\"" >> "$$file"; \
	echo "# Optional. A writing post is a void that runs longer: it may have" >> "$$file"; \
	echo "# images (same as a void, first is the preview) or none at all." >> "$$file"; \
	echo "# preview_image = \"images/writing/$$next/1.jpg\"" >> "$$file"; \
	echo "# images = [\"images/writing/$$next/1.jpg\"]" >> "$$file"; \
	echo "+++" >> "$$file"; \
	echo "" >> "$$file"; \
	echo "Body goes here." >> "$$file"; \
	echo "" >> "$$file"; \
	echo "Created $$file with URL: /writing/$$slug/"

# Serve locally
serve:
	zola serve

# Build site
build:
	zola build

# Clean build artifacts
clean:
	rm -rf public
