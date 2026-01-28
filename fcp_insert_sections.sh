#!/bin/bash

################################################################################
# FCP_DCC PostgreSQL MediaWiki Database Insert Script
# Purpose: Insert Orange, Purple, Red, and Teal section pages into mediawiki
# Database: PostgreSQL on postgresqljail (192.168.2.30)
# Author: Claude Code
# Date: 2026-01-28
################################################################################

# Configuration
DB_HOST="${DB_HOST:-192.168.2.30}"
DB_PORT="${DB_PORT:-5432}"
DB_NAME="${DB_NAME:-mediawiki}"
DB_USER="${DB_USER:-postgres}"
DB_PASSWORD="${DB_PASSWORD:-rash4z4m!}"

# Starting IDs
TEXT_ID_START=225
PAGE_ID_START=122
REVISION_ID_START=1000

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

################################################################################
# Function: Log message with color
################################################################################
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[OK]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

################################################################################
# Function: Escape single quotes for SQL
################################################################################
escape_sql() {
    echo "$1" | sed "s/'/''/g"
}

################################################################################
# Function: Get current timestamp for MediaWiki
################################################################################
get_timestamp() {
    date -u +"%Y%m%d%H%M%S"
}

################################################################################
# Function: Create page content with Know/Do/Show sections
################################################################################
create_page_content() {
    local page_name="$1"
    local section_name="$2"
    local color="$3"
    
    cat << EOF
= Know =

This section covers the key principles for $page_name.

== Key Points ==
* Understanding the importance of $page_name
* Best practices and guidelines
* Compliance requirements

= Do =

== Practical Steps ==
1. Review procedures for $page_name
2. Follow all applicable regulations
3. Document and record actions taken
4. Report any issues or concerns

= Show =

== Evidence of Compliance ==
* Documentation of $page_name procedures
* Training records
* Implementation logs
* Audit trails
* Inspection results

== Related Pages ==
* [[Category:$section_name|$section_name]]
* [[FCP:Main|Back to FCP Main]]

[[Category:FCP]]
[[Category:$section_name]]
EOF
}

################################################################################
# Function: Generate SQL for text table insertion
################################################################################
insert_text() {
    local text_id="$1"
    local content="$2"
    
    local escaped_content=$(escape_sql "$content")
    
    cat << EOF
INSERT INTO mediawiki.text (old_id, old_text, old_flags) VALUES 
($text_id, '$escaped_content', 'utf-8');
EOF
}

################################################################################
# Function: Generate SQL for content table insertion
################################################################################
insert_content() {
    local content_id="$1"
    local text_id="$2"
    
    cat << EOF
INSERT INTO mediawiki.content (content_id, content_size, content_sha1, content_model, content_address) VALUES 
($content_id, (SELECT LENGTH(old_text) FROM mediawiki.text WHERE old_id = $text_id), 
 SHA1((SELECT old_text FROM mediawiki.text WHERE old_id = $text_id)::bytea), 
 'wikitext', 'tt:$text_id');
EOF
}

################################################################################
# Function: Generate SQL for revision table insertion
################################################################################
insert_revision() {
    local rev_id="$1"
    local page_id="$2"
    local timestamp="$3"
    local user_id="${4:-1}"
    local content_id="$5"
    
    cat << EOF
INSERT INTO mediawiki.revision (rev_id, rev_page, rev_timestamp, rev_user, rev_minor_edit, rev_deleted, rev_len, rev_parent_id, rev_sha1, rev_content_model, rev_content_format) VALUES 
($rev_id, $page_id, '$timestamp', $user_id, 0, 0, NULL, NULL, '', 'wikitext', 'text/x-wiki');
EOF
}

################################################################################
# Function: Generate SQL for slots table insertion
################################################################################
insert_slots() {
    local slot_id="$1"
    local revision_id="$2"
    local content_id="$3"
    
    cat << EOF
INSERT INTO mediawiki.slots (slot_revision_id, slot_role_id, slot_content_id, slot_origin) VALUES 
($revision_id, 1, $content_id, $revision_id);
EOF
}

################################################################################
# Function: Generate SQL for page table insertion
################################################################################
insert_page() {
    local page_id="$1"
    local page_title="$2"
    local namespace="${3:-0}"
    local is_redirect="${4:-0}"
    local is_new="${5:-1}"
    local latest_rev="$6"
    local len="${7:-0}"
    
    local escaped_title=$(escape_sql "$page_title")
    
    cat << EOF
INSERT INTO mediawiki.page (page_id, page_namespace, page_title, page_is_redirect, page_is_new, page_latest, page_len) VALUES 
($page_id, $namespace, '$escaped_title', $is_redirect, $is_new, $latest_rev, $len);
EOF
}

