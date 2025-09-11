# treegen-flags.ps1

# To allow running scripts
# Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

# param (
#     [string]$exclude = "node_modules|\.git|\.vscode",  # Default exclude pattern
#     [string]$outfile = "prj-struct.txt",               # Default output file
#     [string]$root = "."                                # Default root path (current directory)
# )

# Clear previous content in the output file, if it exists
# Clear-Content $outfile -ErrorAction SilentlyContinue

# treegen-flags.ps1
# ps: .\treegen-flags.ps1 -exclude "node_modules|\.git|\.vscode" -root "." > output.txt

param (
    [string]$exclude = "node_modules|\.git|\.vscode",  # Default exclude pattern
    [string]$root = "."                                # Default root path (current directory)
)

# Set output encoding to UTF-8 for correct character display
$OutputEncoding = [System.Text.Encoding]::UTF8
[console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Define a recursive function to print the directory tree
function Write-Tree {
    param (
        [string]$Path,     # Path to start from
        [int]$Depth = 0    # Current depth level (used for indentation)
    )

    # Get child items in the current path, including hidden ones (-Force)
    # Then filter out unwanted directories using regex
    $items = Get-ChildItem -LiteralPath $Path -Force |
        Where-Object {
            $_.FullName -notmatch '\\(' + $exclude + ')(\\|$)'
        } |
        # Sort folders before files, then alphabetically
        Sort-Object { !$_.PSIsContainer }, Name

    # Count how many items are in this directory
    $count = $items.Count

    # Loop through each item
    for ($i = 0; $i -lt $count; $i++) {
        $item = $items[$i]                         # Current item
        $isLast = ($i -eq $count - 1)              # Check if it's the last item in this directory
        $prefix = if ($isLast) { '└─' } else { '├─' } # Choose branch symbol based on position
        $indent = ('  ' * $Depth)                  # Create indentation based on depth level

        if ($item.PSIsContainer) {
            # If the item is a directory, write it with a trailing backslash
            "$indent$prefix $($item.Name)\"
            # Recursively call Write-Tree to list its contents
            Write-Tree -Path $item.FullName -Depth ($Depth + 1)
        } else {
            # If the item is a file, write it as-is
            "$indent$prefix $($item.Name)"
        }
    }
}

# Start generating the tree from the root path
Write-Tree -Path $root -Depth 0
