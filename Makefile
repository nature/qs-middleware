
# Color helpers
C_CYAN=\x1b[34;01m
C_RESET=\x1b[0m

# Group targets
all: deps lint test
ci: lint test

# Install dependencies
deps:
	@echo "$(C_CYAN)> installing dependencies$(C_RESET)"
	@npm install

# Lint JavaScript & CSS
lint:
	@echo "$(C_CYAN)> linting$(C_RESET)"
	@./node_modules/.bin/xo

# Run all tests
test: test-coverage

# Run unit tests
test-unit:
	@echo "$(C_CYAN)> running unit tests$(C_RESET)"
	@./node_modules/.bin/mocha ./test/unit --reporter spec --recursive --timeout 200 --slow 50

# Run unit tests with coverage
test-coverage:
	@echo "$(C_CYAN)> running unit tests with coverage$(C_RESET)"
	@./node_modules/.bin/istanbul cover node_modules/mocha/bin/_mocha -- ./test/unit --reporter spec --recursive
	@./node_modules/.bin/istanbul check-coverage --statement 90 --branch 90 --function 90

.PHONY: test