################################################################################
# Function: Generate SQL for page_props table (for SMW)
################################################################################
insert_page_props() {
    local page_id="$1"
    local prop_name="$2"
    local prop_value="$3"
    
    local escaped_value=$(escape_sql "$prop_value")
    
    cat << EOF
INSERT INTO mediawiki.page_props (pp_page, pp_propname, pp_value) VALUES 
($page_id, '$prop_name', '$escaped_value');
EOF
}

################################################################################
# Function: Process a single page and output SQL
################################################################################
process_page() {
    local page_title="$1"
    local section_name="$2"
    local color="$3"
    local text_id="$4"
    local page_id="$5"
    local revision_id="$6"
    local slot_id="$7"
    
    # Extract readable name from title
    local readable_name=$(echo "$page_title" | sed 's/_/ /g' | sed 's/FCP://')
    
    # Create page content
    local content=$(create_page_content "$readable_name" "$section_name" "$color")
    
    # Generate SQL statements
    echo ""
    echo "-- ============================================================================"
    echo "-- Page: $page_title"
    echo "-- Section: $section_name ($color)"
    echo "-- IDs: Text=$text_id, Page=$page_id, Revision=$revision_id"
    echo "-- ============================================================================"
    echo ""
    
    # 1. Insert text content
    insert_text "$text_id" "$content"
    echo ""
    
    # 2. Insert content metadata
    insert_content "$text_id" "$text_id"
    echo ""
    
    # 3. Insert revision
    local timestamp=$(get_timestamp)
    insert_revision "$revision_id" "$page_id" "$timestamp" "1" "$text_id"
    echo ""
    
    # 4. Insert slots linking
    insert_slots "$slot_id" "$revision_id" "$text_id"
    echo ""
    
    # 5. Insert page record with FCP namespace (6)
    # Extract just the title part after the last colon
    local title_only=$(echo "$page_title" | sed 's/^.*://')
    insert_page "$page_id" "$title_only" "6" "0" "1" "$revision_id"
    echo ""
    
    # 6. Insert SMW properties
    insert_page_props "$page_id" "smw_id" "$page_id"
    echo ""
}

################################################################################
# Main execution
################################################################################

