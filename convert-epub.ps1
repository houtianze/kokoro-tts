param (
    [string]$Epub,
    [float]$Speed,
    [string]$OutputDir,
    [string]$Format
)

function Convert-EpubToAudio {
    param (
        [string]$Epub,
        [float]$Speed,
        [string]$OutputDir,
        [string]$Format
    )

    # Ensure the output directory exists
    if (-not (Test-Path -Path $OutputDir)) {
        New-Item -ItemType Directory -Path $OutputDir
    }

    # Placeholder for the actual conversion logic
    Write-Output "Converting EPUB to audio with speed $Speed, output directory $OutputDir, and format $Format"
    uv run --no-sync python ./kokoro-tts $Epub --voice af_heart --speed $Speed --split-output "$OutputDir" --format $Format
    uv run --no-sync python ./kokoro-tts $Epub --merge-chunks --split-output "$OutputDir" --format $Format
}

Convert-EpubToAudio -Epub $Epub -Speed $Speed -OutputDir $OutputDir -Format $Format