#! /bin/sh
# Meant to be executed from the CPIX root directory.

# Some configuration.
ROOT_DIR="$PWD"
STATIC_FILES_DIR="$ROOT_DIR/StaticFiles"
DIAGRAMS_DIR="$ROOT_DIR/Diagrams"
TOOLS_DIR="$ROOT_DIR/Tooling"
OUTPUT_DIR="$ROOT_DIR/Output"
BIKESHED_URL="https://api.csswg.org/bikeshed/"

# Clean Output directory.
echo "Creating clean Output directory..."
rm -rf "$OUTPUT_DIR"
if ! mkdir -p "$OUTPUT_DIR"; then
    echo "Could not create the output directory!"
    exit -1
fi

# Copy static files.
echo "Copying static files..."
if ! cp -v "$STATIC_FILES_DIR"/* "$OUTPUT_DIR"; then
    echo "Error copying static files!"
    exit -1
fi

# Build diagrams.
echo "Building diagrams..."
if ! java -jar "$TOOLS_DIR/plantuml.jar" -output "$OUTPUT_DIR" "$DIAGRAMS_DIR/*.wsd"; then
    echo "PlantUML error!"
    exit -1
fi

# Build HTML from Bikeshed source files.
for bikeshed_file in "$ROOT_DIR"/*.bs; do
    basename="${bikeshed_file##*/}"
    html_file="$OUTPUT_DIR/${basename%.bs}.html"
    echo "Building $html_file..."
    if ! curl "$BIKESHED_URL" -F file=@"$bikeshed_file" > "$html_file"; then
	echo "Bikeshed error!"
	exit -1
    fi
done

# Convert HTML to PDF.
for bikeshed_file in "$OUTPUT_DIR"/*.html; do
    basename="${html_file##*/}"
    pdf_file="$OUTPUT_DIR/${basename%.html}.pdf"
    echo "Converting $html_file to PDF..."
    if ! wkhtmltopdf --load-media-error-handling abort "$html_file" "$pdf_file"; then
	echo "HTML to PDF conversion error!"
	end
    fi
done

echo "Done!"