main() {
    local text_id=$TEXT_ID_START
    local page_id=$PAGE_ID_START
    local revision_id=$REVISION_ID_START
    local slot_id=500
    
    cat << EOFSQL
-- ============================================================================
-- FCP_DCC MediaWiki Database Insert Script
-- Purpose: Insert Orange, Purple, Red, and Teal section pages
-- Database: mediawiki on postgresqljail (192.168.2.30)
-- Generated: $(date)
-- ============================================================================

-- Start transaction
BEGIN;

-- ============================================================================
-- ORANGE SECTION - Serving & Selling (6 pages)
-- Color Code: Orange
-- ============================================================================

EOFSQL

    # Process Orange section (6 pages)
    process_page "FCP:Serving_Selling:Keeping_food_hot" "Serving_Selling" "Orange" "$text_id" "$page_id" "$revision_id" "$slot_id"
    ((text_id++)); ((page_id++)); ((revision_id++)); ((slot_id++))
    
    process_page "FCP:Serving_Selling:Transporting_food" "Serving_Selling" "Orange" "$text_id" "$page_id" "$revision_id" "$slot_id"
    ((text_id++)); ((page_id++)); ((revision_id++)); ((slot_id++))
    
    process_page "FCP:Serving_Selling:Displaying_food" "Serving_Selling" "Orange" "$text_id" "$page_id" "$revision_id" "$slot_id"
    ((text_id++)); ((page_id++)); ((revision_id++)); ((slot_id++))
    
    process_page "FCP:Serving_Selling:Allergens" "Serving_Selling" "Orange" "$text_id" "$page_id" "$revision_id" "$slot_id"
    ((text_id++)); ((page_id++)); ((revision_id++)); ((slot_id++))
    
    process_page "FCP:Serving_Selling:Labelling" "Serving_Selling" "Orange" "$text_id" "$page_id" "$revision_id" "$slot_id"
    ((text_id++)); ((page_id++)); ((revision_id++)); ((slot_id++))
    
    process_page "FCP:Serving_Selling:B2B" "Serving_Selling" "Orange" "$text_id" "$page_id" "$revision_id" "$slot_id"
    ((text_id++)); ((page_id++)); ((revision_id++)); ((slot_id++))
    
    cat << EOFSQL

-- ============================================================================
-- PURPLE SECTION - Closing (2 pages)
-- Color Code: Purple
-- ============================================================================

EOFSQL

    # Process Purple section (2 pages)
    process_page "FCP:Closing:Cleaning_up_and_closing" "Closing" "Purple" "$text_id" "$page_id" "$revision_id" "$slot_id"
    ((text_id++)); ((page_id++)); ((revision_id++)); ((slot_id++))
    
    process_page "FCP:Closing:Maintaining_equipment" "Closing" "Purple" "$text_id" "$page_id" "$revision_id" "$slot_id"
    ((text_id++)); ((page_id++)); ((revision_id++)); ((slot_id++))
    
    cat << EOFSQL

-- ============================================================================
-- RED SECTION - Troubleshooting (4 pages)
-- Color Code: Red
-- ============================================================================

EOFSQL

    # Process Red section (4 pages)
    process_page "FCP:Troubleshooting:When_something_goes_wrong" "Troubleshooting" "Red" "$text_id" "$page_id" "$revision_id" "$slot_id"
    ((text_id++)); ((page_id++)); ((revision_id++)); ((slot_id++))
    
    process_page "FCP:Troubleshooting:Customer_complaints" "Troubleshooting" "Red" "$text_id" "$page_id" "$revision_id" "$slot_id"
    ((text_id++)); ((page_id++)); ((revision_id++)); ((slot_id++))
    
    process_page "FCP:Troubleshooting:Tracing_your_food" "Troubleshooting" "Red" "$text_id" "$page_id" "$revision_id" "$slot_id"
    ((text_id++)); ((page_id++)); ((revision_id++)); ((slot_id++))
    
    process_page "FCP:Troubleshooting:Recalling_your_food" "Troubleshooting" "Red" "$text_id" "$page_id" "$revision_id" "$slot_id"
    ((text_id++)); ((page_id++)); ((revision_id++)); ((slot_id++))
    
    cat << EOFSQL

-- ============================================================================
-- TEAL SECTION - Specialist Cooking Methods (6 pages)
-- Color Code: Teal
-- ============================================================================

EOFSQL

    # Process Teal section (6 pages)
    process_page "FCP:Specialist:Making_sushi" "Specialist" "Teal" "$text_id" "$page_id" "$revision_id" "$slot_id"
    ((text_id++)); ((page_id++)); ((revision_id++)); ((slot_id++))
    
    process_page "FCP:Specialist:Chinese_roast_duck" "Specialist" "Teal" "$text_id" "$page_id" "$revision_id" "$slot_id"
    ((text_id++)); ((page_id++)); ((revision_id++)); ((slot_id++))
    
    process_page "FCP:Specialist:Doner_kebabs" "Specialist" "Teal" "$text_id" "$page_id" "$revision_id" "$slot_id"
    ((text_id++)); ((page_id++)); ((revision_id++)); ((slot_id++))
    
    process_page "FCP:Specialist:Sous_vide" "Specialist" "Teal" "$text_id" "$page_id" "$revision_id" "$slot_id"
    ((text_id++)); ((page_id++)); ((revision_id++)); ((slot_id++))
    
    process_page "FCP:Specialist:Preparing_red_meat" "Specialist" "Teal" "$text_id" "$page_id" "$revision_id" "$slot_id"
    ((text_id++)); ((page_id++)); ((revision_id++)); ((slot_id++))
    
    process_page "FCP:Specialist:Making_biltong" "Specialist" "Teal" "$text_id" "$page_id" "$revision_id" "$slot_id"
    ((text_id++)); ((page_id++)); ((revision_id++)); ((slot_id++))
    
    cat << EOFSQL

-- ============================================================================
-- Summary: 18 pages inserted (6 Orange + 2 Purple + 4 Red + 6 Teal)
-- Starting IDs:
--   Text ID: $TEXT_ID_START
--   Page ID: $PAGE_ID_START
--   Revision ID: $REVISION_ID_START
-- Ending IDs:
--   Text ID: $((text_id - 1))
--   Page ID: $((page_id - 1))
--   Revision ID: $((revision_id - 1))
-- ============================================================================

-- Commit transaction
COMMIT;

-- Verify insertions
SELECT COUNT(*) as page_count FROM mediawiki.page WHERE page_namespace = 6 AND page_id >= $PAGE_ID_START;
SELECT COUNT(*) as text_count FROM mediawiki.text WHERE old_id >= $TEXT_ID_START;

EOFSQL
}

# Run main function
main "$@"

