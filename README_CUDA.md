To run with CUDA
================

## For the current code to use CUDA, you need to do the followings:

- On windows, Install CUDA, cuNN according to this link: https://onnxruntime.ai/docs/install/#requirements
  (NOTE: Make sure the versions of CUDA and cuNN work with each other: https://onnxruntime.ai/docs/executionoviders/CUDA-ExecutionProvider.html)
  (NOTE: You need to add the cuNN `bin` directory to the `PATH` environment variable)
- (More info here for the subsequent steps: https://github.com/nazdridoy/kokoro-tts/issues/1 )
- Export the following environment variable.
  `$env:ONNX_PROVIDER='CUDAExecutionProvider'`
- Change the dependency in `pyproject.toml` (line number 11):
  from `"kokoro-onnx>=0.3.6",`
  to: `"kokoro-onnx[gpu]>=0.3.6",`
- Run `uv sync`
- Run (It seems that till [upstream issue](https://github.com/thewh1teagle/kokoro-onnx/issues/37#issuecomment-2599868436) is fixed, unfortunately, we need to work around it this way. Otherwise, simply `uv run python ./kokoro-tts` would be sufficient):
  - `uv pip uninstall onnxruntime`
  - `uv pip install onnxruntime_gpu`
- Start the script with `uv run --no-sync python ./kokoro-tts ...`

## Sample command to convert epub files:
uv run --no-sync python ./kokoro-tts "your.epub" --voice af_heart --speed 1.33 --split-output "output_dir" --format mp3
uv run --no-sync python ./kokoro-tts "your.epub" --merge-chunks --split-output "output_dir" --format mp3

Or you simply use the `convert-epub.ps1` script:
./convert-epub.ps1 -Epub your.epub -Speed 1.33 -OutputDir output_dir -Format mp3