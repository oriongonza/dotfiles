#!/bin/bash
# Neovim Configuration Integration Test Runner

echo "Running Neovim Configuration Integration Tests..."
echo ""

cd "$(dirname "$0")"

# Run the test in headless mode
nvim --headless -u init.lua -c "luafile test_config.lua" 2>&1

exit_code=$?

if [ $exit_code -eq 0 ]; then
    echo ""
    echo "✓ Test suite completed successfully!"
    exit 0
else
    echo ""
    echo "✗ Test suite failed with errors."
    exit 1
fi
