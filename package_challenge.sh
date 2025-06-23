#!/bin/bash

# Rails Interview Challenge Packaging Script
# Creates a clean candidate package without internal files

set -e

echo "🚀 Packaging Rails Interview Challenge..."

# Configuration
PACKAGE_NAME="rails_interview_challenge"
ARCHIVE_NAME="${PACKAGE_NAME}_$(date +%Y%m%d_%H%M%S).tar.bz2"
TEMP_DIR="/tmp/${PACKAGE_NAME}_temp"

# Clean up any existing temp directory
rm -rf "$TEMP_DIR"
mkdir -p "$TEMP_DIR"

echo "📦 Copying application files..."

# Copy all files except excluded ones
rsync -av \
  --exclude='.git*' \
  --exclude='.DS_Store' \
  --exclude='*.log' \
  --exclude='tmp/' \
  --exclude='log/' \
  --exclude='storage/' \
  --exclude='node_modules/' \
  --exclude='coverage/' \
  --exclude='.byebug_history' \
  --exclude='solutions.md' \
  --exclude='package_challenge.sh' \
  --exclude='*.tar.bz2' \
  --exclude='README.md' \
  ./ "$TEMP_DIR/"

echo "📝 Setting up candidate README..."

# Replace README.md with challenge instructions
cp challenge.md "$TEMP_DIR/README.md"

echo "🧹 Cleaning up candidate package..."

# Remove any remaining internal files
rm -f "$TEMP_DIR/challenge.md"
rm -f "$TEMP_DIR/solutions.md"

# Clean Rails temporary files
rm -rf "$TEMP_DIR/tmp"
rm -rf "$TEMP_DIR/log"
rm -rf "$TEMP_DIR/storage"

# Clean database files
rm -f "$TEMP_DIR/db/*.sqlite3"
rm -f "$TEMP_DIR/db/*.sqlite3-*"

# Clean any compiled assets
rm -rf "$TEMP_DIR/public/assets"

echo "📋 Creating package contents manifest..."

# Create a manifest file for transparency
cat > "$TEMP_DIR/PACKAGE_CONTENTS.md" << EOF
# Rails Interview Challenge Package

This package contains a complete Rails application for the interview challenge.

## Contents:
- Complete Rails 8 application
- Docker setup for easy development
- Pre-configured database with sample data
- All necessary configuration files
- Interview instructions in README.md

## What's NOT included:
- Git history (clean start for candidate)
- Log files and temporary data
- Internal solutions documentation
- Development artifacts

## Quick Start:
See README.md for complete setup instructions.

**Generated:** $(date)
**Package:** $ARCHIVE_NAME
EOF

echo "🗜️ Creating compressed archive..."

# Create the archive
cd "$TEMP_DIR"
tar -cjf "../$ARCHIVE_NAME" .
cd - > /dev/null

# Move archive to current directory
mv "/tmp/$ARCHIVE_NAME" "./$ARCHIVE_NAME"

echo "🧹 Cleaning up temporary files..."
rm -rf "$TEMP_DIR"

echo "✅ Package created successfully!"
echo ""
echo "📦 Archive: ./$ARCHIVE_NAME"
echo "📏 Size: $(du -h "$ARCHIVE_NAME" | cut -f1)"
echo ""
echo "🎯 Ready to send to candidate!"
echo ""
echo "📋 Candidate instructions:"
echo "   1. Extract: tar -xjf $ARCHIVE_NAME"
echo "   2. Read: README.md"
echo "   3. Start coding!"
echo ""

# Verify archive contents
echo "📑 Archive contents preview:"
echo "$(tar -tjf "$ARCHIVE_NAME" | head -20)"
if [ "$(tar -tjf "$ARCHIVE_NAME" | wc -l)" -gt 20 ]; then
    echo "   ... and $(( $(tar -tjf "$ARCHIVE_NAME" | wc -l) - 20 )) more files"
fi
echo ""

# Security check - make sure no solutions are included
echo "🔍 Security check - verifying no solutions included..."
if tar -tjf "$ARCHIVE_NAME" | grep -q "solutions"; then
    echo "❌ WARNING: Solutions file found in archive!"
    exit 1
else
    echo "✅ No solutions found - package is clean"
fi

echo ""
echo "🎉 Package ready for candidate delivery!"
