param (
    [string]$Epub,
    [float]$Speed,
    [string]$OutputDir,
    [string]$Format,
    [string]$Voice
)

function Convert-EpubToAudio {
    param (
        [string]$Epub,
        [float]$Speed = 1,
        [string]$OutputDir = "output",
        [string]$Format = "mp3",
        [string]$Voice = "af_heart"
    )

    # Check if Epub is defined
    if (-not $Epub) {
        Write-Warning "Epub parameter is not provided. Exiting script."
        Write-Output "Usage: .\convert-epub.ps1 -Epub <path_to_epub> [-Speed <speed> (default: 1)] [-OutputDir <output_directory> (default: output)] [-Format <format> (default: mp3)] [-Voice <voice> (default: af_heart)]"
        exit
    }

    # Ensure the output directory exists
    if (-not (Test-Path -Path $OutputDir)) {
        New-Item -ItemType Directory -Path $OutputDir
    }

    # Placeholder for the actual conversion logic
    Write-Output "Converting EPUB to audio with speed $Speed, output directory $OutputDir, and format $Format"
    uv run --no-sync python ./kokoro-tts $Epub --voice $Voice --speed $Speed --split-output "$OutputDir" --format $Format
    uv run --no-sync python ./kokoro-tts $Epub --merge-chunks --split-output "$OutputDir" --format $Format
}

Convert-EpubToAudio -Epub $Epub -Speed $Speed -OutputDir $OutputDir -Format $Format