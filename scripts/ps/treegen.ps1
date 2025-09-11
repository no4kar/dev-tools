# show-prj-struct.ps1
# run in goal folder 
# PS: .\show-structure.ps1

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
            $_.FullName -notmatch '\\(node_modules|\.git|\.vscode|__test__)(\\|$)'
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
            "$indent$prefix $($item.Name)\" | Out-File -FilePath prj-struct.txt -Append
            # Recursively call Write-Tree to list its contents
            Write-Tree -Path $item.FullName -Depth ($Depth + 1)
        } else {
            # If the item is a file, write it as-is
            "$indent$prefix $($item.Name)" | Out-File -FilePath prj-struct.txt -Append
        }
    }
}

# Clear previous content in the output file, if it exists
Clear-Content prj-struct.txt -ErrorAction SilentlyContinue

# Start generating the tree from the current directory
Write-Tree -Path "." -Depth 0
